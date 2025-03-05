import 'dart:io';

import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/dto/ForgetPasswordDTO.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/create_password_screen.dart';
import 'package:craft_school/screens/forgetpassword_screen.dart';
import 'package:craft_school/screens/signup_screen.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/custom_background_container.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/sign_In_provider.dart';
import 'package:craft_school/widgets/or_divider.dart';

class SignInScreen extends StatelessWidget {
  static const String route = "/signIn";
  SignInScreen({super.key});
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
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: Platform.isAndroid
            ? SizeConfig.blockSizeVertical * 63
            : SizeConfig.blockSizeVertical * 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
          child: Column(
            children: [
              Consumer<SignInProvider>(builder: (context, signInProvider, _) {
                return SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: Platform.isAndroid
                      ? SizeConfig.blockSizeVertical * 51
                      : SizeConfig.blockSizeVertical * 49,
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
                      SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Distributes space evenly
                        children: signInProvider.chipAccountData.map((chip) {
                          return FilterChip(
                            label: SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 30,
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Ensures chips are as wide as their content
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center contents of each chip
                                children: [
                                  SvgPicture.asset(
                                    chip['image']!,
                                    height: 24.0,
                                    width: 24.0,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Space between image and label
                                  Text(
                                    chip['label']!,
                                    style: TextStyle(
                                      color: signInProvider.selectedChip ==
                                              chip['label']
                                          ? Colors.white
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            selected:
                                signInProvider.selectedChip == chip['label'],
                            onSelected: (isSelected) {
                              signInProvider
                                  .onSingleChipSelected(chip['label']);
                            },
                            selectedColor: CraftColors.neutralBlue750,
                            backgroundColor: CraftColors.neutralBlue750,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              side: BorderSide(
                                color: signInProvider.selectedChip ==
                                        chip['label']
                                    ? Colors
                                        .white // Thicker border when selected
                                    : Colors
                                        .white, // Light border when unselected
                                width:
                                    signInProvider.selectedChip == chip['label']
                                        ? 1.0 // Thicker width when selected
                                        : 0.1, // Lighter width when unselected
                              ),
                            ),
                            elevation: 0,
                            showCheckmark:
                                false, // Removes the checkmark symbol!
                          );
                        }).toList(),
                      ),
                      SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
                         OrDivider(text: CraftStrings.strOr,),
                      Consumer<SignInProvider>(
                        builder: (context, signInProvider, _) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Form(
                              key: signInProvider
                                  .formKey, // Wrap all fields inside the Form widget
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextFieldWidget(
                                    title: CraftStrings.strEmail,
                                    hintText: CraftStrings.strEnterEmail,
                                    onChange: (val) {},
                                    textEditingController:
                                        signInProvider.emailController,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    validator:
                                        signInProvider.validateEmailField,
                                  ),

                                  // Password Field with Validation
                                  Text(
                                    CraftStrings.strpassword,
                                    style: CraftStyles.tsWhiteNeutral100W50014,
                                  ),
                                  SizedBox(
                                      height:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  TextFormField(
                                    style: CraftStyles.tsWhiteNeutral300W50012,
                                    obscureText:
                                        signInProvider.isPasswordObscured,
                                    controller:
                                        signInProvider.passwordController,
                                    validator: signInProvider.validatePassword,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: signInProvider
                                            .togglePasswordVisibility,
                                        icon: Icon(
                                          signInProvider.isPasswordObscured
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: CraftColors.neutral50,
                                        ),
                                      ),
                                      hintText: CraftStrings.strEnterpassword,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                  SizedBox(
                                      height: SizeConfig.blockSizeVertical * 2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              signInProvider.toggleCheckbox(
                                                  !signInProvider.isChecked);
                                            },
                                            child: Container(
                                              width: 20.0,
                                              height: 20.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    4.0), // Border radius for the checkbox
                                                border: Border.all(
                                                  color: signInProvider
                                                          .isChecked
                                                      ? Colors
                                                          .white // White border when selected
                                                      : Colors
                                                          .white, // White border when unselected
                                                  width: 2.0, // Border width
                                                ),
                                                color: signInProvider.isChecked
                                                    ? CraftColors
                                                        .neutralBlue850 // Background color when checked
                                                    : Colors
                                                        .transparent, // Background color when unchecked
                                              ),
                                              child: signInProvider.isChecked
                                                  ? Icon(
                                                      Icons.check,
                                                      color: Colors
                                                          .white, // Color of the check mark
                                                      size: 18.0,
                                                    )
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                          ),
                                          Text(
                                            CraftStrings
                                                .strRememberPassword, // The text to display next to the checkbox
                                            style: CraftStyles
                                                .tsWhiteNeutral300W500,
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                ForgetpasswordScreen.route,
                                                arguments: ForgetPasswordDTO(
                                                    title: CraftStrings
                                                        .strForgetYourPassword,
                                                    detailText: CraftStrings
                                                        .strForgetPasswordDetail,
                                                    emailHint:
                                                        CraftStrings.strEmail,
                                                    buttonText: CraftStrings
                                                        .strResetLink,
                                                    signInText:
                                                        CraftStrings.strSignIn,
                                                    isEmailSectionnVisble: true,
                                                    onTextOnTap: () {
                                                      Navigator.of(
                                                        routeGlobalKey
                                                            .currentContext!,
                                                      ).pushNamedAndRemoveUntil(
                                                        SignInScreen.route,
                                                        (route) => false,
                                                      );
                                                    },
                                                    onButtonOnTap: () {
                                                      Navigator.of(
                                                        routeGlobalKey
                                                            .currentContext!,
                                                      ).pushNamedAndRemoveUntil(
                                                        CreatePasswordScreen
                                                            .route,
                                                        (route) => false,
                                                      );
                                                    }),
                                              );
                                            },
                                            child: Text(
                                              CraftStrings
                                                  .strForgetPassword, // The text to display next to the checkbox
                                              style: CraftStyles
                                                  .tsPrimaryblue500300W500,
                                            ),
                                          ),
                                          Positioned(
                                            bottom:
                                                0, // This positions the underline
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              height:
                                                  0.6, // Thickness of the underline
                                              color: CraftColors
                                                  .primaryBlue500, // Color of the underline
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 9,
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(
                          routeGlobalKey.currentContext!,
                        ).pushNamed(
                          SignUpScreen.route,
                          
                        );
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: CraftStrings.strHaveAnAccount,
                                style: CraftStyles.tsWhiteNeutral300W300,
                              ),
                              TextSpan(
                                text: CraftStrings.strSignUp,
                                style: CraftStyles.tsWhiteNeutral50W60016,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
                    Center(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: CraftStrings.strAccDetail,
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
                                    CraftStrings
                                        .strPrivacyPolicy, // The text to display next to the checkbox
                                    style: CraftStyles.tsWhiteNeutral300W400,
                                  ),
                                  Positioned(
                                    bottom: 0, // This positions the underline
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 0.2, // Thickness of the underline
                                      color: Colors
                                          .white, // Color of the underline
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeVertical * 0.5,
                              ),
                              Text(
                                CraftStrings.strAnd,
                                textAlign: TextAlign.center,
                                style: CraftStyles.tsWhiteNeutral300W400,
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeVertical * 0.5,
                              ),
                              Stack(
                                children: [
                                  Text(
                                    CraftStrings
                                        .strTermService, // The text to display next to the checkbox
                                    style: CraftStyles.tsWhiteNeutral300W400,
                                  ),
                                  Positioned(
                                    bottom: 0, // This positions the underline
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 0.2, // Thickness of the underline
                                      color: Colors
                                          .white, // Color of the underline
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
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
        create: (_) => SignInProvider(),
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomBackgroundContainer(),
            buildMostInterestedCard(
              title: CraftStrings.str03Intro,
              subtitle: CraftStrings.strAccountDetail,
              color: CraftColors.neutralBlue800,
              titleStyle: CraftStyles.tsWhiteNeutral50W70016,
              subtitleStyle: CraftStyles.tsWhiteNeutral300W500,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Consumer<SignInProvider>(
                builder: (context, signInProvider, _) {
                  return ElevatedButton(
                    onPressed: () {
                      if (signInProvider.validateForm()) {
                        // Proceed with form submission
                        signInProvider.createSignIn();
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
                      CraftStrings.strSignIn,
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
