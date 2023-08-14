// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../all_utils.dart';

class SocialAuthService {
  // static final _auth = LocalAuthentication();
  static GoogleSignIn? _googleSignIn;

  // static Future<void> signInWithGoogle(BuildContext context) async {
  //   // Trigger the authentication flow
  //
  //   await _googleSignIn?.disconnect().catchError((e, stack) {});
  //   EasyLoading.show();
  //
  //   try {
  //     _googleSignIn = GoogleSignIn(scopes: <String>["email"]);
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn?.signIn();
  //
  //     if (_googleSignIn == null) {
  //       return EasyLoading.showError('error');
  //     }
  //
  //     // if(googleUser != null ) return;
  //     // Obtain the auth details from the request
  //     // final GoogleSignInAuthentication googleAuth =
  //     // await googleSignInAccount.authentication;
  //     final GoogleSignInAuthentication? googleSignInAuthentication =
  //         await googleSignInAccount?.authentication;
  //     // Create a new credential
  //     // if (googleSignInAuthentication.idToken != null) {
  //     //   return googleSignInAuthentication.idToken!;
  //     // } else {
  //     //   throw Exception("Google Authentication Failed");
  //     // }
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication?.accessToken,
  //       idToken: googleSignInAuthentication?.idToken,
  //     );
  //     final userData =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     if (userData.user?.displayName != null) {
  //       final getUserData = await userRepository.get(userData.user!.uid);
  //       final localUserData = LocalUser(
  //           name: userData.user?.displayName ?? '',
  //           email: userData.user?.email ?? '',
  //           userId: userData.user?.uid ?? '',
  //           profilePicUrl: userData.user?.photoURL,
  //           createdAt: DateTime.now().toString(),
  //           updatedAt: DateTime.now().toString(),
  //           fcmToken: await NotificationService.getToken(),
  //           bookmarkedCollectionIds: getUserData?.bookmarkedCollectionIds ?? [],
  //           accountStatus: AccountStatus.pending,
  //           requestSentIds: getUserData?.requestSentIds ?? [],
  //           requestReceivedIds: getUserData?.requestReceivedIds ?? [],
  //           accountSource: AccountSource.google,
  //           blockedBy: getUserData?.blockedBy ?? [],
  //           friendIds: getUserData?.friendIds ?? [],
  //           lastSignIn: '');
  //
  //       // await FirebaseAuth.instance.currentUser
  //       //    ?.reauthenticateWithCredential(credential);
  //
  //       await userRepository.add(localUserData);
  //       await storage.setUser(localUserData);
  //       storage.setNotificationsCount(localUserData.friendIds.length);
  //       Navigator.pushReplacementNamed(context, TabScreen.routeName);
  //
  //       EasyLoading.dismiss();
  //     } else {
  //       EasyLoading.dismiss();
  //       EasyLoading.showError('Could not login, please try again.');
  //     }
  //   } catch (e) {
  //     if (e is PlatformException) {
  //       EasyLoading.dismiss();
  //
  //       EasyLoading.showError(e.message!);
  //     }
  //     EasyLoading.showError(e.toString());
  //     throw Exception(e.toString());
  //   }
  //
  //   // catch (e) {
  //   //   // EasyLoading.showError(e.toString());
  //   //   throw Exception(e.toString());
  //   //
  //   //   // if (e is FirebaseAuthException) {
  //   //   //   EasyLoading.dismiss();
  //   //   //
  //   //   //   EasyLoading.showError(e.message!);
  //   //   // }
  //   // Once signed in, return the UserCredential
  //   // }
  // }

