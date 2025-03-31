import 'package:craft_school/dto/CommentListResponse.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
    final Function(int index)? onLikeTap;
     final int index;

  CommentWidget({required this.comment, this.onLikeTap, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage:comment.userProfilePic!=""? NetworkImage(comment.userProfilePic!):AssetImage(CraftImagePath.acting),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(comment.customerName!, style: CraftStyles.tsWhiteNeutral50W60016),
                     Row(

                  children: [
                    GestureDetector(
                          onTap: () {
                            if (onLikeTap != null) {
                              onLikeTap!(index); // Pass the index to the callback
                            }
                          },
                          child: comment.hasCommentLiked!
                              ? Icon(Icons.favorite, size: 20, color: Colors.red)
                              : Icon(Icons.favorite_border, size: 20, color: Colors.white),
                        ),
                    SizedBox(width: 8),
                    Text(comment.commentLikeCount!, style: CraftStyles.tsWhiteNeutral300W400),
                  ],
                ),
                    
                     
                  ],
                ),
                SizedBox(height: 5),
                Text(comment.comment!, style: CraftStyles.tsWhiteNeutral300W400.copyWith(fontSize: 12)),
                SizedBox(height: 5),
               Text(comment.timeAgo!, style: CraftStyles.tsWhiteNeutral300W400.copyWith(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
