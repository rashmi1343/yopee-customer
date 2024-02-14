#include "hb-ot.h"
#include "hb.h"
#include "rive/text/font_hb.hpp"

#include <emscripten.h>
#include <emscripten/bind.h>
#include <emscripten/val.h>
#include <stdint.h>
#include <stdio.h>

using namespace emscripten;

using WasmPtr = uint32_t;

WasmPtr makeFont(emscripten::val byteArray)
{
    std::vector<unsigned char> bytes;

    const auto l = byteArray["byteLength"].as<unsigned>();
    bytes.resize(l);

    emscripten::val memoryView{emscripten::typed_memory_view(l, bytes.data())};
    memoryView.call<void>("set", byteArray);
    auto result = HBFont::Decode(bytes);
    if (result)
    {
        return (WasmPtr)result.release();
    }
    return (WasmPtr) nullptr;
}

void deleteFont(WasmPtr font) { reinterpret_cast<HBFont*>(font)->unref(); }

uint16_t fontAxisCount(WasmPtr ptr)
{
    HBFont* font = reinterpret_cast<HBFont*>(ptr);
    return (uint16_t)font->getAxisCount();
}

rive::Font::Axis fontAxis(WasmPtr ptr, uint16_t index)
{
    HBFont* font = reinterpret_cast<HBFont*>(ptr);
    return font->getAxis(index);
}

float fontAxisValue(WasmPtr ptr, uint32_t axisTag)
{
    HBFont* font = reinterpret_cast<HBFont*>(ptr);
    return font->getAxisValue(axisTag);
}

struct GlyphPath
{
    WasmPtr rawPath;
    WasmPtr points;
    WasmPtr verbs;
    uint16_t verbCount;
};

GlyphPath makeGlyphPath(WasmPtr fontPtr, rive::GlyphID id)
{
    auto font = reinterpret_cast<HBFont*>(fontPtr);
    rive::RawPath* path = new rive::RawPath(font->getPath(id));

    return {
        .rawPath = (WasmPtr)path,
        .points = (WasmPtr)path->points().data(),
        .verbs = (WasmPtr)path->verbs().data(),
        .verbCount = (uint16_t)path->verbs().size(),
    };
}

void deleteGlyphPath(WasmPtr rawPath) { delete reinterpret_cast<rive::RawPath*>(rawPath); }

void deleteShapeResult(WasmPtr shaperResult)
{
    delete reinterpret_cast<rive::SimpleArray<rive::Paragraph>*>(shaperResult);
}

WasmPtr breakLines(WasmPtr paragraphsPtr, float width, uint8_t align)
{
    bool autoWidth = width == -1.0f;
    auto paragraphs = reinterpret_cast<rive::SimpleArray<rive::Paragraph>*>(paragraphsPtr);
    float paragraphWidth = width;

    rive::SimpleArrayBuilder<uint16_t> paragraphLines;

    rive::SimpleArray<rive::SimpleArray<rive::GlyphLine>>* lines =
        new rive::SimpleArray<rive::SimpleArray<rive::GlyphLine>>(paragraphs->size());
    rive::SimpleArray<rive::SimpleArray<rive::GlyphLine>>& linesRef = *lines;
    size_t paragraphIndex = 0;
    for (auto& para : *paragraphs)
    {
        linesRef[paragraphIndex] =
            rive::GlyphLine::BreakLines(para.runs, autoWidth ? -1.0f : width);
        if (autoWidth)
        {
            paragraphWidth =
                std::max(paragraphWidth,
                         rive::GlyphLine::ComputeMaxWidth(linesRef[paragraphIndex], para.runs));
        }
        paragraphIndex++;
    }
    paragraphIndex = 0;
    for (auto& para : *paragraphs)
    {
        rive::GlyphLine::ComputeLineSpacing(paragraphIndex == 0,
                                            linesRef[paragraphIndex],
                                            para.runs,
                                            paragraphWidth,
                                            (rive::TextAlign)align);
        paragraphIndex++;
    }
    return (WasmPtr)lines;
}

void deleteLines(WasmPtr lines)
{
    delete reinterpret_cast<rive::SimpleArray<rive::SimpleArray<rive::GlyphLine>>*>(lines);
}

