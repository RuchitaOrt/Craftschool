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

class HelpSupport extends StatefulWidget {
    static const String route = "/helpSupport";
  const HelpSupport({super.key});

  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
List<String> popularBlogs = [
  "CraftSchool Holiday 2024",
  "2024 Member Holiday Offer",
  "What is Your 30-Day Satisfaction Guarantee?",
  "Upgrading and Downgrading Your Plan",
];
List<String> accountBillings = [
  "Requesting a Copy of Your Invoice or Receipt",
  "Cancelling your subscription renewal",
  "Managing iOS App Auto-Renewal",
  "Requesting a Refund",
  "Submitting Data Privacy Requests",
  "Updating Payment Information for Your Subscription",
  "Amazon Subscription Management",
  "Clearing Data Stored by MasterClass in Your Browser",
  "Creating and Managing MasterClass Profiles",
  "Downgrading Your Membership Plan Through Third Party Apps",
  "iOS App Refunds",
  "CraftSchool Subscription Charge",
  "Protecting Yourself from Fraudulent Websites",
  "Downgrading Your Membership Plan Through Third Party Apps",
];
List<String> gettingStarted = [
  "Suggest a New Class",
  "About CraftSchool Classes",
  "Introduction to MasterClass",
  "Signing into Your MasterClass Account",
  "Class Guides & Documents for Sessions",
  "Sessions by CraftSchool FAQ",
  "Troubleshooting a Gift that was Not Received",
];
List<String> usingCraftSchool = [
  "Accessing Class Guides",
  "Managing Your Class Progress",
  "Downloading Classes for Offline Viewing",
  "About CraftSchool Membership Plans",
  "Subtitles & Closed Caption for Classes on CraftSchool",
  "Editing Profile",
  "Logging Out of iOS App",
  "Certificate of Completion",
];
List<String> troubleshooting = [
  "CraftSchool App for Android TV",
  "Streaming CraftSchool on Apple TV",
  "Accessing CraftSchool on Android",
  "Payment Error",
];

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
                }, isSearchClickVisible: ()
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
                          CraftStrings.strHelpandsupport,
                          style: CraftStyles.tsWhiteNeutral50W700,
                        ),
                    
                      ],
                    ),
                  ),
                ),
              ),
             infoSection("Popular Blogs", popularBlogs),
infoSection("Account & Billing", accountBillings),
infoSection("Getting Started", gettingStarted),
infoSection("Using CraftSchool", usingCraftSchool),
infoSection("Troubleshooting", troubleshooting),

                  //  infoSection("Popular Blogs"),
                  //   infoSection("Account & Billing"),
                  //    infoSection("Getting Started"),
                  //     infoSection("Using Craftschool"),
                  //      infoSection("Troubleshooting")
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
Widget infoSection(String title, List<String> items) {
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
          Text(
            title,
            style: CraftStyles.tswhiteW600.copyWith(fontSize: 18),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      CraftImagePath.help,
                      width: 12,
                      height: 12,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        items[index],
                        style: CraftStyles.tsWhiteNeutral50W600
                            .copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

  // Widget infoSection(String title)
  // {
  //   return Container(
  //                 margin: EdgeInsets.all(10),
  //                 width: SizeConfig.safeBlockHorizontal * 90,
  //                 decoration: BoxDecoration(
  //                   color: CraftColors.neutralBlue800,
  //                   borderRadius: BorderRadius.all(Radius.circular(16)),
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(16),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                      Text(title,style: CraftStyles.tswhiteW600.copyWith(fontSize: 18),),
  //                       SizedBox(height: SizeConfig.blockSizeVertical*1,),
  //                       ListView.builder(
  //                         shrinkWrap: true,
  //                         physics: ScrollPhysics(),
  //       itemCount: 5, // Number of items in the list
  //       itemBuilder: (context, index) {
  //         return Row(
  //             children: [
  //               // Image on the left
  //              SvgPicture.asset(CraftImagePath.acting,width: 12,height: 12,),
  //               SizedBox(width: 10), // Add some space between the image and the text
  //               // Text on the right
  //               Expanded(
  //                 child: Text(
  //                   'Item - A description of the item goes here',
  //                   style: CraftStyles.tsWhiteNeutral50W600.copyWith(fontWeight: FontWeight.w500),
  //                   overflow: TextOverflow.ellipsis, // Handle overflow
  //                 ),
  //               ),
  //             ],
  //           );
  //       },
  //     ),
    
  //                     ],
  //                   ),
  //                 ),
  //               );
  // }
  
}


