import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CraftColors.neutralBlue800,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info and post image
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(post.imageUrl),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: CraftStyles.tsWhiteNeutral50W60016,
                    ),
                    Text(
                      "5 mins • Dec 24, 2023",
                      style: CraftStyles.tsWhiteNeutral300W400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                post.imageUrl,
                width: double.infinity,
                height: SizeConfig.safeBlockVertical*20,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Post caption, likes and comments
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.caption, style: CraftStyles.tsWhiteNeutral300W500),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                Row(
                  children: [
                    Icon(Icons.favorite_border, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text('${post.likes} Likes',
                        style: CraftStyles.tsWhiteNeutral300W400),
                    SizedBox(width: 15),
                    Icon(Icons.comment_rounded, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text('${post.comments} Comments',
                        style: CraftStyles.tsWhiteNeutral300W400),
                    SizedBox(width: 15),
                    Icon(Icons.share, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Share', style: CraftStyles.tsWhiteNeutral300W400),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
