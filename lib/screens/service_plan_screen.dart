

import 'package:craft_school/dto/GetAllPlanResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/personal_account_provider.dart';
import 'package:craft_school/screens/AllCourses.dart';
import 'package:craft_school/screens/change_plan.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:provider/provider.dart'; // For SizeConfig
class PlanPriceCardScreen extends StatefulWidget {
  static const String route = "/servicePlan";
  const PlanPriceCardScreen({Key? key}) : super(key: key);

  @override
  _PlanPriceCardScreenState createState() => _PlanPriceCardScreenState();
}

class _PlanPriceCardScreenState extends State<PlanPriceCardScreen> {

  @override
  void initState() {
    super.initState();

    // Run the API calls when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI();
        
      }
     
      // Only call the API if it's not already loading
      final provider = Provider.of<PersonalAccountProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getPlanListAPI();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(
      builder: (context, provider, _) {
        // Show a loading indicator while the subscription is loading
        if (provider.isSubscriptionLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
           appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: provider.isCategoryVisible,
                onMenuPressed: () {
                  provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                },
                   onCategoriesPressed: () {  provider.toggleSlidingCategory();}, isContainerVisible: provider.isContainerVisible,
              ),
            ),
          backgroundColor: CraftColors.black18,
          body: Stack(
            children: [
              // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 0.0, maxHeight: double.infinity),
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                
                    upgradePlanWidget(provider),
                     simpleTransplantPlanWidget(provider),
                        OrDivider(text: CraftStrings.strOR,),
                SizedBox(height: SizeConfig.blockSizeVertical*2,),
                singleCourseAccess(),
                       SizedBox(height: SizeConfig.blockSizeVertical*2,), 
                  ],
                ),
              ),
              if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
              if (provider.isCategoryVisible) SlidingCategory(
                isExpanded: provider.isCategoryVisible,
                onToggleExpansion: provider.toggleSlidingCategory,
              ),
            ],
          ),
        );
      },
    );
  }
  Widget singleCourseAccess()
{
  return Padding(
    padding: const EdgeInsets.only(left: 20,right: 
    20),
    child: Column(children: [
      Text(
                textAlign: TextAlign.center,
                "Single Course Access !",
                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Perfect for learners who want to focus on just one course. Choose any course you like and gain lifetime access to all its lessons, resources, and expert insights.",
                      style: CraftStyles.tsWhiteNeutral300W500,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Consumer<LandingScreenProvider>(
                  builder: (context, provider, child) {
                return SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: provider.joinCommunityList
                        .length, // Use the length of the list from provider
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 88,
                            child: Row(
                              children: [
                                Image.asset(CraftImagePath.check),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 70,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: provider
                                                        .joinCommunityList[index]
                                                    ['title']!,
                                                style: CraftStyles
                                                    .tsWhiteNeutral300W500,
                                              ),
                                              TextSpan(
                                                text: provider
                                                        .joinCommunityList[index]
                                                    ['subtext']!,
                                                style: CraftStyles
                                                    .tsWhiteNeutral300W500
                                                    .copyWith(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: ElevatedButton(
                  onPressed: () {
   Navigator.of(routeGlobalKey.currentContext!)
                      .pushNamed(
                        AllCourses.route,
                      )
                      .then((value) {});
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(SizeConfig.blockSizeHorizontal * 45,
                        SizeConfig.blockSizeVertical * 5),
                    backgroundColor: CraftColors.primaryBlue550,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    CraftStrings.strBrowseCourse,
                    style: CraftStyles.tsWhiteNeutral50W60016,
                  ),
                ),
              ),
    ],),
  );
}

  Widget informationPlan(String title, String suTitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.center,
            title,
            style: CraftStyles.tsWhiteNeutral300W500,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Text(
            textAlign: TextAlign.center,
            suTitle,
            style: CraftStyles.tsWhiteNeutral50W60016,
          ),
          Divider(
            thickness: 0.1,
          )
        ],
      ),
    );
  }

  Widget planPriceCard(String title, String price,bool isStandard ) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: SizeConfig.blockSizeHorizontal * 95,
      decoration: BoxDecoration(
         color: CraftColors.neutralBlue750,
        gradient:isStandard?  LinearGradient(
            begin: Alignment.topLeft, // Starting point of the gradient
            end: Alignment.bottomRight, // Ending point of the gradient
            colors:[
              CraftColors.secondary550,
             CraftColors.primaryBlue500
            ] ):LinearGradient(colors:[ CraftColors.neutralBlue750,
             CraftColors.neutralBlue750] ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              textAlign: TextAlign.center,
              title,
              style: CraftStyles.tswhiteW600.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            // Price
            Text(
              textAlign: TextAlign.center,
              price,
              style: CraftStyles.tswhiteW600.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
Widget simpleTransplantPlanWidget(LandingScreenProvider subscribedProvider) {
    return Consumer<PersonalAccountProvider>(
    builder: (context, provider, _) {
  // if (provider.isLoading) {
  //         return Scaffold(
  //           body: Center(child: CircularProgressIndicator()),
  //         );
  //       }
    return
        Container(
    margin: EdgeInsets.all(8),
    width: SizeConfig.safeBlockHorizontal * 85,
    decoration: BoxDecoration(
      color: CraftColors.neutralBlue850,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Title
          Text(
            textAlign: TextAlign.center,
            "Simple, transparent plans",
            style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 25),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          // Subtitle
          Text(
            textAlign: TextAlign.center,
            "We believe Untitled should be accessible to all companies, no matter the size.",
            style: CraftStyles.tsWhiteNeutral300W500,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          // Wrap the CustomScrollView inside Expanded to avoid unbounded height error
        provider.plandata.isEmpty?Container():  Card(
            elevation: 1.0,
            color: CraftColors.neutralBlue800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  planPriceCard(provider.plandata[0].planName,"₹ ${provider.plandata[0].cost}/-",false),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  informationPlan(
                      "Devices you can watch at the same time", provider.plandata[0].simaltaneousDevicesAccessible.toString()),
                  informationPlan(
                      "Download devices", provider.plandata[0].downloadDevices.toString()),
                  informationPlan(
                      "All courses across 7 categories", provider.plandata[0].courses),
                  informationPlan(
                      "Access to sessions by CraftSchool", provider.plandata[0].communityAccess),
                  informationPlan(
                      "Supported devicese",provider.plandata[0].supportedDevices),
                  informationPlan(
                      "Join exclusive Community", provider.plandata[0].communityAccess),
                       informationPlan(
                      "Plan Type", provider.plandata[0].planType),
                       
                        SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
     subscribedProvider.subscriptionList.isNotEmpty?
   subscribedProvider.subscriptionList[0].planInfo.isEmpty?subscribeNow(CraftColors.neutralBlue800,subscribedProvider,provider.plandata[0].id.toString()): 
    (subscribedProvider.subscriptionList[0].planInfo[0].planName==provider.plandata[0].planName)?Container(): 
      subscribeNow(CraftColors.neutralBlue800,subscribedProvider,provider.plandata[0].id.toString()):subscribeNow(CraftColors.neutralBlue800,subscribedProvider,provider.plandata[0].id.toString()) ,
               SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
                ],
              ),
            ),
          ),
         
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
       provider.plandata.isEmpty?Container():   Card(
            elevation: 1.0,
            color: CraftColors.neutralBlue800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  planPriceCard(provider.plandata[1].planName,"₹ ${provider.plandata[1].cost}/-",true),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                   informationPlan(
                      "Devices you can watch at the same time", provider.plandata[1].simaltaneousDevicesAccessible.toString()),
                  informationPlan(
                      "Download devices", provider.plandata[1].downloadDevices.toString()),
                  informationPlan(
                      "All courses across 7 categories", provider.plandata[1].courses),
                  informationPlan(
                      "Access to sessions by CraftSchool", provider.plandata[1].communityAccess),
                  informationPlan(
                      "Supported devicese",provider.plandata[1].supportedDevices),
                  informationPlan(
                      "Join exclusive Community", provider.plandata[1].communityAccess),
                       informationPlan(
                      "Plan Type", provider.plandata[1].planType),
                        SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
           subscribedProvider.subscriptionList.isNotEmpty?
            subscribedProvider.subscriptionList[0].planInfo.isEmpty? subscribeNow(CraftColors.primaryBlue550,subscribedProvider,provider.plandata[1].id.toString()):
           
           (
            subscribedProvider.subscriptionList[0].planInfo[0].planName==provider.plandata[1].planName)?Container():  
             subscribeNow(CraftColors.primaryBlue550,subscribedProvider,provider.plandata[1].id.toString())
             :subscribeNow(CraftColors.primaryBlue550,subscribedProvider,provider.plandata[1].id.toString()) ,
               SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
                ],
              ),
            ),
          ),
         
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
        provider.plandata.isEmpty?Container():  Card(
            elevation: 1.0,
            color: CraftColors.neutralBlue800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  planPriceCard(provider.plandata[2].planName,"₹ ${provider.plandata[2].cost}/-",false),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                 informationPlan(
                      "Devices you can watch at the same time", provider.plandata[2].simaltaneousDevicesAccessible.toString()),
                  informationPlan(
                      "Download devices", provider.plandata[2].downloadDevices.toString()),
                  informationPlan(
                      "All courses across 7 categories", provider.plandata[2].courses),
                  informationPlan(
                      "Access to sessions by CraftSchool", provider.plandata[2].communityAccess),
                  informationPlan(
                      "Supported devicese",provider.plandata[2].supportedDevices),
                  informationPlan(
                      "Join exclusive Community", provider.plandata[2].communityAccess),
                       informationPlan(
                      "Plan Type", provider.plandata[2].planType),
                        SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
         subscribedProvider.subscriptionList.isNotEmpty?
            subscribedProvider.subscriptionList[0].planInfo.isEmpty? subscribeNow(CraftColors.neutralBlue800,subscribedProvider,provider.plandata[2].id.toString()):
         
         (subscribedProvider.subscriptionList[0].planInfo[0].planName==provider.plandata[2].planName)?Container():  
          subscribeNow(CraftColors.neutralBlue800,subscribedProvider,provider.plandata[2].id.toString())
         :subscribeNow(CraftColors.neutralBlue800,subscribedProvider,provider.plandata[2].id.toString()) ,
               SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
                ],
              ),
            ),
          ),
         
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
        ],
      ),
    ),
         );
       });
  }
  Widget upgradePlanWidget(LandingScreenProvider provider) {
    return provider.subscriptionList.isEmpty
        ? Container()
        : provider.subscriptionList[0].planInfo.isEmpty
            ? Container()
            : Container(
                margin: EdgeInsets.all(8),
                width: SizeConfig.safeBlockHorizontal * 85,
                decoration: BoxDecoration(
                  color:  provider.subscriptionList[0].planInfo[0].membershipStatus==2?const Color.fromARGB(255, 31, 26, 6):provider.subscriptionList[0].planInfo[0].membershipStatus==3?Color.fromARGB(255, 42, 17, 3):Color.fromARGB(255, 18, 28, 18),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          textAlign: TextAlign.start,
                          "🎉 You've subscribed to the membership!",
                          style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                        // "membership_status": 1   - 1 - Green  , 2 - Oranges (15 days)  3 - Red (expired)
                  provider.subscriptionList[0].planInfo[0].membershipStatus==1?Container():      Card(
                    
                        elevation: 1.0,
                        color: provider.subscriptionList[0].planInfo[0].membershipStatus==2?const Color.fromARGB(255, 72, 58, 4):provider.subscriptionList[0].planInfo[0].membershipStatus==3?Color.fromARGB(255, 81, 30, 3): const Color.fromARGB(255, 2, 44, 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: provider.subscriptionList[0].planInfo[0].membershipStatus==2?
                         Padding(
                           padding: const EdgeInsets.all(4.0),
                           child: Text("Your membership will get expired in ${provider.subscriptionList[0].planInfo[0].membershipRemainingDays.toString()} days.",
                           style:  CraftStyles.tswhiteW600.copyWith(fontSize: 12,color: CraftColors.yellow),),
                         ):
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Your membership has been expired.",style: CraftStyles.tswhiteW600.copyWith(fontSize: 12,color: CraftColors.red),),
                        ),
                        ),
                      Card(
                        elevation: 1.0,
                        color:provider.subscriptionList[0].planInfo[0].membershipStatus==2?const Color.fromARGB(255, 72, 58, 4):provider.subscriptionList[0].planInfo[0].membershipStatus==3?Color.fromARGB(255, 81, 30, 3): const Color.fromARGB(255, 2, 44, 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          provider.subscriptionList[0].planInfo[0].planName,
                                          style: CraftStyles.tswhiteW600.copyWith(fontSize: 14),
                                        ),
                                        
                                        Text(
                                          textAlign: TextAlign.center,
                                          "${provider.subscriptionList[0].planInfo[0].planMembershipDate}",
                                          style: CraftStyles.tswhiteW600.copyWith(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    
                                    ElevatedButton(
                                      onPressed: () {
                               Navigator.of(context)
                        .pushNamed(
                          ChangePlan.route,
                        )
                        .then((value) {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(SizeConfig.blockSizeHorizontal * 5, SizeConfig.blockSizeVertical * 4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: BorderSide(color: CraftColors.neutral100),
                                        ),
                                        backgroundColor: CraftColors.primaryBlue550,
                                        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                                        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                      child: Text("Upgrade Plan", style: CraftStyles.tsWhiteNeutral50W600.copyWith(fontSize: 12)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
  Widget subscribeNow(Color bgcolor,LandingScreenProvider provider,String planId)
  {
    return Center(
            child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 82,
                  child: ElevatedButton(
                    onPressed: () {
                       provider.subscribeNowAPI(planId,"","");
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(SizeConfig.blockSizeVertical * 45,
                          SizeConfig.blockSizeVertical * 5),
                      backgroundColor:
                          bgcolor!,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: CraftColors
                              .white, // Set the border color
                          width: 0.2, // Set the border width
                        ),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          CraftStrings.strSubscribeNow,
                          style: CraftStyles.tsWhiteNeutral50W60016
                              .copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
          );
  }
}
