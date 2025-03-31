import 'package:craft_school/dto/TrendingClassResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/AllCourses.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:craft_school/utils/craft_colors.dart';

class BrowseTrendingCourse extends StatelessWidget {
  final List<Datum> imagePaths;
  final String title;
  final Function onPressed; // Pass action for button
   final Function(int index)? onSaveButtonOnTap; // Callback that takes index as a parameter
  final Function(int index)? onunSaveButtonOnTap;

  const BrowseTrendingCourse({
    required this.imagePaths,
    required this.title,
    required this.onPressed,
     this.onSaveButtonOnTap, this.onunSaveButtonOnTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
              ),
         
         
   SizedBox(
     width: SizeConfig.blockSizeHorizontal * 38,
     child: ElevatedButton(
       onPressed: () {
           Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                                  AllCourses.route,
                                )
                                .then((value) {});
       }, // Trigger the action when pressed
       style: ElevatedButton.styleFrom(
         minimumSize: Size(SizeConfig.blockSizeVertical * 38, SizeConfig.blockSizeVertical * 4),
         backgroundColor: CraftColors.neutralBlue800,
         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         elevation: 5,
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(
             CraftStrings.strBrowseCourse,
             style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
           ),
           SizedBox(width: 8),
           SvgPicture.asset(
             CraftImagePath.arrowRight,
             height: 14.0,
             width: 14.0,
           ),
         ],
       ),
     ),
   )
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 35,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              itemCount: imagePaths.length, // Use the length of the list
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: ()
                      {
                         Navigator.of(routeGlobalKey.currentContext!)
                          .pushNamed(
                            Coursedetailscreen.route,arguments:  imagePaths[index].slug
                          )
                          .then((value) {});  
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            width: SizeConfig.safeBlockHorizontal * 40,
                            height: SizeConfig.blockSizeVertical * 23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(imagePaths[index].courseBannerMobile!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              ( imagePaths[index].tagName==""||imagePaths[index].tagName==null)?Container():   Container(
                                    decoration: BoxDecoration(
                                      color: CraftColors.secondary100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                       imagePaths[index].tagName!,
                                        style: CraftStyles.tssecondary800W500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: SizeConfig.safeBlockHorizontal * 40,
                                child: Text(
                                 imagePaths[index].shortDescription!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 0.5,
                              ),
                              Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 12.0,
                                    backgroundImage: NetworkImage(imagePaths[index].masterProfilePhoto!),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 2,
                                  ),
                                  SizedBox(
                                     width: SizeConfig.safeBlockHorizontal * 25,
                                    child: Text(
                                       overflow: TextOverflow.ellipsis,
                                     imagePaths[index].masterName!,
                                     maxLines:2,
                                      style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                      GlobalLists.authtoken!=""?      Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  if (imagePaths[index].savedFlag!) {
                                  
                           
                       if (onSaveButtonOnTap != null) {
               onunSaveButtonOnTap!(index); // Pass the index to the callback
                       }
                                   
                                  } else {
                                     if (onSaveButtonOnTap != null) {
               onSaveButtonOnTap!(index); // Pass the index to the callback
             }
                                  
                                  }
                                  // provider.notifyListeners(); // Ensure UI updates
                                },
                                child: imagePaths[index].savedFlag!
                                    ? SvgPicture.asset(
                                        CraftImagePath.save,
                                        width: 22,
                                        height: 22,
                                      )
                                    : SvgPicture.asset(
                                        CraftImagePath.saved,
                                        width: 22,
                                        height: 22,
                                      ),
                              ),
                            ):Container(),
                  ],
                );
              },
            ),
          ),
         
        ],
      ),
    );
  }
}