  //Sign out
  static signOut() {
    FirebaseAuth.instance.signOut();
    _googleSignIn?.signOut();
    _googleSignIn = null;
  }
  //
  // //Apple sign in
  //
  // static String generateNonce([int length = 32]) {
  //   const charset =
  //       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //   final random = Random.secure();
  //   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
  //       .join();
  // }
  //
  // /// Returns the sha256 hash of [input] in hex notation.
  // static String sha256ofString(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }
  //
  // static Future<void> signInWithApple(BuildContext context) async {
  //   // To prevent replay attacks with the credential returned from Apple, we
  //   // include a nonce in the credential request. When signing in with
  //   // Firebase, the nonce in the id token returned by Apple, is expected to
  //   // match the sha256 hash of `rawNonce`.
  //
  //   final rawNonce = generateNonce();
  //   final nonce = sha256ofString(rawNonce);
  //
  //   // Request credential for the currently signed in Apple account.
  //
  //   try {
  //     EasyLoading.show();
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //       nonce: nonce,
  //     );
  //
  //     // Create an `OAuthCredential` from the credential returned by Apple.
  //     final oauthCredential = OAuthProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       rawNonce: rawNonce,
  //     );
  //     // Sign in the user with Firebase. If the nonce we generated earlier does
  //     // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  //     final userData =
  //         await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  //     if (userData.user != null) {
  //       final getUserData = await userRepository.get(userData.user!.uid);
  //       final localUserData = LocalUser(
  //           name: userData.user?.displayName ?? 'Jhon',
  //           email: userData.user?.email ?? '',
  //           userId: userData.user?.uid ?? '',
  //           profilePicUrl: userData.user?.photoURL,
  //           createdAt: DateTime.now().toString(),
  //           updatedAt: DateTime.now().toString(),
  //           fcmToken: await NotificationService.getToken(),
  //           bookmarkedCollectionIds: getUserData?.bookmarkedCollectionIds ?? [],
  //           accountStatus: AccountStatus.pending,
  //           requestSentIds: getUserData?.requestSentIds ?? [],
  //           requestReceivedIds: getUserData?.requestReceivedIds ?? [],
  //           accountSource: AccountSource.apple,
  //           blockedBy: getUserData?.blockedBy ?? [],
  //           friendIds: getUserData?.friendIds ?? [],
  //           lastSignIn: '');
  //       await userRepository.add(localUserData);
  //       await storage.setUser(localUserData);
  //       storage.setNotificationsCount(localUserData.friendIds.length);
  //       Navigator.pushReplacementNamed(context, TabScreen.routeName);
  //
  //       EasyLoading.dismiss();
  //     } else {
  //       EasyLoading.dismiss();
  //       EasyLoading.showError('Could not login, please try again.');
  //     }
  //   } catch (e) {
  //     if (e is FirebaseAuthException) {
  //       EasyLoading.dismiss();
  //
  //       EasyLoading.showError(e.message!);
  //     }
  //     EasyLoading.showError(e.toString());
  //     throw Exception(e.toString());
  //   }
  // }



