
import 'package:craft_school/screens/CreatePostScreen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/VideoPlayerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostWidget extends StatelessWidget {
  final dynamic post;
  final int index;
  final Function(int index)? onSaveButtonOnTap;
  final Function(int index)? onLikeTap;
  final Function(int index)? onDeletePostTap;
   final Function(int index)? onReportPostTap;
    final Function(int index)? onCommentPostTap;
  final TextEditingController reportController;

  PostWidget({super.key, 
    required this.post,
    this.onSaveButtonOnTap,
    required this.index,
    this.onLikeTap, this.onDeletePostTap, this.onReportPostTap, required this.reportController, this.onCommentPostTap,
  });

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
                  backgroundImage: 
                  post.userProfilePic.isNotEmpty
                      ? NetworkImage(post.userProfilePic)
                      :
                       AssetImage(CraftImagePath.whiteCamera) as ImageProvider,
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.customerName.toString(),
                      style: CraftStyles.tsWhiteNeutral50W60016,
                    ),
                    Row(
                      children: [
                        Text(
                     " ${post.timeAgo}, ",
                      style: CraftStyles.tsWhiteNeutral300W400,
                    ),
                        Text(
                          post.createdAt,
                          style: CraftStyles.tsWhiteNeutral300W400,
                        ),
                      ],
                    ),
                     
                  ],
                ),
                Spacer(),
              IconButton(
                  icon: Icon(Icons.more_horiz, color: Colors.white),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            GlobalLists.customerID.toString()==post.customerId.toString()?Container():  ListTile(
                                leading: Icon(Icons.report, color: Colors.red),
                                title: Text("Report", style: TextStyle(color: Colors.red)),
                                onTap: () {
                                                                      Navigator.pop(context); // Close current sheet
                                        _showReportBottomSheet(context, reportController,onReportPostTap);

                                },
                              ),
                            GlobalLists.customerID.toString()==post.customerId.toString()?    ListTile(
                                leading: Icon(Icons.delete, color: Colors.black),
                                title: Text("Delete"),
                                onTap: () {
                                    
                                   ShowDialogs.showConfirmDialogdelete(context, "Delete",
                        "Are You Sure You Want To Remove Post ?", () {
                       if (onDeletePostTap != null) {
                         Navigator.pop(context);
                          onDeletePostTap!(index); // Pass the index to the callback
                        }
                        Navigator.pop(context);
                    });
                  
                       
                      },
                              ):Container(),
                                GlobalLists.customerID.toString()==post.customerId.toString()?    ListTile(
                                leading: Icon(Icons.edit, color: Colors.black),
                                title: Text("Edit"),
                                onTap: () {
                                  Navigator.of(context)
                              .pushNamed(CreatePostScreen.route,arguments: {
    'postcomment': post.post,
    'postId': post.id.toString(),
    'medias':post.medias,
    'iseditView': true,
  },);
                  
                       
                      },
                              ):Container(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          // Staggered grid of images
          post.medias.isNotEmpty
              ? 
              //grid view
            Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MasonryGridView.builder(
          physics: NeverScrollableScrollPhysics(), // Disables grid scrolling
          shrinkWrap: true, // Makes grid fit content
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns like your Figma design
          ),
          itemCount: post.medias.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: 
                 isVideo(post.medias[index].mediaUrl,)
          ? 
          VideoPlayerWidget(videoUrl:  post.medias[index].mediaUrl,)
          :
                Image.network(
                 post.medias[index].mediaUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    )

          //     Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          //           child: StaggeredGridView.countBuilder(
          //             crossAxisCount: 4, // Number of columns in the grid
          //             itemCount: post.medias.length,
          //             shrinkWrap: true, // Ensures the grid takes up only as much space as needed
          //             physics: NeverScrollableScrollPhysics(), // Disables scroll behavior for the grid itself
          //             itemBuilder: (context, index) {
          //               return Padding(
          //                 padding: const EdgeInsets.all(1.0),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(8),
          //                   child:
          //                   isVideo(post.medias[index].mediaUrl,)
          // ? VideoPlayerWidget(videoUrl:  post.medias[index].mediaUrl,)
          // : Image.network(
          //   post.medias[index].mediaUrl,
          //     width: double.infinity,
          //     height: SizeConfig.safeBlockVertical * 20,
          //     fit: BoxFit.cover,
          //   ),
          //                   // Image.network(
          //                   //  post.medias[index].mediaUrl,
          //                   //   width: double.infinity,
          //                   //   height: SizeConfig.safeBlockVertical * 20, // Height of the image
          //                   //   fit: BoxFit.cover,
          //                   // ),
          //                 ),
          //               );
          //             },
          //             staggeredTileBuilder: (index) {
          //               if (index % 2 == 0) {
          //                 return StaggeredTile.count(2, 1); // 2 columns wide, 1 row tall
          //               } else {
          //                 return StaggeredTile.count(2, 2); // 2 columns wide, 2 rows tall
          //               }
          //             },
          //             mainAxisSpacing: 8.0, // Space between rows
          //             crossAxisSpacing: 8.0, // Space between columns
          //           ),
          //         ),
          //       )
              : Container(),

          // Post caption, likes, and comments
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.post, style: CraftStyles.tsWhiteNeutral300W500),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (onLikeTap != null) {
                              onLikeTap!(index); // Pass the index to the callback
                            }
                          },
                          child: post.hasLiked
                              ? Icon(Icons.favorite, size: 20, color: Colors.red)
                              : Icon(Icons.favorite_border, size: 20, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Text('${post.likeCount}', style: CraftStyles.tsWhiteNeutral300W400),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap:  () {
                            if (onCommentPostTap != null) {
                              onCommentPostTap!(index); // Pass the index to the callback
                        
                            }
                          },
                          child: SvgPicture.asset(CraftImagePath.commentlogo)),
                        SizedBox(width: 8),
                        Text('${post.commentCount}', style: CraftStyles.tsWhiteNeutral300W400),
                        SizedBox(width: 15),
                        SvgPicture.asset(CraftImagePath.publishlogo),
                        SizedBox(width: 8),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (onSaveButtonOnTap != null) {
                          onSaveButtonOnTap!(index); // Pass the index to the callback
                        }
                      },
                      child: SvgPicture.asset(
                        post.hasSaved ? CraftImagePath.save : CraftImagePath.saved,
                        width: 22,
                        height: 22,
                        
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
bool isVideo(String url) {
  return url.toLowerCase().endsWith('.mp4');
}

   // Function to show a second bottom sheet for reporting
  void _showReportBottomSheet(BuildContext context, TextEditingController controller, final Function(int index)? onReportPostTap
) {
    showModalBottomSheet(
     
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Report Post", style: CraftStyles.tsWhiteNeutral50W60016.copyWith(color: CraftColors.neutral900)),
              SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Enter your reason',
                  hintText: 'Why are you reporting this post?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(color: CraftColors.neutral900),
                  labelStyle: TextStyle(color: CraftColors.neutral900),
                  
                ),
                
                style: TextStyle(color: CraftColors.neutral900),
                maxLines: 3,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                        if (onReportPostTap != null) {
                          onReportPostTap(index); // Pass the index to the callback
                        }
                      },
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: CraftColors.neutral900,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Submit Report",style: CraftStyles.tsWhiteNeutral50W60016,),
              ),
            ],
          ),
        );
      },
    );
  }

   // Function to show the comments bottom sheet
 
}
