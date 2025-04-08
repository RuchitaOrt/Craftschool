import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/membership_provider.dart';
import 'package:craft_school/screens/successful_screen.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/PlanPriceCard.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChangePlan extends StatefulWidget {
  static const String route = "/changePlan";
  const ChangePlan({super.key});

  @override
  _ChangePlanState createState() => _ChangePlanState();
}

class _ChangePlanState extends State<ChangePlan> {
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
      print("getMembershipPlanAPI");
      // Only call the API if it's not already loading
      final provider = Provider.of<MembershipProvider>(context, listen: false);
      if(!provider.isMembershipLoading)
      {
        provider.getMembershipPlanAPI();
print("completed");
provider.getMembershipPlanAPI();
print("completed");
print(provider.membershipList.length);
      }
        
      
    });
  }

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
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: provider.isCategoryVisible,
                onMenuPressed: () {
                  provider
                      .toggleSlidingContainer(); // Trigger toggle when menu is pressed
                },
                onCategoriesPressed: () {
                  provider.toggleSlidingCategory();
                },
                isContainerVisible: provider.isContainerVisible,
                isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
              ),
            ),
            backgroundColor: CraftColors.black18,
            body: Consumer<MembershipProvider>(
                builder: (context, membershipProvider, _) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator();
                  }
              return Stack(
                children: [
                membershipProvider.membershipList.isEmpty?Container():  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
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
                                "Membership",
                                style: CraftStyles.tsWhiteNeutral50W700
                                    .copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              membershipProvider.isChangePlan
                                  ? "Confirm Plan"
                                  : "Change Plan",
                              style: CraftStyles.tsWhiteNeutral50W700
                                  .copyWith(fontSize: 20),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "Enjoy insider knowledge from top actors and filmmakers with \nimmersive, on-demand courses across acting, production, and more.",
                              style: CraftStyles.tsWhiteNeutral300W500
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Text(membershipProvider.membershipList[0].currentPlanInfo[0].cost),
                        //chnage plan
                        membershipProvider.isChangePlan
                            ? confirmPlan(membershipProvider)
                            : changePlan(membershipProvider),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: ElevatedButton(
                              onPressed: () {
                             
                                if (membershipProvider.isChangePlan) {
                                     provider.subscribeNowAPI(membershipProvider.selectedPlanIndex.toString(),"","");
                                  // Navigator.of(
                                  //   routeGlobalKey.currentContext!,
                                  // ).pushNamed(
                                  //   SuccessfulScreen.route,
                                  // );
                                } else if (!membershipProvider.isChangePlan) {
print(membershipProvider.selectedPlanIndex);
                                  if(membershipProvider.selectedPlanIndex!=-1)
                                  {
 membershipProvider.confirmationPlan();
                                  }
                                  else{
                                    ShowDialogs.showToast("Choose Your Plan to Upgrade");
                                  }
                                 
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
                                membershipProvider.isChangePlan
                                    ? CraftStrings.strConfirm
                                    : CraftStrings.strContinue,
                                style: CraftStyles.tsWhiteNeutral50W60016,
                              ),
                            )),
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
            }),
          );
        }));
  }

  Widget changePlan(MembershipProvider membershipProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.start,
          "Your current plan",
          style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
        ),
        Text(membershipProvider.membershipList.length.toString()),
    membershipProvider.membershipList.isNotEmpty?    planPriceCard(
            membershipProvider.membershipList[0].currentPlanInfo[0].planName,
            "₹ ${membershipProvider.membershipList[0].currentPlanInfo[0].cost}/-",
            true):Container(),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Text(
          textAlign: TextAlign.start,
          "Select a plan to subscribe",
          style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: membershipProvider.membershipList[0].planList.length,
          itemBuilder: (context, index) {
            var plan = membershipProvider.membershipList[0].planList[index];
            return PlanPriceCard(
              title: plan.planName,
              price: "₹ ${plan.cost}",
              planId:int.parse(plan.id.toString()),
              isStandard: false,
              index: index,
              selectedPlanIndex: membershipProvider.selectedPlanIndex,
              // onCheckboxChange: membershipProvider.selectPlan,
             onCheckboxChange: (title, price,planId) {
        // Handle both title and planId here
        print("Plan Selected: $title, Plan ID: $planId");
        membershipProvider.selectPlan(planId); // Update selected plan based on planId
        membershipProvider.selectPlanTitle(title);
        membershipProvider.selectPlanPrice(price);
      },
            );
          },
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
        planPriceCard(membershipProvider.membershipList[0].currentPlanInfo[0].planName, "₹ ${membershipProvider.membershipList[0].currentPlanInfo[0].cost}/-", false),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Text(
          textAlign: TextAlign.start,
          "New Plan",
          style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
        ),
        planPriceCard(membershipProvider.selectedPlanTitle, "${membershipProvider.selectedPlanPrice}/-", false),
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
