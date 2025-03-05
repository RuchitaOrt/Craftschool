
import 'package:craft_school/providers/CourseDetailProvider.dart';
import 'package:craft_school/screens/myCourse.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/BrowseOtherCourse.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Coursedetailscreen extends StatelessWidget {
  static const String route = "/courseDetail";
  const Coursedetailscreen({super.key});

   Widget imageWithTextColumn(String image,String title)
   {
    return  Expanded(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      image, // Replace with your image path
                      fit: BoxFit.contain, // Ensures the image fills the space
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical*1,),
                     Text(
title,
                    style: CraftStyles.tsWhiteNeutral200W500,
                  ),
                  ],
                ),
              );
   }
   Widget moduleWidget() {
  return Consumer<CourseDetailProvider>(
    builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          
                        decoration: BoxDecoration(
                          color: CraftColors.neutralBlue800,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12,top: 12),
                      child: Text(
                        "Modules",
                        style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                      ),
                    ),
                   
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical, // Allow vertical scrolling
                  child: Column(
                    children: List.generate(provider.blogsItem.length, (index) {
                      bool isExpanded = provider.blogsItem[index]['isExpanded'];
                      bool isChecked = provider.blogsItem[index]['isChecked']; // Add checkbox state
          
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row for Checkbox, Image, and Text
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Checkbox block (before image)
                                
                                // Image block (Click to expand)
                                GestureDetector(
                                  onTap: () {
                                    // Toggle the expanded state via the provider
                                   
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    width:  SizeConfig.blockSizeHorizontal * 20, // Original width when collapsed
                                    height: SizeConfig.blockSizeVertical * 14, // Original height when collapsed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: AssetImage(provider.blogsItem[index]['image']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                                // Initially displayed text block (text beside image)
                             
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Row with "New!" label and Expand Icon
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                             
                                             
                                
                                            ],
                                          ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 2),
                                           child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                            
                                            Text(
                                              provider.blogsItem[index]['title'],
                                              style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                            ),
                                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                            // Subtext (short description)
                                            Text(
                                              provider.blogsItem[index]['subtext'],
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
                                            ),
                                       
                                           Row(
                                          children: [
                                             Checkbox(
                                  value: isChecked,
                                  
                                  onChanged: (bool? value) {
                                    // Toggle the checkbox state via the provider
                                    provider.toggleCheckbox(index, value ?? false);
                                  },
                                  activeColor: Colors.blue, // Customize checkbox color
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                           SvgPicture.asset(
                                                   CraftImagePath.time),
                                            SizedBox(
                                                width:
                                                    SizeConfig.blockSizeHorizontal *
                                                        2),
                                            Text(
                                              "04:36",
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W60016
                                                  .copyWith(fontSize: 12),
                                            ),
                                          ],
                                        )
                                           ],),
                                         )
                                        ],
                                      ),
                                    ),
                                  ),
                                
                              ],
                            ),
                           
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
   Widget buyNowCourseDetailWidget() {
  return Consumer<CourseDetailProvider>(
    builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                                 
                            Text(
                                       "Master :",
                                        style: CraftStyles.tsWhiteNeutral300W50012.copyWith(fontSize: 14),
                                      ),
                                       Text(
                                       "Salim Khan",
                                        style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                      ),
                          
                        ],
                      ),
                       SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                                 
                            Text(
                                       "Chapters :",
                                        style: CraftStyles.tsWhiteNeutral300W50012.copyWith(fontSize: 14),
                                      ),
                                       Text(
                                       "28 Videos",
                                        style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                      ),
                          
                        ],
                      ),
                       SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                                 
                            Text(
                                       "Duration :",
                                        style: CraftStyles.tsWhiteNeutral300W50012.copyWith(fontSize: 14),
                                      ),
                                       Text(
                                       "6 hours,17 minutes",
                                        style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                      ),
                          
                        ],
                      ),
                       SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
                       Text(
                                       "Topics Covered :",
                                        style: CraftStyles.tsWhiteNeutral300W50012.copyWith(fontSize: 14),
                                      ),
                                       SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical, // Allow vertical scrolling
                child: Column(
                  children: List.generate(provider.courseCoveredTopics.length, (index) {
                  
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                                 
                            Container(
                              
                                decoration: BoxDecoration(
                                   color: CraftColors.neutralBlue750,
                borderRadius:
                    BorderRadius.circular(8), // Border radius for the checkbox
               
              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
                                child: Text(
                                            provider.courseCoveredTopics[index]['title'],
                                            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                          ),
                              ),
                            ),
                          
                        ],
                      ),
                    );
                  }),
                ),
              ),
              learnNewWidget()
            ],
          ),
        ),
      );
    },
  );
}
Widget learnNewWidget()
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
    
      children: [
        Text(
                textAlign: TextAlign.center,
              CraftStrings.strCourseDetailText,
                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
             
              Consumer<CourseDetailProvider>(
                  builder: (context, provider, child) {
                return SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: provider.learnNewList
                        .length, // Use the length of the list from provider
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                    
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
                                                        .learnNewList[index]
                                                    ['title']!,
                                                style: CraftStyles
                                                    .tsWhiteNeutral300W500,
                                              ),
                                              TextSpan(
                                                text: provider
                                                        .learnNewList[index]
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
               Text(
                textAlign: TextAlign.center,
              CraftStrings.strCourseCertificateText,
                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
               Center(
                 child: SvgPicture.asset(
                        CraftImagePath.courseCertificate,
                     
                       
                      ),
               ),
    ],),
  );
}
  Widget browseOtherCourse() {
    return Consumer<CourseDetailProvider>(
      builder: (context, provider, child) {
        return 
         BrowseOtherCourse(imagePaths:provider.imagePaths ,title:  "Other courses you might enjoy",onPressed: ()
         {

         },);
        
      },
    );
  }

   Widget meetInstructorWidget() {
  return Consumer<CourseDetailProvider>(
    builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          
                        decoration: BoxDecoration(
                          color: CraftColors.neutralBlue800,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12,top: 12),
                      child: Text(
                        "Meet Instructor",
                        style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                      ),
                    ),
                   
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical, // Allow vertical scrolling
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row for Checkbox, Image, and Text
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              GestureDetector(
                                  onTap: () {
                                    // Toggle the expanded state via the provider
                                   
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    width:  SizeConfig.blockSizeHorizontal * 29, // Original width when collapsed
                                    height: SizeConfig.blockSizeVertical * 18, // Original height when collapsed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: AssetImage(CraftImagePath.image1),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Row with "New!" label and Expand Icon
                                          Padding(
                                                                                     padding: const EdgeInsets.only(left: 2),
                                                                                     child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                      
                                                                                      Text(
                                                                                        "Salim Khan",
                                                                                        style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                                                                      ),
                                                                                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                                                                      // Subtext (short description)
                                                                                      Text(
                                                                                        "An influential storyteller and screenplay writer, transformed Indian cinema with iconic films like Zanjeer and Deewar, bringing authenticity to the 'Indian hero' archetype through compelling characters and a focus on human relationships. His legacy endures in stories shaped by collaboration, cultural insight, and a passion for cinematic craft.",
                                                                                        maxLines: 4,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
                                                                                      ),
                                                                                       SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                                                                 SizedBox(
                width: SizeConfig.blockSizeHorizontal * 35,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(SizeConfig.blockSizeHorizontal * 35,
                        SizeConfig.blockSizeVertical * 4),
                    backgroundColor: CraftColors.neutralBlue750,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                   "Salim Khan Courses",
                    style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                  ),
                ),
              ),
                                                                                    
                                                                                  
                                                                                     ],),
                                                                                   ),
                                       
                                        ],
                                      ),
                                    ),
                                  ),
                                
                              ],
                            ),
                           
                          ],
                        ),
                      )
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
    Widget bannerImages(
      {String? tag,
      String? title,
      String? subTitle,
      TextStyle? textStyle,
      Color? textBackground,
      String? image}) {
    return
      Consumer<CourseDetailProvider>(builder: (context, provider, _) {
                return
    
     Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical * 40,
          child: Container(
            margin: EdgeInsets.all(8),
            width: SizeConfig.safeBlockHorizontal * 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                    image: AssetImage(
                      image!,
        
                      // Get image from the provider list
                    ),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Text(
                    title!,
                    style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Text(
                    subTitle!,
                    style: CraftStyles.tsWhiteNeutral200W500,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 25,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(SizeConfig.blockSizeHorizontal * 25,
                                SizeConfig.blockSizeVertical * 2),
                            backgroundColor: CraftColors.primaryBlue550,
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            CraftStrings.strBuyNow,
                            style: CraftStyles.tsWhiteNeutral50W60016,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 35,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(SizeConfig.blockSizeVertical * 35,
                                SizeConfig.blockSizeVertical * 2),
                            backgroundColor:
                                CraftColors.transparent.withOpacity(0.1),
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: CraftColors
                                    .neutralBlue750, // Set the border color
                                width: 2, // Set the border width
                              ),
                            ),
                            elevation: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                CraftImagePath.play,
                                height: 12.0,
                                width: 12.0,
                              ),
                              SizedBox(
                                  width:
                                      8), // Add some spacing between icon and text
                              Text(
                                CraftStrings.strWatchTrailer,
                                style: CraftStyles.tsWhiteNeutral50W60016
                                    .copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
       Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the images horizontally
            crossAxisAlignment: CrossAxisAlignment.center, // Centers the images vertically
            children: <Widget>[
              imageWithTextColumn(CraftImagePath.sampleVideo,CraftStrings.strSampleVideo),
             imageWithTextColumn(CraftImagePath.bts,CraftStrings.strBts),
             imageWithTextColumn(CraftImagePath.share,CraftStrings.strShare),
             
            ],
          ),
       
         
                 Divider(thickness: 0.2,),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                          CraftStrings.strAboutCourse,
                          style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
                        ),
                            Text(
                             "Unlock a world of exclusive filmmaking courses taught by renowned industry experts, all from the convenience of your phone. Whether you're at home or on the go, continue refining your skills and deepening your knowledge at your own pace. Gain access to behind-the-scenes insights and expert techniques that bring real-world learning to your fingertips. Stay updated with the latest lessons, connect with a community of fellow creatives, and download the app now on the App Store and Play Store to begin your path to success.",
                              style:  CraftStyles.tsWhiteNeutral200W500, // Customize your text style
                              maxLines: provider.isExpanded ? null : 3, // Limit text to 3 lines if not expanded
                              overflow: provider.isExpanded ? TextOverflow.visible : TextOverflow.ellipsis, // Show ellipsis when collapsed
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.toggleExpansion(); // Toggle the expansion state via provider
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  provider.isExpanded ? "Show Less" : "Show More",
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                  ),
                   buyNowWidget(),
                 
      ],
    );
      });
  }
  
 Widget buyNowWidget() {
    return Consumer<CourseDetailProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: CraftColors.neutralBlue800,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: CraftColors.neutralBlue800,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: provider.chipPlanData.map((chip) {
                          return FilterChip(
                            label: SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 30,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    chip['label']!,
                                    style: TextStyle(
                                      color: provider.selectedChip == chip['label']
                                          ? CraftColors.secondary550
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            selected: provider.selectedChip == chip['label'],
                            onSelected: (isSelected) {
                              provider.onSingleChipSelected(chip['label']);
                            },
                            selectedColor: CraftColors.neutralBlue800,
                            backgroundColor: CraftColors.neutralBlue800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              side: BorderSide(
                                color: provider.selectedChip == chip['label']
                                    ? CraftColors.secondary550
                                    : CraftColors.transparent,
                                width: provider.selectedChip == chip['label'] ? 1.0 : 0.1,
                              ),
                            ),
                            elevation: 0,
                            showCheckmark: false,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        "₹ 999/-",
                        style: CraftStyles.tswhiteW600.copyWith(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                      Expanded(
                        child: Text(
                          "₹ 799/-",
                          style: CraftStyles.tswhiteW600.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        "30 % off",
                        style: CraftStyles.tssecondary550W700.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 90,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(SizeConfig.blockSizeHorizontal * 25, SizeConfig.blockSizeVertical * 5),
                            backgroundColor: CraftColors.primaryBlue550,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            CraftStrings.strBuyNow,
                            style: CraftStyles.tsWhiteNeutral50W60016,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    Center(
                      child: SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 90,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(SizeConfig.blockSizeHorizontal * 25, SizeConfig.blockSizeVertical * 5),
                            backgroundColor: CraftColors.transparent,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: CraftColors.neutralBlue750,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            CraftStrings.strSaveToLater,
                            style: CraftStyles.tsWhiteNeutral50W60016,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: IconButton(
                        icon: Icon(
                          provider.isBuyNowExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: CraftColors.white,
                        ),
                        onPressed: () {
                          provider.toggleBuyNowExpansion();
                        },
                      ),
                    ),
                    if (provider.isBuyNowExpanded)
                      buyNowCourseDetailWidget(), // This is the widget you want to expand/collapse
                 
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: CraftColors.black18,
      body: ChangeNotifierProvider(
        create: (_) => CourseDetailProvider(),
        child: ListView(
          shrinkWrap: true,
          children: [
    bannerImages(
                tag: "New !",
                title:
                    "The great screenplay makes everybody step up to the bar and deliver.",
                subTitle: "Learn from the living legend Salim khan",
                textStyle: CraftStyles.tssecondary800W500,
                textBackground: CraftColors.secondary100,
                image: CraftImagePath.bannerImage),
                moduleWidget(),meetInstructorWidget(),
                browseOtherCourse(),
             
               
              
          ],
        ),
      ),
    );
  }
}
