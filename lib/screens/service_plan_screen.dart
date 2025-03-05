import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
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
  Widget build(BuildContext context) {
 return  ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: 
        Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
        return
    Scaffold(
     appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: false,
                onMenuPressed: () {
                  provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                },
                   onCategoriesPressed: () {  }, isContainerVisible: false,
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
                
                       simpleTransplantPlanWidget(),
                        OrDivider(text: CraftStrings.strOR,),
                SizedBox(height: SizeConfig.blockSizeVertical*2,),
                singleCourseAccess(),
                       SizedBox(height: SizeConfig.blockSizeVertical*2,),   
                    ],
                  ),
                ),
                if (provider.isContainerVisible)
                        SlidingMenu(isVisible: provider.isContainerVisible),
              ],
            ),
    );
      }));
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
                  onPressed: () {},
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
Widget simpleTransplantPlanWidget() {
    return Consumer<LandingScreenProvider>(builder: (context, provider, child) {
      return Container(
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
              Card(
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
                      planPriceCard("Basic","₹ 799/-",false),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      informationPlan(
                          "Devices you can watch at the same time", "1"),
                      informationPlan(
                          "Download devices", "No"),
                      informationPlan(
                          "All courses across 7 categories", "No"),
                      informationPlan(
                          "Access to sessions by CraftSchool", "Learn by doing in just 30 days."),
                      informationPlan(
                          "Supported devicese", "Computer, TV, Phone or Tablet"),
                      informationPlan(
                          "Join exclusive Community", "Yes"),
                            SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Center(
                child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 82,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(SizeConfig.blockSizeVertical * 45,
                              SizeConfig.blockSizeVertical * 5),
                          backgroundColor:
                              CraftColors.neutralBlue800,
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
              ),
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
              Card(
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
                      planPriceCard("Standard","₹ 4299/-",true),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      informationPlan(
                          "Devices you can watch at the same time", "1"),
                      informationPlan(
                          "Download devices", "No"),
                      informationPlan(
                          "All courses across 7 categories", "No"),
                      informationPlan(
                          "Access to sessions by CraftSchool", "Learn by doing in just 30 days."),
                      informationPlan(
                          "Supported devicese", "Computer, TV, Phone or Tablet"),
                      informationPlan(
                          "Join exclusive Community", "Yes"),
                            SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Center(
                child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 82,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(SizeConfig.blockSizeVertical * 45,
                              SizeConfig.blockSizeVertical * 5),
                          backgroundColor:
                              CraftColors.primaryBlue500,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                             // Set the border color
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
              ),
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
               Card(
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
                      planPriceCard("Premium","₹ 8799/-",false),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      informationPlan(
                          "Devices you can watch at the same time", "1"),
                      informationPlan(
                          "Download devices", "No"),
                      informationPlan(
                          "All courses across 7 categories", "No"),
                      informationPlan(
                          "Access to sessions by CraftSchool", "Learn by doing in just 30 days."),
                      informationPlan(
                          "Supported devicese", "Computer, TV, Phone or Tablet"),
                      informationPlan(
                          "Join exclusive Community", "Yes"),
                            SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Center(
                child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 82,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(SizeConfig.blockSizeVertical * 45,
                              SizeConfig.blockSizeVertical * 5),
                          backgroundColor:
                              CraftColors.neutralBlue800,
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
              ),
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
}
