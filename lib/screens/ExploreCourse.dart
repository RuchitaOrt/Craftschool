import 'dart:io';

import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/signup_screen.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/custom_background_container.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/sign_In_provider.dart';
import 'package:craft_school/widgets/or_divider.dart';

class ExploreCourse extends StatelessWidget {
  static const String route = "/exploreCourse";
  ExploreCourse({super.key});
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
            ? SizeConfig.blockSizeVertical * 45
            : SizeConfig.blockSizeVertical * 57,
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
                      ? SizeConfig.blockSizeVertical * 21
                      : SizeConfig.blockSizeVertical * 19,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                     
                      SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                      
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

                                  
                                 CheckboxListTile(
                                  contentPadding: EdgeInsets.all(0),
          title: Text("I agree to receive email updates",style:  CraftStyles.tsNeutral100W900.copyWith(color: CraftColors.neutral100),),
          value: signInProvider.isExploreChecked,
          checkColor: CraftColors.neutral100,
          activeColor: CraftColors.neutral900,
          onChanged: (bool? value) {
           
              signInProvider.isExploreChecked = value!;
            
          },
          controlAffinity: ListTileControlAffinity.leading, // Puts checkbox on left side
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

    return 
    ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {return
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
                isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
              ),
            ),
      backgroundColor: CraftColors.black18,
      body: Stack(
        children: [
          ChangeNotifierProvider(
            create: (_) => SignInProvider(),
            child: ListView(
              shrinkWrap: true,
              children: [
             Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height:Platform.isAndroid?SizeConfig.blockSizeVertical * 22: SizeConfig.blockSizeVertical * 18,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(CraftImagePath.backGroundimage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(CraftImagePath.whiteCamera),
              SizedBox(height: SizeConfig.blockSizeVertical * 3),
              Text(
                CraftStrings.strExploretitle,
                style: CraftStyles.tsWhiteNeutral50W700,
              ),
               SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Text(
                CraftStrings.strExploreSubtitle,
                style: CraftStyles.tsNeutral100W900.copyWith(color: CraftColors.neutral100,fontSize: 10),
              ),
            ],
          ),
              ), // Call the extracted widget
          ),
              ),
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
                             print(signInProvider.isExploreChecked);
                            signInProvider.exploreCourse();
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
                          CraftStrings.strExploreCourse,
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
