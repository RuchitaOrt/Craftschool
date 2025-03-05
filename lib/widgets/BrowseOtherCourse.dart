import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:craft_school/utils/craft_colors.dart';

class BrowseOtherCourse extends StatelessWidget {
  final List<String> imagePaths;
  final String title;
  final Function onPressed; // Pass action for button

  const BrowseOtherCourse({
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
            height: SizeConfig.blockSizeVertical * 35,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              itemCount: imagePaths.length, // Use the length of the list
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      width: SizeConfig.safeBlockHorizontal * 40,
                      height: SizeConfig.blockSizeVertical * 23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(imagePaths[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CraftColors.secondary100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "New !",
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
                            "Odit laborum sed optio sit dolore",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 0.5,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12.0,
                              backgroundImage: AssetImage(CraftImagePath.image1),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 2,
                            ),
                            Text(
                              "Aashif Shaikh",
                              style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Center(
            child: SizedBox(
              width: SizeConfig.blockSizeHorizontal * 45,
              child: ElevatedButton(
                onPressed: () => onPressed(), // Trigger the action when pressed
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(SizeConfig.blockSizeVertical * 43, SizeConfig.blockSizeVertical * 5),
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
                      style: CraftStyles.tsWhiteNeutral50W60016,
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      CraftImagePath.arrowRight,
                      height: 24.0,
                      width: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
