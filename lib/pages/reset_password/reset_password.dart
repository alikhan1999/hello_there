import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:empathyGenerator/all_utils.dart';
import 'package:empathyGenerator/pages/login/login.dart';
import 'package:empathyGenerator/utils/text_styles.dart';
import 'package:empathyGenerator/widget/common_widget.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = '/ResetPassword';

  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
            iconTheme:  IconThemeData(size: 25.h)
      ),
      body: Form(
        key: formKey,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
            children: [
               Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Forgot Password", style: twentyFourFontHahmletStyle.copyWith(color: AppColor.blueColorTitle)),
              ),
              const VerticalSpacing(),
              GladTextField(
                controller: emailController,
                validator: Validator.emailValidator,
                hintText: 'Enter email',
                obscure: false,
              ),
              const VerticalSpacing(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: onTapTOForgot,
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

            ]),
      ),
    );
  }

  void onTapTOForgot() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.toString());
      return;
    }

    try {
      EasyLoading.show();

      Navigator.pushNamed(context, Login.routeName);
      EasyLoading.dismiss();
      EasyLoading.showSuccess(
          'Email has been sent Successfully, Please check your inbox or spam');
      emailController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.showError('No user found for that email.');
      }
    }
  }
}