WasmPtr fontFeatures(WasmPtr fontPtr)
{
    auto font = reinterpret_cast<HBFont*>(fontPtr);
    if (font == nullptr)
    {
        return (WasmPtr) nullptr;
    }

    return (WasmPtr) new rive::SimpleArray<uint32_t>(font->features());
}

float fontAscent(WasmPtr fontPtr)
{
    auto font = reinterpret_cast<HBFont*>(fontPtr);
    if (font == nullptr)
    {
        return 0.0f;
    }
    return font->lineMetrics().ascent;
}

float fontDescent(WasmPtr fontPtr)
{
    auto font = reinterpret_cast<HBFont*>(fontPtr);
    if (font == nullptr)
    {
        return 0.0f;
    }
    return font->lineMetrics().descent;
}

void deleteFontFeatures(WasmPtr features)
{
    delete reinterpret_cast<rive::SimpleArray<uint32_t>*>(features);
}

std::vector<rive::Font*> fallbackFonts;

void setFallbackFonts(emscripten::val fontsList)
{
    std::vector<int> fonts(fontsList["length"].as<unsigned>());
    {
        emscripten::val memoryView{emscripten::typed_memory_view(fonts.size(), fonts.data())};
        memoryView.call<void>("set", fontsList);
    }

    fallbackFonts = std::vector<rive::Font*>();
    for (auto fontPtr : fonts)
    {
        fallbackFonts.push_back(reinterpret_cast<rive::Font*>(fontPtr));
    }
}

static rive::rcp<rive::Font> pickFallbackFont(rive::Span<const rive::Unichar> missing)
{
    size_t length = fallbackFonts.size();
    for (size_t i = 0; i < length; i++)
    {
        HBFont* font = static_cast<HBFont*>(fallbackFonts[i]);
        if (font->hasGlyph(missing))
        {
            rive::rcp<rive::Font> rcFont = rive::rcp<rive::Font>(font);
            // because the font was released at load time, we need to give it an
            // extra ref whenever we bump it to a reference counted pointer.
            rcFont->ref();
            return rcFont;
        }
    }
    return nullptr;
}

WasmPtr shapeText(emscripten::val codeUnits, emscripten::val runsList)
{
    std::vector<uint8_t> runsBytes(runsList["byteLength"].as<unsigned>());
    {
        emscripten::val memoryView{
            emscripten::typed_memory_view(runsBytes.size(), runsBytes.data())};
        memoryView.call<void>("set", runsList);
    }
    std::vector<uint32_t> codeUnitArray(codeUnits["length"].as<unsigned>());
    {
        emscripten::val memoryView{
            emscripten::typed_memory_view(codeUnitArray.size(), codeUnitArray.data())};
        memoryView.call<void>("set", codeUnits);
    }

    auto runCount = runsBytes.size() / sizeof(rive::TextRun);
    rive::TextRun* runs = reinterpret_cast<rive::TextRun*>(runsBytes.data());

    if (runCount > 0)
    {
        auto result = (WasmPtr) new rive::SimpleArray<rive::Paragraph>(
            runs[0].font->shapeText(codeUnitArray, rive::Span<rive::TextRun>(runs, runCount)));
        return result;
    }
    return {};
}

WasmPtr makeFontWithOptions(WasmPtr fontPtr,
                            emscripten::val coordsList,
                            emscripten::val featuresList)
{
    std::vector<uint8_t> coordsBytes(coordsList["byteLength"].as<unsigned>());
    {
        emscripten::val memoryView{
            emscripten::typed_memory_view(coordsBytes.size(), coordsBytes.data())};
        memoryView.call<void>("set", coordsList);
    }
    auto coordsCount = coordsBytes.size() / sizeof(rive::Font::Coord);
    rive::Font::Coord* coords = reinterpret_cast<rive::Font::Coord*>(coordsBytes.data());

    std::vector<uint8_t> featuresBytes(featuresList["byteLength"].as<unsigned>());
    {
        emscripten::val memoryView{
            emscripten::typed_memory_view(featuresBytes.size(), featuresBytes.data())};
        memoryView.call<void>("set", featuresList);
    }
    auto featuresCount = featuresBytes.size() / sizeof(rive::Font::Feature);
    rive::Font::Feature* features = reinterpret_cast<rive::Font::Feature*>(featuresBytes.data());

    HBFont* font = reinterpret_cast<HBFont*>(fontPtr);
    auto variableFont = font->withOptions(rive::Span<rive::Font::Coord>(coords, coordsCount),
                                          rive::Span<rive::Font::Feature>(features, featuresCount));
    if (variableFont != nullptr)
    {
        return (WasmPtr)variableFont.release();
    }
    return (WasmPtr) nullptr;
}

