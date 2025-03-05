import 'dart:io';

import 'package:craft_school/dto/LoginResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/SPManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/internetConnection.dart';

import 'package:flutter/material.dart';
import 'package:craft_school/utils/regex_helper.dart';

class SignInProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool _isPasswordObscured = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegexHelper _regexHelper = RegexHelper();

  // Getter for formKey
  GlobalKey<FormState> get formKey => _formKey;
  bool get isPasswordObscured => _isPasswordObscured;
  String? selectedChip;
  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  String? validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_regexHelper.isEmailIdValid(value)) {
      return 'Enter a valid Email ID';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value != passwordController.text) {
      return 'Confirm Password should match your new password';
    }
    return null;
  }

  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void toggleCheckbox(bool? value) {
    _isChecked = value ?? false;
    notifyListeners(); // Notify listeners when the state changes
  }

  // Method to validate form
  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  final List<Map<String, String>> chipAccountData = [
    {'label': 'Google', 'image': CraftImagePath.google},
    {'label': 'Apple', 'image': CraftImagePath.apple},
  ];
  var getToken = "";
  void onSingleChipSelected(String? label) {
    selectedChip = label; // Update the selected chip
    // if(label=="Google")
    // {
    //   signInWithGoogle();
    // }
    notifyListeners();
  }

  Map<String, dynamic> createRequestBody() {
    return {
      "email": emailController.text,
      "password": passwordController.text,
      "browser_Name": "App",
      "device_Type": Platform.isAndroid ? "Android" : "IOS"
    };
  }

  createSignIn() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createRequestBody();
      print(jsonbody);

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.login,
          (response) async {
        LoginResponse resp = response;

       if(resp.status==true)
       {
         ShowDialogs.showToast(resp.message);
         SPManager().setAuthToken(resp.token);
        Navigator.of(
          routeGlobalKey.currentContext!,
        ).pushNamed(
          LandingScreen.route,
        );
       }
      }, (error) {
        print('ERR msg is $error');

        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
  // User? _user;
  //  final FirebaseAuth _auth = FirebaseAuth.instance;
// void signInWithGoogle() async {
//   print("Google");
//     try {
//       final GoogleSignInAccount? googleUser =
//           await GoogleSignIn(forceCodeForRefreshToken: true).signIn();

//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//         GlobalLists.isSocialLogin = true;

//       getToken = googleAuth!.accessToken!;
//       await _auth.signInWithCredential(credential);

//       final auth = await _auth.signInWithCredential(credential);
//       String? refresh_token = auth.user!.refreshToken;
//       print("GoogleSignIn refresh_token: $refresh_token");

//       _user = _auth.currentUser;

//       if (_user != null) {
//         // ShowDialogs.showLoadingDialog(context, _loginpass);
//         print('Social Check login email: ${_user!.email}');
//         // loginWithGoogleApi();
//       } else {
//         print('Social Check login Nothing');
//       }
//       // });
//     } on Exception catch (e) {
//       print('exception->$e');
//       // Get.back();
//     }
//   }
  // Future<bool> signOutFromGoogle() async {
  //   try {
  //     await _auth.signOut();
  //     return true;
  //   } on Exception catch (_) {
  //     return false;
  //   }
  // }

//    Future<User?> signInWithApple({List<Scope> scopes = const []}) async {
//     try {
//       final result = await TheAppleSignIn.performRequests([
//         AppleIdRequest(
//             requestedScopes: [Scope.email, Scope.fullName, ...scopes]),
//       ]);

//       print(result.credential?.email ?? "email");
//       print(result.credential?.authorizedScopes ?? "scop");
//       print(result.credential?.state ?? "state");

//         GlobalLists.isSocialLogin = true;

//       switch (result.status) {
//         case AuthorizationStatus.authorized:
//           final AppleIdCredential = result.credential!;
//           final oAuthCredential = OAuthProvider('apple.com');
//           final credential = oAuthCredential.credential(
//             idToken: String.fromCharCodes(AppleIdCredential.identityToken!),
//             accessToken:
//                 String.fromCharCodes(AppleIdCredential.authorizationCode!),
//           );
//           final UserCredential = await auth.signInWithCredential(credential);
//           final firebaseUser = UserCredential.user!;
//           print(firebaseUser);

//           // Print the Apple ID if available
//           if (firebaseUser.email != null) {
//             print("Apple ID: ${firebaseUser.email}");
//           } else {
//             print(
//                 "User's Apple ID was not provided. Please ensure you grant permission to share your email address and try signing in again.");
//           }

//           var fullName = AppleIdCredential.fullName;
//           var firstName = fullName?.givenName;
//           var lastName = fullName?.familyName;
//           print("First Name: $firstName");
//           print("Last Name: $lastName");

//           final displayName = '$firstName $lastName';
//           print("display name : $displayName");
//           if (firstName != null) {
//             await firebaseUser.updateDisplayName(displayName).then((value) {
//               print('upadate username successfully');
//             }).catchError((error) {
//               print('Error updating display name: $error');
//             });
//           }

//           print(
//               'check this :- ${firebaseUser.displayName.runtimeType == "null null"}');
//           if (firebaseUser.displayName != "null null" &&
//               firebaseUser.displayName != null) {
//             print('display name not null:-${firebaseUser.displayName}');

//             print(firebaseUser.displayName);
//             var splitName = firebaseUser.displayName;
//             var splits = splitName!.split(' ');
//             print(splits);

//               firstName = splits[0];
//               lastName = splits[1];

//           }

//           print("firebaseUser.displayName${firebaseUser.displayName}");

//           print(firebaseUser.displayName);

//             GlobalLists.getappleId = firebaseUser.email.toString();
//             GlobalLists.userId = firebaseUser.uid;

//         //  await loginWithApple(firstName, lastName);
// //APi
//           return firebaseUser;

//         case AuthorizationStatus.error:
//           throw PlatformException(
//             code: 'ERROR_AUTHORIZATION_DENIED',
//             message: result.error.toString(),
//           );

//         case AuthorizationStatus.cancelled:
//           throw PlatformException(
//             code: 'ERROR_ABORTED_BY_USER',
//             message: 'Sign in aborted by user',
//           );
//         default:
//           throw UnimplementedError();
//       }
//     } catch (e) {
//       print("Error occurred during sign in with Apple: $e");
//       return null;
//     }
//   }
}
