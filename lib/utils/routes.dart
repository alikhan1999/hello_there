import 'package:empathyGenerator/all_screens.dart';
import 'package:empathyGenerator/all_utils.dart';
import 'package:empathyGenerator/pages/reset_password/reset_password.dart';



final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  Login.routeName: (context) => const Login(),
  SignUp.routeName: (context) => const SignUp(),
  ResetPassword.routeName: (context) => const ResetPassword(),
  HomePage.routeName: (context) => const HomePage(),
};
