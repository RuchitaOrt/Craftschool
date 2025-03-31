import 'package:craft_school/dto/TrendingMasterResponse.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:craft_school/utils/craft_colors.dart';

class TrendingSkill extends StatelessWidget {
  final List<Datum> imagePaths;
  final String title;
  final Function onPressed; // Pass action for button

  const TrendingSkill({
    required this.imagePaths,
    required this.title,
    required this.onPressed,
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
          Text(
            title,
            style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 8,
           
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              itemCount: imagePaths.length, // Use the length of the list
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    
            width: SizeConfig.blockSizeHorizontal*47,
                      decoration: BoxDecoration(
                            color: CraftColors.neutralBlue800,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16.0,
                            backgroundImage: NetworkImage(imagePaths[index].photo),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          SizedBox(
                             width: SizeConfig.blockSizeHorizontal*32,
                            child: Text(
                              imagePaths[index].description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical*2,),
          // Center(
          //   child: SizedBox(
          //     width: SizeConfig.blockSizeHorizontal * 45,
          //     child: ElevatedButton(
          //       onPressed: () => onPressed(), // Trigger the action when pressed
          //       style: ElevatedButton.styleFrom(
          //         minimumSize: Size(SizeConfig.blockSizeVertical * 43, SizeConfig.blockSizeVertical * 5),
          //         backgroundColor: CraftColors.neutralBlue800,
          //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //         elevation: 5,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             CraftStrings.strBrowseCourse,
          //             style: CraftStyles.tsWhiteNeutral50W60016,
          //           ),
          //           SizedBox(width: 8),
          //           SvgPicture.asset(
          //             CraftImagePath.arrowRight,
          //             height: 24.0,
          //             width: 24.0,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
