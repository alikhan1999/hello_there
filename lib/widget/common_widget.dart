import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:empathyGenerator/all_utils.dart';

typedef BuildContextCallback = void Function(BuildContext context);
int selectedIndex = 0;

class VerticalSpacing extends StatelessWidget {
  final double of;

  const VerticalSpacing({Key? key, this.of = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(height: of.h);
}

class HorizontalSpacing extends StatelessWidget {
  final double of;

  const HorizontalSpacing({Key? key, this.of = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: of.w);
  }
}


