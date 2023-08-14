// ignore_for_file: deprecated_member_use

import 'package:empathyGenerator/all_utils.dart';
import 'package:empathyGenerator/widget/common_widget.dart';


class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialogWithField(BuildContext context,
      {required String title,
      String okBtnText = "Ok",
      String cancelBtnText = "Cancel",
      required BuildContextCallback okBtnFunction}) {
    // TextEditingController nameController =
    //     TextEditingController(text: storage.user?.email);
    TextEditingController passwordController = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              title,
            )
            // content: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     SizedBox(height: 15.h),
            //     Text('User Name',
            //         style:
            //             TextStyle(color: AppColor.blackColor, fontSize: 15.sp)),
            //     SizedBox(height: 10.h),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 8),
            //       child: SneakPeakTextField(
            //         controller: nameController,
            //         validator: Validator.nameValidator,
            //         maxLines: 1,
            //         readOnly: true,
            //         hintText: 'User Name',
            //         onFieldTap: () {},
            //         circleRadius: 10,
            //       ),
            //     ),
            //     SizedBox(height: 10.h),
            //     Text('Password',
            //         style:
            //             TextStyle(color: AppColor.blackColor, fontSize: 15.sp)),
            //     SizedBox(height: 10.h),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 8),
            //       child: SneakPeakTextField(
            //         controller: passwordController,
            //         validator: Validator.nameValidator,
            //         maxLines: 1,
            //         hintText: 'password',
            //         onFieldTap: () {},
            //         circleRadius: 10,
            //       ),
            //     ),
            //     SizedBox(height: 20.h),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Expanded(
            //           child: SneakPeakElevatedButton(
            //               // size: Size(150.w, 53.h),
            //               color: AppColor.whiteColor,
            //               textStyle: Theme.of(context)
            //                   .textTheme
            //                   .headline1!
            //                   .copyWith(color: AppColor.darkRedColor),
            //               title: 'No',
            //               onTap: (BuildContext context) =>
            //                   Navigator.pop(context)),
            //         ),
            //
            //         Expanded(
            //           child: SneakPeakElevatedButton(
            //               // size: Size(150.w, 53.h),
            //               color: AppColor.whiteColor,
            //               textStyle: Theme.of(context)
            //                   .textTheme
            //                   .headline1!
            //                   .copyWith(color: AppColor.darkRedColor),
            //               title: 'Yes',
            //               onTap: (BuildContext context) async {
            //                 SocialAuthService.signOutFromFireBase(
            //                     context, passwordController.text.trim());
            //               }),
            //         )
            //         // HorizontalRectangleBtn(
            //         //     btnHeight: 40,
            //         //     btnWidth: 80,
            //         //     name: okBtnText,
            //         //     color: AppColor.bgsColor,
            //         //     onTap: () async {
            //         //
            //         //     }),
            //         // const SizedBox(width: 5),
            //         // HorizontalRectangleBtn(
            //         //     btnHeight: 40,
            //         //     btnWidth: 80,
            //         //     name: cancelBtnText,
            //         //     color: AppColor.bgsColor,
            //         //     onTap: () => Navigator.pop(context)),
            //       ],
            //     ),
            //     SizedBox(height: 10.h),
            //   ],
            // ),
            // content: /* Here add your custom widget  */
            // actions: <Widget>[
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       HorizontalRectangleBtn(
            //           btnHeight: 40,
            //           btnWidth: 80,
            //           name: cancelBtnText,
            //           color: const Color(0xffF39881),
            //           onTap: () => Navigator.pop(context)),
            //       const SizedBox(width: 5),
            //       HorizontalRectangleBtn(
            //           btnHeight: 40,
            //           btnWidth: 80,
            //           name: okBtnText,
            //           color: const Color(0xffF39881),
            //           onTap: () async {
            //             UserCredential? userCredential;
            //             if (passwordController.text.isEmpty) {
            //               return EasyLoading.showInfo('Please Enter Password');
            //             } else {
            //               EasyLoading.show();
            //               User? user = FirebaseAuth.instance.currentUser;
            //               try {
            //                 userCredential =
            //                     await user?.reauthenticateWithCredential(
            //                         EmailAuthProvider.credential(
            //                             email: nameController.text,
            //                             password:
            //                                 passwordController.text.trim()));
            //
            //                 await FirebaseAuth.instance.currentUser?.delete();
            //                 final storageUser = storage.user;
            //                 final instance = FirebaseFirestore.instance;
            //                 final batch = instance.batch();
            //                 final collection = instance
            //                     .collection('users')
            //                     .doc(storageUser?.currentUserId)
            //                     .collection('CalendarAppointmentCollection');
            //                 final snapshots = await collection.get();
            //                 for (var doc in snapshots.docs) {
            //                   batch.delete(doc.reference);
            //                 }
            //                 await batch.commit();
            //
            //                 await FirebaseFirestore.instance
            //                     .collection('users')
            //                     .doc(storageUser?.currentUserId)
            //                     .delete();
            //
            //                 await storage.removeUser();
            //                 EasyLoading.dismiss();
            //
            //                 Navigator.pushNamedAndRemoveUntil(
            //                     context, LoginPage.routeName, (route) => false);
            //                 context.read<AuthBloc>().add(SignOutRequested());
            //
            //                 return EasyLoading.showInfo(
            //                     'Successfully Delete Account');
            //               } catch (e) {
            //                 EasyLoading.dismiss();
            //
            //                 return EasyLoading.showInfo('$e');
            //               }
            //             }
            //           }),
            //     ],
            //   )
            // ],
          );
        });
  }
}
