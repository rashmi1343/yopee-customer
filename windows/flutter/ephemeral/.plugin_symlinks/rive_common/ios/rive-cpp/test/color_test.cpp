#include "rive/shapes/paint/color.hpp"

#include <catch.hpp>

TEST_CASE("unpacking", "[color]")
{
    rive::ColorInt color = 0x12345678;
    uint8_t rgba[4];
    rive::UnpackColorToRGBA8(color, rgba);
    CHECK(rgba[0] == rive::colorRed(color));
    CHECK(rgba[1] == rive::colorGreen(color));
    CHECK(rgba[2] == rive::colorBlue(color));
    CHECK(rgba[3] == rive::colorAlpha(color));

    float color4f[4];
    rive::UnpackColorToRGBA32F(color, color4f);
    CHECK(color4f[0] == Approx(rive::colorRed(color) / 255.f));
    CHECK(color4f[1] == Approx(rive::colorGreen(color) / 255.f));
    CHECK(color4f[2] == Approx(rive::colorBlue(color) / 255.f));
    CHECK(color4f[3] == Approx(rive::colorAlpha(color) / 255.f));

    float color4fPremul[4];
    rive::UnpackColorToRGBA32FPremul(color, color4fPremul);
    CHECK(color4fPremul[0] == Approx(color4f[0] * color4f[3]));
    CHECK(color4fPremul[1] == Approx(color4f[1] * color4f[3]));
    CHECK(color4fPremul[2] == Approx(color4f[2] * color4f[3]));
    CHECK(color4fPremul[3] == Approx(color4f[3]));
}
