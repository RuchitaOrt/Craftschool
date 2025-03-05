import 'dart:io';

import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpSupport extends StatefulWidget {
    static const String route = "/helpSupport";
  const HelpSupport({super.key});

  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isContainerVisible:false,
                isCategoryVisible:false,
                onMenuPressed: () {
                  // provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                }, onCategoriesPressed: () {
                  // provider.toggleSlidingCategory(); 
                   },
              ),
            ),
      backgroundColor: CraftColors.black18,
      body: ListView(
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
         
               infoSection("Popular Blogs"),
                infoSection("Account & Billing"),
                 infoSection("Getting Started"),
                  infoSection("Using Craftschool"),
                   infoSection("Troubleshooting")
        ],
      ),
    );
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
                       Text(title,style: CraftStyles.tswhiteW600.copyWith(fontSize: 18),),
                        SizedBox(height: SizeConfig.blockSizeVertical*1,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
        itemCount: 5, // Number of items in the list
        itemBuilder: (context, index) {
          return Row(
              children: [
                // Image on the left
               SvgPicture.asset(CraftImagePath.acting,width: 12,height: 12,),
                SizedBox(width: 10), // Add some space between the image and the text
                // Text on the right
                Expanded(
                  child: Text(
                    'Item - A description of the item goes here',
                    style: CraftStyles.tsWhiteNeutral50W600.copyWith(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis, // Handle overflow
                  ),
                ),
              ],
            );
        },
      ),
    
                      ],
                    ),
                  ),
                );
  }
  
}


