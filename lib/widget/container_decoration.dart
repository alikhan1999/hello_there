import 'package:empathyGenerator/all_utils.dart';

class AppDecoration {
  static BoxDecoration boxDecorationWithRadius(ColorModel color) =>
      BoxDecoration(
          color: Color.fromARGB(255, color.red, color.green, color.blue),
          border: Border.all());
}
