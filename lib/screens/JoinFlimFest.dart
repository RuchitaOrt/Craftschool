import 'dart:io';

import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/sign_up_provider.dart';

class JoinFlimFest extends StatelessWidget {
  final String flimId;
  static const String route = "/joinFlimFest";
  JoinFlimFest({super.key, required this.flimId});
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
        height: Platform.isAndroid
            ? SizeConfig.blockSizeVertical * 76
            : SizeConfig.blockSizeVertical * 71,
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
                height: Platform.isAndroid
                    ? SizeConfig.blockSizeVertical * 73
                    : SizeConfig.blockSizeVertical * 70,
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
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
                              ],
                            ),
                          ),
                        );
                      },
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

    return ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isContainerVisible: provider.isContainerVisible,
                isCategoryVisible: provider.isCategoryVisible,
                onMenuPressed: () {
                  provider
                      .toggleSlidingContainer(); // Trigger toggle when menu is pressed
                },
                onCategoriesPressed: () {
                  provider.toggleSlidingCategory();
                },
              ),
            ),
            backgroundColor: CraftColors.black18,
            body: Stack(
              children: [
                ChangeNotifierProvider(
                  create: (_) => SignUpProvider(),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      buildMostInterestedCard(
                        title: CraftStrings.strJoinFirmFestival,
                        subtitle: "",
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
                                  signUpProvider.joinFlimFestAPI(flimId,signUpProvider.firstNameController.text,signUpProvider.phoneNumberController.text,signUpProvider.emailController.text);
                                } else {
                                  // Form is invalid, show error messages
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    SizeConfig.blockSizeVertical * 100,
                                    SizeConfig.blockSizeVertical * 5),
                                backgroundColor: CraftColors.primaryBlue550,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                CraftStrings.strJoinFirmFestival,
                                style: CraftStyles.tsWhiteNeutral50W60016,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                 if (provider.isContainerVisible)
                      SlidingMenu(isVisible: provider.isContainerVisible),
                    if (provider.isCategoryVisible)
                      SlidingCategory(
                        isExpanded: provider.isCategoryVisible,
                        onToggleExpansion: provider.toggleSlidingCategory,
                      ),
              ],
            ),
          );
        }));
  }
}
