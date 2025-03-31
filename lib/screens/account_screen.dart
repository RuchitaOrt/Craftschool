import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/personal_account_provider.dart';
import 'package:craft_school/screens/settings.dart';
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

class AccountScreen extends StatefulWidget {
  
  static const String route = "/accountScreen` ";
  
  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final BorderRadius borderRadius = const BorderRadius.all(
    Radius.circular(8),
  );

  final BorderSide focusedBorder = const BorderSide(
    width: 1.0,
  );

  final BorderSide enableBorder = BorderSide(
    width: 1.0,
  );
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription
            .getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }
      // Only call the API if it's not already loading
      final provider = Provider.of<PersonalAccountProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getFetchCustomerInfoAPI();

        
       
      }
    });
  }
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
              Consumer<PersonalAccountProvider>(builder: (context, personalProvider, _) {
                return SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 45,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                      Consumer<PersonalAccountProvider>(
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
                                  // autovalidateMode: AutovalidateMode.disabled,
                                  validator: signInProvider.validateEmailField,
                                ),
                                  CustomTextFieldWidget(
                                    title: CraftStrings.strNewpassword,
                                    hintText: CraftStrings.strEnterNewpassword,
                                    onChange: (val) {},
                                    textEditingController:
                                        signInProvider.passwordController,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    validator: signInProvider.validatePassword,
                                  ),

                                  // Password Field with Validation
                                  Text(
                                    CraftStrings.strConfirmpassword,
                                    style: CraftStyles.tsWhiteNeutral100W50014,
                                  ),
                                  SizedBox(
                                      height:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  TextFormField(
                                    style: CraftStyles.tsWhiteNeutral300W50012,
                                    obscureText:
                                        signInProvider.isPasswordObscured,
                                    controller: signInProvider
                                        .confirmpasswordController,
                                    validator:
                                        signInProvider.validateConfirmPassword,
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
                                      hintText:
                                          CraftStrings.strEnterConfirmpassword,
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

    return 
    Consumer<LandingScreenProvider>(
      builder: (context, provider, _) {return
    Scaffold(
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
          ListView(
            shrinkWrap: true,
            children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text(
                                      textAlign: TextAlign.center,
                                      "Account",
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
                  builder: (context, signInProvider, _) {
                    return ElevatedButton(
                      onPressed: () {
                        if (signInProvider.validateForm()) {
                          final provider = Provider.of<PersonalAccountProvider>(context, listen: false);
          if (!provider.isLoading) {
            provider.getUpdatepasswordAPI();
          
             Navigator.of(context)
                            .pushNamed(
                              Settings.route,
                            )
                            .then((value) {});
           
          }
                          // Proceed with form submission
                          // Navigator.pushNamed(
                          //   context,
                          //   ForgetpasswordScreen.route,
                          //   arguments: ForgetPasswordDTO(
                          //       title: CraftStrings.strResetpasswordSuccesfully,
                          //       detailText: CraftStrings
                          //           .strResetpasswordSuccesfullyDetail,
                          //       emailHint: CraftStrings.strEmail,
                          //       buttonText: CraftStrings.strSignIn,
                          //       signInText: CraftStrings.strHome,
                          //       isEmailSectionnVisble: false,
                          //       onButtonOnTap: () {
                          //         Navigator.of(
                          //           routeGlobalKey.currentContext!,
                          //         ).pushNamedAndRemoveUntil(
                          //           SignInScreen.route,
                          //           (route) => false,
                          //         );
                          //       },
                          //       onTextOnTap: () {}),
                          // );
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
              // GestureDetector(
              //   onTap: () {
                 
              //   },
              //   child: Text(
              //     CraftStrings.strCancel, // Dynamic Sign-In text
              //     textAlign: TextAlign.center,
              //     style: CraftStyles.tsWhiteNeutral50W60016,
              //   ),
              // ),
            ],
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
      });
  }
}
