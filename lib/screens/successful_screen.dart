import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/membership_provider.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SuccessfulScreen extends StatelessWidget {
  static const String route = "/successfulScreen` ";
  SuccessfulScreen({super.key});
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

    return ChangeNotifierProvider(
      create: (_) => LandingScreenProvider(),
      child: Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {return Scaffold(
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
                   onCategoriesPressed: () {  provider.toggleSlidingCategory();}, isContainerVisible: provider.isCategoryVisible,
              ),
            ),
      backgroundColor: CraftColors.black18,
      body: ChangeNotifierProvider(
          create: (_) => MembershipProvider(),
          child: Consumer<MembershipProvider>(
              builder: (context, membershipProvider, _) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      SvgPicture.asset(
                        CraftImagePath.successful,
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeHorizontal * 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Your Plan Has Been Successfully Updated!",
                            style: CraftStyles.tsWhiteNeutral50W700
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      //chnage plan
                      successsWidget(membershipProvider),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 30,
                            right: SizeConfig.blockSizeHorizontal * 30),
                        child: SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 43,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(
                                    LandingScreen.route,
                                  )
                                  .then((value) {});
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(SizeConfig.blockSizeHorizontal * 43,
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
                              CraftStrings.strFinish,
                              style: CraftStyles.tsWhiteNeutral50W60016,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                 if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
              if (provider.isCategoryVisible) SlidingCategory(
                isExpanded: provider.isCategoryVisible,
                onToggleExpansion: provider.toggleSlidingCategory,
              ),
              ],
            );
          })),
    );
        }));
  }

  Widget successsWidget(MembershipProvider membershipProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.start,
          "Enjoy exclusive access to premium courses and personalized content tailored to your interests. Explore a world of learning across acting, filmmaking, screenwriting, and more.",
          style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget confirmPlan(MembershipProvider membershipProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.start,
          "Current Plan",
          style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
        ),
        planPriceCard("Standard", "₹ 4299/-", false),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Text(
          textAlign: TextAlign.start,
          "New Plan",
          style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
        ),
        planPriceCard("Basic", "₹ 799/-", false),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        Text(
          textAlign: TextAlign.start,
          "Your new plan will start immediately, and your previous plan will be canceled. The payment for the updated plan will be processed instantly. To manage your subscription or cancel, visit craftschool.com/cancelplan.",
          style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget planPriceCard(String title, String price, bool isStandard) {
    return Container(
      margin: EdgeInsets.all(6),
      width: SizeConfig.blockSizeHorizontal * 95,
      height: SizeConfig.safeBlockVertical * 8,
      decoration: BoxDecoration(
        gradient: isStandard
            ? LinearGradient(
                begin: Alignment.topLeft, // Starting point of the gradient
                end: Alignment.bottomRight, // Ending point of the gradient
                colors: [CraftColors.secondary550, CraftColors.primaryBlue500])
            : LinearGradient(colors: [
                CraftColors.neutralBlue800,
                CraftColors.neutralBlue800
              ]),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              title,
              style: CraftStyles.tswhiteW600.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            // Subtitle
            Text(
              textAlign: TextAlign.center,
              price,
              style: CraftStyles.tswhiteW600
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
