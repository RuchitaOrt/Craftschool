import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/dto/ForgetPasswordDTO.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/personal_account_provider.dart';
import 'package:craft_school/screens/forgetpassword_screen.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/custom_background_container.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/sign_In_provider.dart';

class PersonalScreen extends StatelessWidget {
  static const String route = "/personalScreen` ";
  PersonalScreen({super.key});
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
        height: SizeConfig.blockSizeVertical * 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
          child: Column(
            children: [
              Consumer<PersonalAccountProvider>(builder: (context, personalAccountProvider, _) {
                return SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 45,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                      Consumer<PersonalAccountProvider>(
                        builder: (context, personalAccountProvider, _) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Form(
                              key: personalAccountProvider
                                  .formKey, // Wrap all fields inside the Form widget
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   
                                CustomTextFieldWidget(
                                  title: CraftStrings.strFirstName,
                                  hintText: CraftStrings.strEnterFirstName,
                                  onChange: (val) {},
                                  textEditingController:
                                      personalAccountProvider.firstNameController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: personalAccountProvider.validateFirstName,
                                ),
                                // Last Name Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strLastName,
                                  hintText: CraftStrings.strEnterLastName,
                                  onChange: (val) {},
                                  textEditingController:
                                      personalAccountProvider.lastNameController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: personalAccountProvider.validateLastName,
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
                                      personalAccountProvider.phoneNumberController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: personalAccountProvider.validatePhoneNumber,
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
      appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                 isCategoryVisible:false,
                onMenuPressed: () {
                  // provider.toggleSlidingContainer(); // Trigger toggle when menu is pressed
                },
                onCategoriesPressed: () {  }, isContainerVisible: false,
              ),
            ),
            backgroundColor: CraftColors.black18,
      body: ChangeNotifierProvider(
        create: (_) => PersonalAccountProvider(),
        child: ListView(
          shrinkWrap: true,
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text(
                                    textAlign: TextAlign.center,
                                    "Personal",
                                    style: CraftStyles.tsWhiteNeutral50W700
                                        .copyWith(fontSize: 20),
                                  ),
               ],
             ),
           ),
           SizedBox(height: SizeConfig.blockSizeVertical*2,),
            buildMostInterestedCard(
              title: CraftStrings.str03Intro,
              subtitle: CraftStrings.strAccountDetail,
              color: CraftColors.neutralBlue800,
              titleStyle: CraftStyles.tsWhiteNeutral50W70016,
              subtitleStyle: CraftStyles.tsWhiteNeutral300W500,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical*2,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Consumer<PersonalAccountProvider>(
                builder: (context, personalAccountProvider, _) {
                  return ElevatedButton(
                    onPressed: () {
                      if (personalAccountProvider.validateForm()) {
                        // Proceed with form submission
                        Navigator.pushNamed(
                          context,
                          ForgetpasswordScreen.route,
                          arguments: ForgetPasswordDTO(
                              title: CraftStrings.strResetpasswordSuccesfully,
                              detailText: CraftStrings
                                  .strResetpasswordSuccesfullyDetail,
                              emailHint: CraftStrings.strEmail,
                              buttonText: CraftStrings.strSignIn,
                              signInText: CraftStrings.strHome,
                              isEmailSectionnVisble: false,
                              onButtonOnTap: () {
                                Navigator.of(
                                  routeGlobalKey.currentContext!,
                                ).pushNamedAndRemoveUntil(
                                  SignInScreen.route,
                                  (route) => false,
                                );
                              },
                              onTextOnTap: () {}),
                        );
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
                      CraftStrings.strSave,
                      style: CraftStyles.tsWhiteNeutral50W60016,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            GestureDetector(
              onTap: () {
               
              },
              child: Text(
                CraftStrings.strCancel, // Dynamic Sign-In text
                textAlign: TextAlign.center,
                style: CraftStyles.tsWhiteNeutral50W60016,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
