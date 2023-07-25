import 'package:hello_there/all_utils.dart';

class ColorGenerator {
  // Define constraints for HSL color space
  static const int minHue = 0; // Minimum hue value (0 to 360)
  static const int maxHue = 360; // Maximum hue value (0 to 360)
  static const int minSaturation = 50; // Minimum saturation value (0 to 100)
  static const int maxSaturation = 100; // Maximum saturation value (0 to 100)
  static const int minLightness = 30; // Minimum lightness value (0 to 100)
  static const int maxLightness = 70; // Maximum lightness value (0 to 100)

  static final Random _random = Random();

  static ColorModel generateRandomColor() {
    // Generate random values for hue, saturation, and lightness
    int hue = minHue + _random.nextInt(maxHue - minHue + 1);
    int saturation =
        minSaturation + _random.nextInt(maxSaturation - minSaturation + 1);
    int lightness =
        minLightness + _random.nextInt(maxLightness - minLightness + 1);

    // Convert HSL to RGB
    ColorModel rgbColor = _hslToRgb(hue, saturation, lightness);

    return rgbColor;
  }

  static ColorModel _hslToRgb(int hue, int saturation, int lightness) {
    double h = hue / 360.0;
    double s = saturation / 100.0;
    double l = lightness / 100.0;

    double r, g, b;

    if (s == 0) {
      r = g = b = l;
    } else {
      double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      double p = 2 * l - q;
      r = hueToRgb(p, q, h + 1 / 3);
      g = hueToRgb(p, q, h);
      b = hueToRgb(p, q, h - 1 / 3);
    }

    return ColorModel((r * 255).toInt(), (g * 255).toInt(), (b * 255).toInt());
  }

  static double hueToRgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }
}
