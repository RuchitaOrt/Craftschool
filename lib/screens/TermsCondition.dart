import 'dart:io';

import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TermsCondition extends StatefulWidget {
    static const String route = "/termsCondition";
  const TermsCondition({super.key});

  @override
  _TermsConditionState createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: 
        Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
        return Scaffold(
        appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: provider.isCategoryVisible,
                onMenuPressed: () {
                  provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                },
                 isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
                   onCategoriesPressed: () {  provider.toggleSlidingCategory();}, isContainerVisible: provider.isContainerVisible,
              ),
            ),
      backgroundColor: CraftColors.black18,
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height:Platform.isAndroid? SizeConfig.blockSizeVertical * 22:SizeConfig.blockSizeVertical * 18,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       
                        Text(
                          CraftStrings.strTermscondition,
                          style: CraftStyles.tsWhiteNeutral50W700,
                        ),
                    
                      ],
                    ),
                  ),
                ),
              ),
             
                   infoSection("Section A – Introduction: Sets out a number of introductory matters, including that the AMS Terms and Conditions govern Content that can obtained via the use of different Apple services, including its App Stores. It explains how a user’s Home Country is determined.\n\nSection B – Payments, Taxes and Refunds: Sets out various details regarding payments, taxes and refunds. It explains amongst other matters how users will be charged and how users can request refunds.\n\nSection C – Account: Explains requirements relating to Apple Accounts, as well as minimum age requirements for creating an Apple Account.\n\nSection D – Privacy: Explains that use of the App Stores is subject to Apple’s privacy policy, available at this link https://www.apple.com/legal/privacy/.\n\nSection E – Accessibility: Explains that users can learn about accessibility features and other accessibility-related information at this link https://www.apple.com/accessibility/labels.\n\nSection F – Services and Content Usage Rules: Explains the Usage Rules for use of the Services (including the App Store) and Content, and explains that Apple may monitor users’ use of the Services and Content to ensure compliance. These Usage Rules include that users may not manipulate play counts, downloads, ratings, or reviews via any means.\n\nSection G – Termination and Suspension of Services: Explains how Apple may terminate the AMS Terms and Conditions and/or a user’s Apple Account, the software license and/or access to the Services (including the App Store). It also explains Apple"),
               
            ],
          ),
           if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
              if (provider.isCategoryVisible) SlidingCategory(
                isExpanded: provider.isCategoryVisible,
                onToggleExpansion: provider.toggleSlidingCategory,
              ),
        ],
      ),
    );
        }));
  }

  Widget infoSection(String title)
  {
    return Container(
                  margin: EdgeInsets.all(10),
                  width: SizeConfig.safeBlockHorizontal * 90,
                  decoration: BoxDecoration(
                    color: CraftColors.neutralBlue800,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Streaming MasterClass on Apple TV",style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),),
                        SizedBox(height: SizeConfig.blockSizeVertical*1,),
                       Text(title,style: CraftStyles.tsWhiteNeutral50W600.copyWith(fontSize: 12),),
                       
    
                      ],
                    ),
                  ),
                );
  }
  
}


