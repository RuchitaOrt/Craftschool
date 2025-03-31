import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/providers/forget_password_provider.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ForgetpasswordScreen extends StatelessWidget {
  static const String route = "/forgetpassword";
  
  // Add string arguments to the constructor
  final String title;
  final String detailText;
  final String emailHint;
  final String buttonText;
  final String signInText;
  final bool isEmailSectionnVisble;
  final VoidCallback? onTextOnTap;
  final VoidCallback? onButtonOnTap;


  // Modify the constructor to accept the dynamic strings
  ForgetpasswordScreen({
    super.key,
    required this.title,
    required this.detailText,
    required this.emailHint,
    required this.buttonText,
    required this.signInText, required this.isEmailSectionnVisble,
   required  this.onTextOnTap,
    required this.onButtonOnTap
  });

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
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: CraftColors.black18,
      body: ChangeNotifierProvider(
        create: (_) => ForgetPasswordProvider(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical * 8),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 68,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(CraftImagePath.whiteCamera, width: 50, height: 50),
                    SizedBox(height: SizeConfig.blockSizeVertical * 3),
                    Text(
                      textAlign: TextAlign.center,
                      title, // Dynamic title
                      style: CraftStyles.tsWhiteNeutral50W700,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        detailText, // Dynamic details text
                        textAlign: TextAlign.center,
                        style: CraftStyles.tsWhiteNeutral100W500,
                      ),
                    ),
                    if(isEmailSectionnVisble)
                    Consumer<ForgetPasswordProvider>(
                      builder: (context, forgetPasswordProvider, _) {
                        return Form(
                          key: forgetPasswordProvider.formKey,
                          child: CustomTextFieldWidget(
                            title: CraftStrings.strEmail,
                            hintText: emailHint, // Dynamic email hint
                            onChange: (val) {},
                            textEditingController: forgetPasswordProvider.emailController,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: forgetPasswordProvider.validateEmailField,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Consumer<ForgetPasswordProvider>(
                  builder: (context, forgetPasswordProvider, _) {
                    return ElevatedButton(
                      onPressed:
                    //  isEmailSectionnVisble?
                    //    () {
                    //     if (forgetPasswordProvider.validateForm()) {
                    //       // Proceed with form submission
                    //       // Navigator.pushNamed(
                    //       //                       context,
                    //       //                       ForgetpasswordScreen.route,
                    //       //                       arguments: ForgetPasswordDTO(
                    //       //                         title: CraftStrings.strResetLinkSent,
                    //       //                         detailText: CraftStrings
                    //       //                             .strResetLinkDetail,
                    //       //                         emailHint:
                    //       //                             CraftStrings.strEmail,
                    //       //                         buttonText:
                    //       //                             CraftStrings.strSignIn,
                    //       //                         signInText:
                    //       //                             CraftStrings.strHome,
                    //       //                         isEmailSectionnVisble: false,
                    //       //                       ),
                    //       //                     );
                    //        Navigator.of(
                    //       routeGlobalKey.currentContext!,
                    //     ).pushNamedAndRemoveUntil(
                    //       CreatePasswordScreen.route,
                    //       (route) => false,
                    //     );
                    //     } else {
                    //       // Form is invalid, show error messages
                    //     }
                      
                    //   }: 
//                     ()
//                     {
// Navigator.of(
//                                                         routeGlobalKey
//                                                             .currentContext!,
//                                                       ).pushNamedAndRemoveUntil(
//                                                         CreatePasswordScreen
//                                                             .route,
//                                                         (route) => false,
//                                                       );
//                     },
                   isEmailSectionnVisble?()
                   {
                    forgetPasswordProvider.forgetPassword();
                   }:    onButtonOnTap,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(SizeConfig.blockSizeVertical * 100, SizeConfig.blockSizeVertical * 5),
                        backgroundColor: CraftColors.primaryBlue550,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        buttonText, // Dynamic button text
                        style: CraftStyles.tsWhiteNeutral50W60016,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              GestureDetector(
                onTap: onTextOnTap,
               
                child: Text(
                  signInText, // Dynamic Sign-In text
                  textAlign: TextAlign.center,
                  style: CraftStyles.tsWhiteNeutral50W60016,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
