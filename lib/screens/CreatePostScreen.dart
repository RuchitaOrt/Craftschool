import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreatePostScreen extends StatefulWidget {
  static const String route = '/createpostscreen';

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _captionController = TextEditingController();
  String? _imageUrl; // You can implement image picker logic later.

  void _createPost() {
    // Here, handle post creation logic (saving to a database, etc.)
    // For now, we'll just print the caption to console.
    print("New Post Created");
    print("Caption: ${_captionController.text}");
    // Navigate back to the PostScreen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: false,
                onMenuPressed: () {
                  // provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                },
                   onCategoriesPressed: () {  }, isContainerVisible: false,
              ),
            ),
      backgroundColor: CraftColors.black18,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image picker (you can use an image picker package later)

            Text(
              "Create Post",
              style: CraftStyles.tsWhiteNeutral50W70016,
            ),
             SizedBox(height: SizeConfig.blockSizeVertical * 2),
            TextField(
              
              controller: _captionController,
              style: CraftStyles.tsWhiteNeutral300W400,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "What’s up, Vineet?",
                filled: true,
                
                fillColor: CraftColors.neutralBlue750,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 4),
            // Submit button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          CraftImagePath.imagelogo,
                          height: 16.0,
                          width: 16.0,
                        ),
                        SizedBox(
                            width: 8), // Add some spacing between icon and text
                        Text(
                          CraftStrings.strimages,
                          style: CraftStyles.tsWhiteNeutral50W60016
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          CraftImagePath.videologo,
                          height: 16.0,
                          width: 16.0,
                        ),
                        SizedBox(
                            width: 8), // Add some spacing between icon and text
                        Text(
                          CraftStrings.strVideos,
                          style: CraftStyles.tsWhiteNeutral50W60016
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                ],),

                SizedBox(
                  width: SizeConfig.blockSizeVertical * 14,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(SizeConfig.blockSizeVertical * 0.6,
                          SizeConfig.blockSizeVertical * 5),
                      backgroundColor: CraftColors.primaryBlue550,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          CraftImagePath.publishlogo,
                          height: 16.0,
                          width: 16.0,
                        ),
                        SizedBox(
                            width: 8), // Add some spacing between icon and text
                        Text(
                          CraftStrings.strPublish,
                          style: CraftStyles.tsWhiteNeutral50W60016
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