  static Future<void> registerWithFireBase(
      BuildContext context,
      String userName,
      String password,
      String confirmPassword,
      String email) async {
    // if (password == confirmPassword) {
      // try {
      //   EasyLoading.show();
      //   final auth = FirebaseAuth.instance;
      //   await auth.createUserWithEmailAndPassword(
      //       email: email, password: password);
        // final User? userData = auth.currentUser;
        // if (userData != null) {
        //   final getUserData = await userRepository.get(userData.uid);
        //   final localUserData = LocalUser(
        //       name: userName,
        //       email: userData.email ?? '',
        //       userId: userData.uid ?? '',
        //       profilePicUrl: userData.photoURL,
        //       createdAt: DateTime.now().toString(),
        //       updatedAt: DateTime.now().toString(),
        //       fcmToken: await NotificationService.getToken(),
        //       bookmarkedCollectionIds:
        //           getUserData?.bookmarkedCollectionIds ?? [],
        //       accountStatus: AccountStatus.pending,
        //       requestSentIds: getUserData?.requestSentIds ?? [],
        //       requestReceivedIds: getUserData?.requestReceivedIds ?? [],
        //       accountSource: AccountSource.email,
        //       blockedBy: getUserData?.blockedBy ?? [],
        //       friendIds: getUserData?.friendIds ?? [],
        //       lastSignIn: '');
        //   await userRepository.add(localUserData);
        //   await storage.setUser(localUserData);
        //   storage.setNotificationsCount(localUserData.friendIds.length);
        //   await storage.setRememberMe(true);

          // Navigator.pushReplacementNamed(context, TabScreen.routeName);
  //
  //         EasyLoading.dismiss();
  //       } else {
  //         EasyLoading.dismiss();
  //         EasyLoading.showError('Could not login, please try again.');
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'weak-password') {
  //         EasyLoading.showError('The password provided is too weak.');
  //       } else if (e.code == 'email-already-in-use') {
  //         EasyLoading.showError('The account already exists for that email.');
  //       }
  //     }
  //   } else {
  //     EasyLoading.showError('Password not Match');
  //   }
  // }

  // static Future<void> loginWithFirebase(
  //     BuildContext context, String email, String password) async {
  //   try {
  //     EasyLoading.show();
  //
  //     final userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //
  //     final userID = userCredential.user?.uid;
  //     if (userID != null) {
  //       final getUserData = await userRepository.get(userID);
  //       if (getUserData == null) {
  //         EasyLoading.showError("No User Found");
  //       } else {
  //         // final localUserData = LocalUser(
  //         //     name: getUserData.name,
  //         //     email: getUserData.email,
  //         //     userId: getUserData.userId,
  //         //     createdAt: getUserData.createdAt,
  //         //     updatedAt: getUserData.updatedAt,
  //         //     fcmToken: await NotificationService.getToken(),
  //         //     bookmarkedCollectionIds: getUserData.bookmarkedCollectionIds,
  //         //     accountStatus: AccountStatus.pending,
  //         //     requestSentIds: getUserData.requestSentIds,
  //         //     requestReceivedIds: getUserData.requestReceivedIds,
  //         //     profilePicUrl: getUserData.profilePicUrl,
  //         //     accountSource: AccountSource.email,
  //         //     blockedBy: getUserData.blockedBy,
  //         //     friendIds: getUserData.friendIds,
  //         //     lastSignIn: '');
  //
  //         // await storage.setUser(localUserData);
  //         // storage.setNotificationsCount(localUserData.friendIds.length);
  //         EasyLoading.dismiss();
  //
  //         // Navigator.pushNamed(context, TabScreen.routeName);
  //       }
  //     } else {
  //       EasyLoading.dismiss();
  //       EasyLoading.showError('No user found for that email.');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       EasyLoading.showError('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       EasyLoading.showError('Wrong password provided for that user.');
  //     }
  //   }
  // }

  // static Future<void> resetPassword(BuildContext context, String email) async {
  //   try {
  //     EasyLoading.show();
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //     // Navigator.pushNamed(context, LoginScreen.routeName);
  //     EasyLoading.dismiss();
  //     EasyLoading.showSuccess(
  //         'Please check your inbox or spam for our mail with further instructions.');
  //   } on FirebaseAuthException catch (e) {
  //     EasyLoading.showError(e.toString());
  //     if (e.code == 'user-not-found') {
  //       EasyLoading.showError('No user found for that email');
  //     }
  //   }
  // }
  //
  // static void signOutFromFireBase(
  //     BuildContext context, String passwordController) async {
  //   if (passwordController.isEmpty) {
  //     return EasyLoading.showInfo('Please Enter Password');
  //   } else {
  //     EasyLoading.show();
  //     User? user = FirebaseAuth.instance.currentUser;
  //     try {
  //       // final storageUser = storage.user;
  //       final instance = FirebaseFirestore.instance;
  //       // final batch = instance.batch();
  //       // final collection = instance
  //       //     .collection('users')
  //       //     .doc(storageUser?.userId ?? '').delete();
  //
  //       // final snapshots = await collection.get();
  //       // for (var doc in snapshots.docs) {
  //       // batch.delete(doc.reference);
  //       // }
  //
  //       // storage.setRememberMe(false);
  //       // storage.removeUser();
  //       // await storage.removeUser();
  //       signOut();
  //
  //       // Navigator.pushNamedAndRemoveUntil(
  //       //     context, LoginScreen.routeName, (route) => false);
  //
  //       EasyLoading.dismiss();
  //       return EasyLoading.showInfo('Successfully Delete Account');
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //
  //       return EasyLoading.showInfo('$e');
  //     }
  //   }
  // }
}

// class GoogleAuth extends StatelessWidget {
//   static const String routeName = '/GoogleAuth';
//   const GoogleAuth({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.hasData) {
//           return const TabScreen();
//         } else {
//           return const LoginScreen();
//         }
//       },
//     );
//   }
}
