import 'package:flutter/material.dart';

class MySlideTransition extends StatefulWidget {
  final Widget child;
  final Offset offset;

  /// delay in milliseconds
  final int delay;

  /// duration in milliseconds
  final int duration;

  const MySlideTransition({
    required this.child,
    this.offset = const Offset(0.5, 0.0),
    this.delay = 3500,
    this.duration = 2000,
    Key? key,
  }) : super(key: key);

  @override
  MySlideTransitionState createState() => MySlideTransitionState();
}

class MySlideTransitionState extends State<MySlideTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration:  Duration(milliseconds: widget.duration),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed( Duration(milliseconds:widget.delay) ,()=>_controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0.5, 0),
          end: const Offset(0.0, 0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.bounceIn,
          ),
        ),

      child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
