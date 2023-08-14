import 'package:empathyGenerator/all_utils.dart';

class AnimatedOnTapContainer extends StatelessWidget {
  final VoidCallback callback;
  final ColorModel color;
  final Widget child;
  final double padValue;

  const AnimatedOnTapContainer(
      {Key? key,
      required this.callback,
      required this.color,
      required this.child,
      this.padValue = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: AnimatedPadding(
        padding: EdgeInsets.all(padValue),
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: AppDecoration.boxDecorationWithRadius(color),
          child: MySlideTransition(child: child), // passing a child to animate a widget
        ),
      ),
    );
  }
}
