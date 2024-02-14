#include <rive/file.hpp>
#include <rive/node.hpp>
#include <rive/shapes/clipping_shape.hpp>
#include <rive/shapes/rectangle.hpp>
#include <rive/shapes/shape.hpp>
#include <utils/no_op_renderer.hpp>
#include "rive_file_reader.hpp"
#include <catch.hpp>
#include <cstdio>

TEST_CASE("clipping loads correctly", "[clipping]")
{
    auto file = ReadRiveFile("../../test/assets/circle_clips.riv");

    auto node = file->artboard()->find("TopEllipse");
    REQUIRE(node != nullptr);
    REQUIRE(node->is<rive::Shape>());

    auto shape = node->as<rive::Shape>();
    REQUIRE(shape->clippingShapes().size() == 2);
    REQUIRE(shape->clippingShapes()[0]->source()->name() == "ClipRect2");
    REQUIRE(shape->clippingShapes()[1]->source()->name() == "BabyEllipse");

    file->artboard()->updateComponents();

    rive::NoOpRenderer renderer;
    file->artboard()->draw(&renderer);
}

class ClipTestRenderPath : public rive::RenderPath
{
public:
    rive::RawPath rawPath;
    ClipTestRenderPath(rive::RawPath& path) : rawPath(path) {}

    void rewind() override {}

    void fillRule(rive::FillRule value) override {}
    void addPath(rive::CommandPath* path, const rive::Mat2D& transform) override {}
    void addRenderPath(rive::RenderPath* path, const rive::Mat2D& transform) override {}

    void moveTo(float x, float y) override {}
    void lineTo(float x, float y) override {}
    void cubicTo(float ox, float oy, float ix, float iy, float x, float y) override {}
    void close() override {}
};

class ClippingFactory : public rive::NoOpFactory
{
    std::unique_ptr<rive::RenderPath> makeRenderPath(rive::RawPath& rawPath,
                                                     rive::FillRule) override
    {
        return rivestd::make_unique<ClipTestRenderPath>(rawPath);
    }
};

TEST_CASE("artboard is clipped correctly", "[clipping]")
{
    ClippingFactory factory;
    auto file = ReadRiveFile("../../test/assets/artboardclipping.riv", &factory);

    auto artboard = file->artboard("Center");
    REQUIRE(artboard != nullptr);
    artboard->updateComponents();
    REQUIRE(artboard->originX() == 0.5);
    REQUIRE(artboard->originY() == 0.5);
    {
        auto clipPath = static_cast<ClipTestRenderPath*>(artboard->clipPath());
        auto points = clipPath->rawPath.points();
        REQUIRE(points.size() == 4);

        REQUIRE(points[0] == rive::Vec2D(0.0f, 0.0f));
        REQUIRE(points[1] == rive::Vec2D(500.0f, 0.0f));
        REQUIRE(points[2] == rive::Vec2D(500.0f, 500.0f));
        REQUIRE(points[3] == rive::Vec2D(0.0f, 500.0f));
    }
    // Now disable framing the origin so that the points are in origin space.
    artboard->frameOrigin(false);
    artboard->updateComponents();
    {
        auto clipPath = static_cast<ClipTestRenderPath*>(artboard->clipPath());
        auto points = clipPath->rawPath.points();
        REQUIRE(points.size() == 4);

        REQUIRE(points[0] == rive::Vec2D(-250.0f, -250.0f));
        REQUIRE(points[1] == rive::Vec2D(250.0f, -250.0f));
        REQUIRE(points[2] == rive::Vec2D(250.0f, 250.0f));
        REQUIRE(points[3] == rive::Vec2D(-250.0f, 250.0f));
    }
}
