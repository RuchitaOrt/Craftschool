import 'dart:io';

import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/sign_up_provider.dart';

class SignUpScreen extends StatelessWidget {
  static const String route = "/signup";
  SignUpScreen({super.key});
  final BorderRadius borderRadius = const BorderRadius.all(
    Radius.circular(8),
  );
  final BorderSide focusedBorder = const BorderSide(
    width: 1.0,
  );
  final BorderSide enableBorder = BorderSide(
    width: 1.0,
  );
  Widget buildMostInterestedCard({
    required String title,
    required String subtitle,
    required Color color,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height:Platform.isAndroid?  SizeConfig.blockSizeVertical * 86:SizeConfig.blockSizeVertical * 81,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
          child: Column(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: Platform.isAndroid? SizeConfig.blockSizeVertical * 75.5:SizeConfig.blockSizeVertical * 70,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: subtitleStyle,
                    ),
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
                    Consumer<SignUpProvider>(
                      builder: (context, signUpProvider, _) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Form(
                            key: signUpProvider
                                .formKey, // Wrap all fields inside the Form widget
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // First Name Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strFirstName,
                                  hintText: CraftStrings.strEnterFirstName,
                                  onChange: (val) {},
                                  textEditingController:
                                      signUpProvider.firstNameController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signUpProvider.validateFirstName,
                                ),
                                // Last Name Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strLastName,
                                  hintText: CraftStrings.strEnterLastName,
                                  onChange: (val) {},
                                  textEditingController:
                                      signUpProvider.lastNameController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signUpProvider.validateLastName,
                                ),
                                // Email Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strEmail,
                                  hintText: CraftStrings.strEnterEmail,
                                  onChange: (val) {},
                                  textEditingController:
                                      signUpProvider.emailController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signUpProvider.validateEmailField,
                                ),
                                // Phone Number Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strPhoneNo,
                                  hintText: CraftStrings.strEnterPhoneNo,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly, 
                                  ],
                                  textInputType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  onChange: (val) {},
                                  textEditingController:
                                      signUpProvider.phoneNumberController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signUpProvider.validatePhoneNumber,
                                ),
                                // Password Field with Validation
                                Text(
                                  CraftStrings.strpassword,
                                  style: CraftStyles.tsWhiteNeutral100W50014,
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeHorizontal * 2),
                                TextFormField(
                                  style: CraftStyles.tsWhiteNeutral300W50012,
                                  obscureText:
                                      signUpProvider.isPasswordObscured,
                                  controller: signUpProvider.passwordController,
                                  validator: signUpProvider.validatePassword,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: signUpProvider
                                          .togglePasswordVisibility,
                                      icon: Icon(
                                        signUpProvider.isPasswordObscured
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: CraftColors.neutral50,
                                      ),
                                    ),
                                    hintText: CraftStrings.strEnterpassword,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 16.0),
                                    border: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: enableBorder),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: focusedBorder),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: enableBorder),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: enableBorder),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: enableBorder),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: borderRadius,
                                        borderSide: focusedBorder),
                                    filled: true,
                                    fillColor: CraftColors.neutralBlue850,
                                    hintStyle:
                                        CraftStyles.tsWhiteNeutral300W50012,
                                    errorStyle:
                                        CraftStyles.tsWhiteNeutral300W50012,
                                    counterText: "",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 9,
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                    Center(
                      child: GestureDetector(
                        onTap: ()
                        {
                           Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamedAndRemoveUntil(
                        SignInScreen.route,
                        (route) => false,
                      );
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: CraftStrings.strHaveAnAccount,
                                style: CraftStyles.tsWhiteNeutral300W300,
                              ),
                              TextSpan(
                                text: CraftStrings.strSignIn,
                                style: CraftStyles.tsWhiteNeutral50W60016,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                    Center(
                      child:
                     
                       Column(
                         children: [
                           RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:  CraftStrings.strAccDetail,
                                    style: CraftStyles.tsWhiteNeutral300W400,
                                  ),
                                 
                                ],
                              ),
                            ),
                             SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Stack(
  children: [
    Text(
      CraftStrings.strPrivacyPolicy, // The text to display next to the checkbox
      style: CraftStyles.tsWhiteNeutral300W400,
    ),
    Positioned(
      bottom: 0, // This positions the underline
      left: 0,
      right: 0,
      child: Container(
        height: 0.2, // Thickness of the underline
        color: Colors.white, // Color of the underline
      ),
    ),
  ],
)
,
SizedBox(width: SizeConfig.blockSizeVertical*0.5,),
                                Text(
                        CraftStrings.strAnd,
                        textAlign: TextAlign.center,
                        style: CraftStyles.tsWhiteNeutral300W400,
                      ),
                      SizedBox(width: SizeConfig.blockSizeVertical*0.5,),
                      Stack(
  children: [
    Text(
      CraftStrings.strTermService, // The text to display next to the checkbox
      style: CraftStyles.tsWhiteNeutral300W400,
    ),
    Positioned(
      bottom: 0, // This positions the underline
      left: 0,
      right: 0,
      child: Container(
        height: 0.2, // Thickness of the underline
        color: Colors.white, // Color of the underline
      ),
    ),
  ],
)

                            ],)
                         ],
                       ),
                       
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: CraftColors.black18,
      body: ChangeNotifierProvider(
        create: (_) => SignUpProvider(),
        child: ListView(
          shrinkWrap: true,
          children: [
            buildMostInterestedCard(
              title: CraftStrings.str03Intro,
              subtitle: CraftStrings.strAccountDetail,
              color: CraftColors.neutralBlue800,
              titleStyle: CraftStyles.tsWhiteNeutral50W70016,
              subtitleStyle: CraftStyles.tsWhiteNeutral300W500,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Consumer<SignUpProvider>(
                builder: (context, signUpProvider, _) {
                  return ElevatedButton(
                    onPressed: () {
                      if (signUpProvider.validateForm()) {
                        // Proceed with form submission
                         signUpProvider.createSignup();
                      } else {
                        // Form is invalid, show error messages
                      }
                     
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(SizeConfig.blockSizeVertical * 100,
                          SizeConfig.blockSizeVertical * 5),
                      backgroundColor: CraftColors.primaryBlue550,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      CraftStrings.strSignUp,
                      style: CraftStyles.tsWhiteNeutral50W60016,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
