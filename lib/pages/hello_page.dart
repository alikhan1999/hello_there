import 'package:hello_there/all_utils.dart';

class HelloPage extends StatefulWidget {
  const HelloPage({super.key});

  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  late ColorModel color;
  double padValue = 300.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),
        () => setState(() => padValue = padValue == 0.0 ? 300.0 : 0.0));
    color = ColorGenerator.generateRandomColor(); // After generate color code to get Rgb color

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOnTapContainer(
        callback: _changeColor,  // Used call back function to changing color
        padValue: padValue,   // Changing padding value for animation
        color: color,         // After tap , passing color to change background color
        child: Text(
          AppString.helloThere,     // String class which is constant variable
          style: Theme.of(context).primaryTextTheme.headlineMedium,
        ),
      ),
    );
  }

  void _changeColor() =>
      setState(() => color = ColorGenerator.generateRandomColor());// After tap ,it will be color code changed
}
