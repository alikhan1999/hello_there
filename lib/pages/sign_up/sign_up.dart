import 'package:empathyGenerator/all_utils.dart';
import 'package:empathyGenerator/locator.dart';
import 'package:empathyGenerator/model/local_user.dart';
import 'package:empathyGenerator/pages/login/login.dart';
import 'package:empathyGenerator/utils/text_styles.dart';
import 'package:empathyGenerator/widget/common_widget.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/Signup';

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
            Align(
                child:
                    Text("Create Account", style: twintyEightFontHahmletStyle)),
            const VerticalSpacing(of: 10),
            Align(
              child: Text("Please enter info to create account",
                  style: sixteenFontHahmletStyle),
            ),
            const VerticalSpacing(of: 25),
            GladTextField(
              validator: Validator.nameValidator,
              controller: userNameController,
              prefixWidget: const ImageIcon(AssetImage("assets/username.png"),
                  color: AppColor.blueColorTitle),
              hintText: 'User Company Name',
              obscure: false,
            ),
            const VerticalSpacing(of: 25),
            GladTextField(
              validator: Validator.emailValidator,
              controller: emailController,
              prefixWidget: const ImageIcon(AssetImage("assets/email.png"),
                  color: AppColor.blueColorTitle),
              hintText: "Email",
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
            const VerticalSpacing(of: 25),
            GladTextField(
              controller: confirmPasswordController,
              validator: Validator.passwordValidator,
              prefixWidget: const ImageIcon(
                AssetImage("assets/password.png"),
                color: AppColor.blueColorTitle,
              ),
              hintText: "Confirm Password",
              obscure: true,
            ),
            const VerticalSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: onTapConfirm,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(282.w, 55.h),
                  primary: AppColor.blueColorTitle,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Confirm',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppColor.btnTextWhiteColor,
                      // fontFamily: AppTheme.fontName
                    ),),
              ),
            ),
            const VerticalSpacing(of: 50),
            Center(
                child: Text("Already have an account?",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.sp,
                        color: AppColor.greenColorTitle,
                        decoration: TextDecoration.none))),
            InkWell(
              onTap: () => register(context),
              child: Center(
                  child: Text("Login here",
                      style: Theme.of(context).textTheme.headline3?.copyWith(

                          fontWeight: FontWeight.normal,
                          color: AppColor.blueColorTitle,
                          fontSize: 20.sp,
                          decoration: TextDecoration.underline
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  void register(BuildContext context) {
    Navigator.pushNamed(context, Login.routeName);
  }

  void onTapConfirm() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        try {
          EasyLoading.show();
          // final stripeCustomerData =
          //     await stripeCardRepository.createCustomer();

          final auth = FirebaseAuth.instance;
          await auth.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
          final User? user = auth.currentUser;
          if (user != null) {
            final localUserData = LocalUser(
              currentUserId: auth.currentUser!.uid,
              name: userNameController.text.trim(),
              email: emailController.text.trim(),
              password: 'Not Display',
              customerUserId: '',
            );
            await userRepository.add(localUserData);
            await storage.setUser(localUserData);
            EasyLoading.dismiss();
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError('Could not login, please try again.');
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            EasyLoading.showError('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            EasyLoading.showError('The account already exists for that email.');
          }
        } catch (e) {
          EasyLoading.showError('Error: $e');
        }
      } else {
        EasyLoading.showError('Password not Match');
      }
    }
  }
}
