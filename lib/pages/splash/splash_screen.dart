import 'package:flutter/material.dart';
import 'package:empathyGenerator/locator.dart';
import 'package:empathyGenerator/pages/login/login.dart';


class SplashScreen extends StatefulWidget {
  static const String routeName = '/SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () =>
            Navigator.of(context).pushReplacementNamed( Login.routeName )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/splash.png"),
      )),
    ));
  }
}