void init()
{
    fallbackFonts.clear();
    rive::Font::gFallbackProc = pickFallbackFont;
}

#ifdef DEBUG
#define OFFSET_OF(type, member) ((int)(intptr_t) & (((type*)(void*)0)->member))
void assertSomeAssumptions()
{
    // These assumptions are important as our rive_text_wasm.dart integration
    // relies on knowing the exact offsets of these struct elements. When and if
    // we ever move to the proposed Wasm64 (currently not a standard), we'll
    // need to make adjustements here.
    assert(sizeof(rive::TextRun) == 28);
    assert(OFFSET_OF(rive::TextRun, font) == 0);
    assert(OFFSET_OF(rive::TextRun, size) == 4);
    assert(OFFSET_OF(rive::TextRun, lineHeight) == 8);
    assert(OFFSET_OF(rive::TextRun, letterSpacing) == 12);
    assert(OFFSET_OF(rive::TextRun, unicharCount) == 16);
    assert(OFFSET_OF(rive::TextRun, script) == 20);
    assert(OFFSET_OF(rive::TextRun, styleId) == 24);
    assert(OFFSET_OF(rive::TextRun, dir) == 26);

    assert(sizeof(rive::Paragraph) == 12);
    assert(OFFSET_OF(rive::Paragraph, runs) == 0);
    assert(OFFSET_OF(rive::Paragraph, baseDirection) == 8);

    assert(sizeof(rive::GlyphRun) == 68);
    assert(OFFSET_OF(rive::GlyphRun, font) == 0);
    assert(OFFSET_OF(rive::GlyphRun, size) == 4);
    assert(OFFSET_OF(rive::GlyphRun, lineHeight) == 8);
    assert(OFFSET_OF(rive::GlyphRun, letterSpacing) == 12);
    assert(OFFSET_OF(rive::GlyphRun, glyphs) == 16);
    assert(OFFSET_OF(rive::GlyphRun, textIndices) == 24);
    assert(OFFSET_OF(rive::GlyphRun, advances) == 32);
    assert(OFFSET_OF(rive::GlyphRun, xpos) == 40);
    assert(OFFSET_OF(rive::GlyphRun, offsets) == 48);
    assert(OFFSET_OF(rive::GlyphRun, breaks) == 56);
    assert(OFFSET_OF(rive::GlyphRun, styleId) == 64);
    assert(OFFSET_OF(rive::GlyphRun, dir) == 66);

    assert(sizeof(rive::GlyphLine) == 32);
}
#endif

EMSCRIPTEN_BINDINGS(RiveText)
{
    function("makeFont", &makeFont, allow_raw_pointers());
    function("deleteFont", &deleteFont);

    value_array<rive::Font::Axis>("FontAxis")
        .element(&rive::Font::Axis::tag)
        .element(&rive::Font::Axis::min)
        .element(&rive::Font::Axis::def)
        .element(&rive::Font::Axis::max);

    value_array<GlyphPath>("GlyphPath")
        .element(&GlyphPath::rawPath)
        .element(&GlyphPath::points)
        .element(&GlyphPath::verbs)
        .element(&GlyphPath::verbCount);

    function("fontAxisCount", &fontAxisCount);
    function("fontAxis", &fontAxis);
    function("fontAxisValue", &fontAxisValue);
    function("makeFontWithOptions", &makeFontWithOptions);
    function("fontFeatures", &fontFeatures);
    function("deleteFontFeatures", &deleteFontFeatures);

    function("fontAscent", &fontAscent);
    function("fontDescent", &fontDescent);

    function("makeGlyphPath", &makeGlyphPath);
    function("deleteGlyphPath", &deleteGlyphPath);

    function("shapeText", &shapeText);
    function("setFallbackFonts", &setFallbackFonts);
    function("deleteShapeResult", &deleteShapeResult);

    function("breakLines", &breakLines);
    function("deleteLines", &deleteLines);
    function("init", &init);

#ifdef DEBUG
    function("assertSomeAssumptions", &assertSomeAssumptions);
#endif
}