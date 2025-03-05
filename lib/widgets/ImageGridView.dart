import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ImageGridView extends StatelessWidget {
  final List<String> imagePaths; // List of image paths (could be URLs or asset paths)

  const ImageGridView({required this.imagePaths});

  @override
  Widget build(BuildContext context) {
   
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,  // 2 items per row
        crossAxisSpacing: 2.0, // Horizontal space between images
        mainAxisSpacing: 2.0,  // Vertical space between images
        childAspectRatio: 0.74 // Aspect ratio for square items
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          width: SizeConfig.safeBlockHorizontal * 45,
                          height: SizeConfig.blockSizeVertical * 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(
                                imagePaths[index],
                              ),
                              fit: BoxFit.cover,
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
                                "Odit laborum sed optio sit dolore ",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: CraftStyles.tsWhiteNeutral50W60016
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 0.5,
                            ),
                            Text(
                              "Aashif Shaikh",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CraftStyles.tsWhiteNeutral300W500
                                  .copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    );
      },
    );
  }
}
