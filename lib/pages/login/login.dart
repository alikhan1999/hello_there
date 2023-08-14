
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:empathyGenerator/all_utils.dart';
import 'package:empathyGenerator/pages/reset_password/reset_password.dart';
import 'package:empathyGenerator/pages/sign_up/sign_up.dart';
import 'package:empathyGenerator/utils/validator.dart';
import 'package:empathyGenerator/widget/common_widget.dart';


class Login extends StatefulWidget {
  static const String routeName = '/Login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            children: <Widget>[
              Image.asset(
                'assets/new_logo_splash.png',
                fit: BoxFit.contain,
                width: 244.w,
                height: 244.h,
              ),
              const VerticalSpacing(of: 40),
              const Align(
                  child: Text("Login to Account",
                      // style: headingStyle

                  )),
              const VerticalSpacing(of: 10),
              const Align(
                child: Text("Please enter info to login account",
                    // style: headingStyle2
                ),
              ),
              const VerticalSpacing(of: 25),
              GladTextField(
                controller: emailController,
                validator: Validator.emailValidator,
                prefixWidget: const ImageIcon(AssetImage("assets/email.png"),
                    ),
                hintText: "Username",
                obscure: false,
              ),
              const VerticalSpacing(of: 25),
              GladTextField(
                controller: passwordController,
                validator: Validator.passwordValidator,
                prefixWidget: const ImageIcon(
                  AssetImage("assets/password.png"),
                  color: AppColor.blueColorTitle,
                ),
                hintText: "Password",
                obscure: true,
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed:() => Navigator.pushNamed(context, ResetPassword.routeName),
                    child: Text("Forgot?",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColor.blueColorTitle,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              const VerticalSpacing(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: onTapToLogin,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(282.w, 55.h),
                    primary: AppColor.blueColorTitle,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: AppColor.btnTextWhiteColor,
                        // fontFamily: AppTheme.fontName
                    ),
                  ),
                ),
              ),
             const VerticalSpacing(of: 50),
              Center(
                  child: Text("Don’t have an account?",
                      style:
                      Theme.of(context).textTheme.headline2?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: AppColor.greenColorTitle,
                          decoration: TextDecoration.none
                      ))),
              InkWell(
                onTap: () => register(context),
                child: Center(
                    child: Text("Register here",
                        style:
                        Theme.of(context).textTheme.headline3?.copyWith(

                            fontWeight: FontWeight.normal,
                            color: AppColor.blueColorTitle,
                            fontSize: 20.sp,
                            decoration: TextDecoration.underline
                        ))),
              ),
            ],
          )),
    );
  }
  void register(BuildContext context) {
    Navigator.pushNamed(context, SignUp.routeName);
  }

  void onTapToLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        final userName = userCredential.user?.email;
        if (userName != null) {
          final localUserData = await userRepository.get(userName);
          if (localUserData == null) {
            EasyLoading.showError("No User Found");
          } else {
            await storage.setUser(localUserData);
            EasyLoading.dismiss();
            Navigator.pushNamed(context, HomePage.routeName);

            passwordController.clear();
          }
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError('No user found for that email.');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          EasyLoading.showError('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          EasyLoading.showError('Wrong password provided for that user.');
        }
      }
    }
  }
}
