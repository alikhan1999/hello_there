import 'package:hello_there/all_utils.dart';

class AppDecoration {
  static BoxDecoration boxDecorationWithRadius(ColorModel color) =>
      BoxDecoration(
          color: Color.fromARGB(255, color.red, color.green, color.blue),
          border: Border.all());
}
