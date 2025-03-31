import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CommunityProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/widgets/CommentWidget.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/PostWidget.dart';
import 'package:craft_school/screens/CreatePostScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SavedPostScreen extends StatefulWidget {
  static const String route = "/savedpostscreen";

  const SavedPostScreen({super.key});

  @override
  _SavedPostScreenState createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {

  @override
  void initState() {
    super.initState();
   print("getsavedCommunityAPI");
    WidgetsBinding.instance.addPostFrameCallback((_) {
final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription
            .getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }
      final provider = Provider.of<CommunityProvider>(context, listen: false);
       print("getsavedCommunityAPI1");
   
          print("getsavedCommunityAPI2");
        provider.getsavedCommunityAPI();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(
                  isContainerVisible: provider.isContainerVisible,
                  isCategoryVisible: provider.isCategoryVisible,
                  onMenuPressed: () {
                    provider
                        .toggleSlidingContainer(); // Trigger toggle when menu is pressed
                  },
                  onCategoriesPressed: () {
                    provider.toggleSlidingCategory();
                  },
                ),
              ),
              backgroundColor: CraftColors.black18,
              body: Consumer<CommunityProvider>(
                  builder: (context, communityprovider, _) {
                return Stack(
                  children: [
                    // Main content (ListView and other widgets)
                    SingleChildScrollView(
                     
                      physics: ScrollPhysics(),
                      child: ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Saved Post",
                                      style: CraftStyles.tsWhiteNeutral50W700,
                                    ),
                                  
                                   
                                  ],
                                ),
                                
                              ],
                            ),
                          ),

                          // List of posts
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: communityprovider.savedPostList.length,
                            itemBuilder: (context, index) {
                              return PostWidget(
                                post: communityprovider.savedPostList[index],
                                index: index,
                                onCommentPostTap: (index) {
                                  communityprovider.savedPostList.clear();
                                  communityprovider.commentsCommunityAPI(
                                      communityprovider.savedPostList[index].id
                                          .toString());
                                  _showCommentBottomSheet(communityprovider
                                      .savedPostList[index].id
                                      .toString());
                                },
                                onReportPostTap: (index) {
                                  {
                                    // Handle report submission logic
                                    String reason =
                                        communityprovider.reportController.text;
                                    if (reason.isNotEmpty) {
                                      // Call the report API or handle reporting here
                                      print("Reporting Post: $reason");
                                      Navigator.pop(
                                          context); // Close the report sheet after submission
                                      communityprovider.reportCommunityAPI(
                                          communityprovider
                                              .savedPostList[index].id
                                              .toString(),
                                          reason);
                                    } else {
                                      // Show some error if reason is empty
                                      print(
                                          "Please provide a reason for reporting.");
                                    }
                                  }
                                },
                                onDeletePostTap: (index) {
                                  communityprovider.deleteCommunityAPI(
                                      communityprovider.savedPostList[index].id
                                          .toString());
                                },
                                onLikeTap: (index) {
                                  print("like");
                                  final post =
                                      communityprovider.savedPostList[index];
                                  int postcount = int.parse(post.likeCount);
                                  // Check if the post is already liked
                                  if (post.hasLiked) {
                                    // If the post is liked, dislike the post
                                    post.hasLiked = false;
                                    postcount--; // Decrease the like count
                                    if (postcount >= 0) {
                                      post.likeCount = postcount.toString();
                                    }

                                    communityprovider.dislikeCommunityAPI(
                                        post.id.toString()); // Call dislike API
                                  } else {
                                    // If the post is not liked, like the post
                                    post.hasLiked = true;
                                    postcount++; // Increase the like count
                                    post.likeCount = postcount.toString();
                                    communityprovider.likeCommunityAPI(
                                        post.id.toString()); // Call like API
                                  }

                                  // Call setState to update the UI immediately
                                  setState(() {});
                                },
                                onSaveButtonOnTap: (index) {
                                  
                                },
                                reportController:
                                    communityprovider.reportController,
                              );
                            },
                          ),
                          
                        ],
                      ),
                    ),

                   

                    // Floating action button for creating post
                    Positioned(
                      bottom:
                          80, // Position the create post button slightly above the row
                      right: 16,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(CreatePostScreen.route,arguments: {
    'postcomment': '',
    'postId': '',
    'medias': [],
    'iseditView': false,
  },);
                        },
                        backgroundColor: CraftColors.neutralBlue750,
                        child: Icon(Icons.add, color: CraftColors.neutral100),
                      ),
                    ),

                    if (provider.isContainerVisible)
                      SlidingMenu(isVisible: provider.isContainerVisible),
                    if (provider.isCategoryVisible)
                      SlidingCategory(
                        isExpanded: provider.isCategoryVisible,
                        onToggleExpansion: provider.toggleSlidingCategory,
                      ),
                  ],
                );
              }));
        }));
  }

  void _showCommentBottomSheet(String postId) {
    showModalBottomSheet(
      backgroundColor: CraftColors.neutral900,
      context: routeGlobalKey.currentContext!,
      builder: (context) {
        return Consumer<CommunityProvider>(
            builder: (context, communityprovider, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Comments", style: CraftStyles.tsWhiteNeutral50W60016),
                // Comments list
                Expanded(
                  child: ListView.builder(
                    itemCount: communityprovider.commentList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: ()
                        {

                            ShowDialogs.showConfirmDialogdelete(context, "Delete",
                        "Are You Sure You Want To Remove Comment ?", () {
                          Navigator.pop(routeGlobalKey.currentContext!);
                         communityprovider.deleteCommentCommunityAPI(communityprovider.commentList[index].commentId.toString());

                        

                        // Optionally clear the text field after adding the comment
                        communityprovider.commentController.clear();

                        // Increase the comment count locally for the post (without waiting for API)
                        final post = communityprovider.savedPostList
                            .firstWhere((post) => post.id.toString() == postId);
                            if(int.parse(post.commentCount)>0){
 post.commentCount =
                            (int.parse(post.commentCount) - 1).toString();
                            }
                       

                        // Update the UI
                        setState(() {});
                                    Navigator.pop(routeGlobalKey.currentContext!);               
                    });
                         
                        },
                        child: CommentWidget(
                            comment: communityprovider.commentList[index],
                              onLikeTap: (index) {
                                    print("like");
                                    final post =
                                        communityprovider.commentList[index];
                                    int postcount = int.parse(post.commentLikeCount!);
                                    // Check if the post is already liked
                                    if (post.hasCommentLiked!) {
                                      // If the post is liked, dislike the post
                                      post.hasCommentLiked = false;
                                      postcount--; // Decrease the like count
                                     
                        
                                      communityprovider.unlikeCommentCommunityAPI(
                                          post.postId.toString()); // Call dislike API
                                    } else {
                                      // If the post is not liked, like the post
                                      post.hasCommentLiked = true;
                                      postcount++; // Increase the like count
                                      post.commentLikeCount = postcount.toString();
                                      communityprovider.likeCommentCommunityAPI(
                                          post.postId.toString()); // Call like API
                                    }
                        
                                    // Call setState to update the UI immediately
                                    setState(() {});
                                  },index: index,),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                // Add comment field
                TextField(
                  controller: communityprovider.commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: CraftColors.neutral100),
                    ),
                    hintStyle: TextStyle(color: CraftColors.neutral100),
                    labelStyle: TextStyle(color: CraftColors.neutral100),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print("object");
                        // communityprovider.addCommentCommunityAPI(postId, communityprovider.commentController.text);

                        communityprovider.addCommentCommunityAPI(
                            postId, communityprovider.commentController.text);

                        // Optionally clear the text field after adding the comment
                        communityprovider.commentController.clear();

                        // Increase the comment count locally for the post (without waiting for API)
                        final post = communityprovider.savedPostList
                            .firstWhere((post) => post.id.toString() == postId);
                        post.commentCount =
                            (int.parse(post.commentCount) + 1).toString();

                        // Update the UI
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          CraftImagePath.publishlogo,
                          width: 10,
                          height: 10,
                          color: CraftColors.neutral100,
                        ),
                      ),
                    ),
                  ),
                  style: TextStyle(color: CraftColors.neutral100),
                ),

                SizedBox(height: 15),
              ],
            ),
          );
        });
      },
    );
  }
}
