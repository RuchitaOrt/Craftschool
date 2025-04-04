import 'package:craft_school/dto/AllCoursesResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageGridViewCourses extends StatelessWidget {
  final List<Datum> imagePaths; // List of image paths (could be URLs or asset paths)
  final Function(int index)? onSaveButtonOnTap; // Callback that takes index as a parameter
  final Function(int index)? onunSaveButtonOnTap;
  const ImageGridViewCourses({super.key, required this.imagePaths, this.onSaveButtonOnTap, this.onunSaveButtonOnTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 2.0, // Horizontal space between images
        mainAxisSpacing: 2.0, // Vertical space between images
        childAspectRatio: 0.74, // Aspect ratio for square items
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(routeGlobalKey.currentContext!)
                .pushNamed(
              Coursedetailscreen.route,
              arguments: imagePaths[index].slug,
            )
                .then((value) {});
          },
          child:
          Stack(
  children: [
    Column(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          width: SizeConfig.safeBlockHorizontal * 45,
          height: SizeConfig.blockSizeVertical * 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(imagePaths[index].courseBannerMobile),
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
                                      color: CraftStyles.getTagBackgroundColor(imagePaths[index].tagName),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                       imagePaths[index].tagName!,
                                        style: CraftStyles.getTagTextStyle(imagePaths[index].tagName)
                                      
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
                imagePaths[index].name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
            Text(
              imagePaths[index].instructor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 10),
            ),
          ],
        ),
      ],
    ),

    /// Save Button (only if authtoken available)
    if (GlobalLists.authtoken != "")
      Positioned(
        top: 12,
        right: 12,
        child: GestureDetector(
          onTap: () {
            if (imagePaths[index].savedFlag) {
              if (onunSaveButtonOnTap != null) {
                onunSaveButtonOnTap!(index);
              }
            } else {
              if (onSaveButtonOnTap != null) {
                onSaveButtonOnTap!(index);
              }
            }
          },
          child: imagePaths[index].savedFlag
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
      ),
  ],
)

          //  Stack(
          //   children: [
          //     Column(
          //       children: [
          //         Container(
          //           margin: EdgeInsets.all(8),
          //           width: SizeConfig.safeBlockHorizontal * 45,
          //           height: SizeConfig.blockSizeVertical * 22,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(16),
          //             image: DecorationImage(
          //               image: NetworkImage(
          //                 imagePaths[index].courseBannerMobile,
          //               ),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //         Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             SizedBox(
          //               width: SizeConfig.safeBlockHorizontal * 40,
          //               child: Text(
          //                 imagePaths[index].name,
          //                 overflow: TextOverflow.ellipsis,
          //                 maxLines: 2,
          //                 style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
          //               ),
          //             ),
          //             SizedBox(
          //               height: SizeConfig.blockSizeVertical * 0.5,
          //             ),
          //             Text(
          //               imagePaths[index].instructor,
          //               maxLines: 1,
          //               overflow: TextOverflow.ellipsis,
          //               style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 10),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //  GlobalLists.authtoken!=""?   Align(
          //    alignment: Alignment.topRight,
          //    child:  Positioned(
          //                top: 90,
          //                right: 30,
          //                child: GestureDetector(
          //  onTap: () {
          //    //check here
          //    print("all course");
          //     if (imagePaths[index].savedFlag) {
                             
          //              if (onSaveButtonOnTap != null) {
          //      onunSaveButtonOnTap!(index); // Pass the index to the callback
          //    }
                              
                              
          //                    } else {
          //                      if (onSaveButtonOnTap != null) {
          //      onSaveButtonOnTap!(index); // Pass the index to the callback
          //    }
          //                    }
            
          //  },
          //  child: imagePaths[index].savedFlag
          //      ? SvgPicture.asset(
          //          CraftImagePath.save,
          //          width: 22,
          //          height: 22,
          //        )
          //      : SvgPicture.asset(
          //          CraftImagePath.saved,
          //          width: 22,
          //          height: 22,
          //        ),
          //                ),
          //  ),
          //  ):Container(),
          //   ],
          // ),
        );
      },
    );
  }
}

