import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/account_screen.dart';
import 'package:craft_school/screens/change_plan.dart';
import 'package:craft_school/screens/personal_screen.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart'; // For SizeConfig

class Settings extends StatefulWidget {
  static const String route = "/setting";
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
   final List<Map<String, String>> deviceList = [
    {'label': 'Apple TV',},
    {'label': 'Android TV', },
    {'label': 'Amazon Fire TV', },
    {'label': 'iphone & ipad', },
    {'label': 'Android Ohones & Tablets', },
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: false,
                onMenuPressed: () {
                  provider
                      .toggleSlidingContainer(); // Trigger toggle when menu is pressed
                },
                onCategoriesPressed: () {},
                isContainerVisible: false,
              ),
            ),
            backgroundColor: CraftColors.black18,
            body: Stack(
              children: [
                // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: 0.0, maxHeight: double.infinity),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      simpleTransplantPlanWidget(),
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

  Widget simpleTransplantPlanWidget() {
    return Consumer<LandingScreenProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "Settings",
                  style:
                      CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 25),
                ),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Personal",
                              style: CraftStyles.tsWhiteNeutral50W700
                                  .copyWith(fontSize: 20),
                            ),
 GestureDetector(
  onTap: ()
  {
    Navigator.of(context)
                        .pushNamed(
                          PersonalScreen.route,
                        )
                        .then((value) {});
  },
   child: Text(
                                textAlign: TextAlign.center,
                                "Edit",
                                style: CraftStyles.tsWhiteNeutral50W700
                                    .copyWith(fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    decorationColor: CraftColors.neutral100,
                                    decorationThickness: 0.7),
                              ),
 ),
                              
                          ],
                        ),
                      ),
                      informationPlan("First name", "Vineet"),
                      informationPlan("Last name", "Rai"),
                      informationPlan("Phone number", "+919029847566"),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Account",
                              style: CraftStyles.tsWhiteNeutral50W700
                                  .copyWith(fontSize: 20),
                            ),
                            GestureDetector(
  onTap: ()
  {
    Navigator.of(context)
                        .pushNamed(
                          AccountScreen.route,
                        )
                        .then((value) {});
  },
   child: Text(
                                textAlign: TextAlign.center,
                                "Edit",
                                style: CraftStyles.tsWhiteNeutral50W700
                                    .copyWith(fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    decorationColor: CraftColors.neutral100,
                                    decorationThickness: 0.7),
                              ),
 ),
                          ],
                        ),
                      ),
                      informationPlan("Email", "Vineet@gmail.com"),
                      informationPlan("Password", "********"),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "You're currently signed in with your Google account. ",
                              style: CraftStyles.tsWhiteNeutral300W400,
                            ),
                            TextSpan(
                              text:
                                  "Create a CraftSchool password and unlink your Google account here.",
                              style: CraftStyles.tsWhiteNeutral300W400.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors
                                    .white, // Ensure the underline is white
                                decorationThickness: 0.5,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          "How to setup CraftSchool on any of these devices.",
                          style: CraftStyles.tsWhiteNeutral50W700
                              .copyWith(fontSize: 20),
                        ),
                      ),
                         Center(
                           child: SvgPicture.asset(
                                                 CraftImagePath.device, // Replace with your image path
                                                 fit: BoxFit.contain, // Ensures the image fills the space
                                               ),
                         ),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16.0, // Space between chips
                      runSpacing: 2, // Space between rows of chips
                      children: deviceList.map((chip) {
                        return Text(
                            chip['label']!,
                            style: CraftStyles.tsWhiteNeutral300W400.copyWith(
                               decoration: TextDecoration.underline,
                               color: CraftColors.primaryBlue500,
                              decorationColor: CraftColors.primaryBlue500,  // Ensure the underline is white
                              decorationThickness: 0.5, 
                            ),
                          );
                      }).toList(),
                    ),
                  ),

                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                     
                    ],
                  ),
                ),
              ),
                Card(
                  
                elevation: 1.0,
                color: CraftColors.neutralBlue800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal*100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "Membership",
                                style: CraftStyles.tsWhiteNeutral50W700
                                    .copyWith(fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: ()
                                {
                                   Navigator.of(context)
                        .pushNamed(
                          ChangePlan.route,
                        )
                        .then((value) {});
                                },
                                child: Icon(Icons.menu))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No Membership",style:   CraftStyles.tsWhiteNeutral300W400,),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
               Card(
                  
                elevation: 1.0,
                color: CraftColors.neutralBlue800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal*100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Payment Method",
                            style: CraftStyles.tsWhiteNeutral50W700
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No Payment Stored",style:   CraftStyles.tsWhiteNeutral300W400,),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
               Card(
                  
                elevation: 1.0,
                color: CraftColors.neutralBlue800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal*100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "App Language",
                            style: CraftStyles.tsWhiteNeutral50W700
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Change your default language",style:   CraftStyles.tsWhiteNeutral300W400,),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
               Card(
                  
                elevation: 1.0,
                color: CraftColors.neutralBlue800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal*100,
                  child: GestureDetector(
                    onTap: ()
                    {
                      provider.logoutAPI();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  "Sign Out",
                                  style: CraftStyles.tsWhiteNeutral50W700
                                      .copyWith(fontSize: 20),
                                ),
                                Icon(Icons.logout,color: CraftColors.neutral100,)
                              ],
                            ),
                          ),
                          
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
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
            style: CraftStyles.tsWhiteNeutral50W60016,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 0.5,
          ),
          Text(
            textAlign: TextAlign.center,
            suTitle,
            style: CraftStyles.tsWhiteNeutral100W500,
          ),
          Divider(
            thickness: 0.1,
          )
        ],
      ),
    );
  }


}
