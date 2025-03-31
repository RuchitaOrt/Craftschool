import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CommunityProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/SavedPostScreen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/widgets/CommentWidget.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/PostWidget.dart';
import 'package:craft_school/screens/CreatePostScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  static const String route = "/postscreen";

  const PostScreen({super.key});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _section1Key = GlobalKey();
  final GlobalKey _section2Key = GlobalKey();
  final GlobalKey _section3Key = GlobalKey();

  int _currentSection = 0;
  bool _showArrowButton = false; // Variable to control arrow button visibility

  @override
  void initState() {
    super.initState();

    
    _scrollController.addListener(() {
      _checkSectionVisibility();
    });


    print("_communityList");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only call the API if it's not already loading
      print("_communityListcall");
      final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription
            .getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }
 
      final provider = Provider.of<CommunityProvider>(context, listen: false);
      if (!provider.isgetCommunityLoading) {
      
          print("_communityListcall2");
        provider.getCommunityAPI(true);
      }
         print("upcomingList");
       if (!provider.isgetUpcomgLoading) {
      
          print("upcoming");
        provider.getUpcomingCoursesAPI();
      }
    });
  }

  // Function to check which section is currently in view
  void _checkSectionVisibility() {
    final section1Position = _getSectionPosition(_section1Key);
    final section2Position = _getSectionPosition(_section2Key);
    final section3Position = _getSectionPosition(_section3Key);

    bool section1InView = section1Position != null &&
        section1Position < SizeConfig.blockSizeVertical * 80 &&
        section1Position > 0;
    bool section2InView = section2Position != null &&
        section2Position < SizeConfig.blockSizeVertical * 80 &&
        section2Position > 0;
    bool section3InView = section3Position != null &&
        section3Position < SizeConfig.blockSizeVertical * 80 &&
        section3Position > 0;

    // Update the current section and arrow visibility based on which one is in view
    if (section1InView || section2InView || section3InView) {
      setState(() {
        _showArrowButton =
            true; // Show the arrow button when any section is in view
      });
    } else {
      setState(() {
        _showArrowButton = false;
        _currentSection = 0; // Reset section when none is in view
      });
    }

    if (section1InView) {
      setState(() {
        _currentSection = 1;
      });
    } else if (section2InView) {
      setState(() {
        _currentSection = 2;
      });
    } else if (section3InView) {
      setState(() {
        _currentSection = 3;
      });
    }
  }

  // Function to get the position of the section
  double? _getSectionPosition(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      return box?.localToGlobal(Offset.zero).dy;
    }
    return null;
  }

  // Function to scroll to the top
  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  // Function to scroll to a specific section
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
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
                      controller: _scrollController,
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
                                      "Hello ${GlobalLists.customerName} !",
                                      style: CraftStyles.tsWhiteNeutral50W700,
                                    ),
                                     Row(
                                       children: [
                                         SvgPicture.asset(
                                                                 CraftImagePath.notification,
                                                                 width: 30, // Play button size
                                                                 height: 30, // Adjust size as needed
                                                               ),
                                                               SizedBox(width: SizeConfig.blockSizeHorizontal*2,),
                                                                GestureDetector(
                                                                  onTap: ()
                                                                  {
                                                                     Navigator.of(context)
                        .pushNamed(
                          SavedPostScreen.route,
                        )
                        .then((value) {});
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                                          CraftImagePath.saved,
                                                                                          width: 30, // Play button size
                                                                                          height: 30, // Adjust size as needed
                                                                                        ),
                                                                ),
                                       ],
                                     ),
                                   
                                  ],
                                ),
                                SizedBox(height: SizeConfig.blockSizeVertical*2,),
                                Text(
                                  "What’s new with you? Would you like to share something with the community?🤗",
                                  style: CraftStyles.tsWhiteNeutral300W400,
                                ),
                              ],
                            ),
                          ),
Text(communityprovider.communityList.length.toString()),
                          // List of posts
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: communityprovider.communityList.length,
                            itemBuilder: (context, index) {
                              
                              return PostWidget(
                                post: communityprovider.communityList[index],
                                index: index,
                                onCommentPostTap: (index) {
                                  communityprovider.commentList.clear();
                                  communityprovider.commentsCommunityAPI(
                                      communityprovider.communityList[index].id
                                          .toString());
                                  _showCommentBottomSheet(communityprovider
                                      .communityList[index].id
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
                                              .communityList[index].id
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
                                      communityprovider.communityList[index].id
                                          .toString());
                                },
                                onLikeTap: (index) {
                                  print("like");
                                  final post =
                                      communityprovider.communityList[index];
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
                                  print("saved");
                                  final post =
                                      communityprovider.communityList[index];

                                  if (post.hasSaved) {
                                    // If the post is liked, dislike the post
                                    post.hasSaved = false;

                                    communityprovider.unsavedCommunityAPI(
                                        post.id.toString()); // Call dislike API
                                  } else {
                                    // If the post is not liked, like the post
                                    post.hasSaved = true;

                                    communityprovider.savedCommunityAPI(
                                        post.id.toString()); // Call like API
                                  }
                                  // Call setState to update the UI immediately
                                  setState(() {});
                                },
                                reportController:
                                    communityprovider.reportController,
                              );
                            },
                          ),

                        (communityprovider.communityList.length >= communityprovider.totalLength)?Container():
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Call the API to fetch more blogs
                                    communityprovider.getCommunityAPI(false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CraftColors.neutralBlue800,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child:communityprovider.isgetCommunityLoading?CircularProgressIndicator(color: CraftColors.neutral100,): Text(
                                    "View More",
                                    style: CraftStyles.tsWhiteNeutral50W60016
                                        .copyWith(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),

                            
                               
                              upcomingCourses("Upcoming Course"),
                          // // Section 1
                          // SizedBox(
                          //   key:
                          //       _section1Key, // Add key to scroll to this section
                          //   height: SizeConfig.safeBlockVertical * 100,
                          //   child: upcomingCourses("Upcoming Courses"),
                          // ),
                          // // Section 2
                          // SizedBox(
                          //   key:
                          //       _section2Key, // Add key to scroll to this section
                          //   height: SizeConfig.safeBlockVertical * 100,
                          //   child: upcomingCourses("Competitions"),
                          // ),
                          // // Section 3
                          // SizedBox(
                          //   key:
                          //       _section3Key, // Add key to scroll to this section
                          //   height: SizeConfig.safeBlockVertical * 100,
                          //   child: upcomingCourses("Live & Webinars"),
                          // ),
                        ],
                      ),
                    ),

                    // Floating action row fixed at the bottom
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(12.0),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: Colors.black.withOpacity(0.6),
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           // "Upcoming Courses" button with color change
                    //           IconButton(
                    //             icon: Text(
                    //               'Upcoming Courses',
                    //               style:
                    //                   CraftStyles.tsNeutral100W40010.copyWith(
                    //                 color: _currentSection == 1
                    //                     ? Colors.green
                    //                     : (_currentSection == 0
                    //                         ? Colors.white
                    //                         : Colors.white),
                    //               ),
                    //             ),
                    //             onPressed: () {
                    //               _scrollToSection(
                    //                   _section1Key); // Scroll to Section 1
                    //             },
                    //           ),
                    //           // "Competitions" button with color change
                    //           IconButton(
                    //             icon: Text(
                    //               'Competitions',
                    //               style:
                    //                   CraftStyles.tsNeutral100W40010.copyWith(
                    //                 color: _currentSection == 2
                    //                     ? Colors.green
                    //                     : (_currentSection == 0
                    //                         ? Colors.white
                    //                         : Colors.white),
                    //               ),
                    //             ),
                    //             onPressed: () {
                    //               _scrollToSection(
                    //                   _section2Key); // Scroll to Section 2
                    //             },
                    //           ),
                    //           // "Live & Webinars" button with color change
                    //           IconButton(
                    //             icon: Text(
                    //               'Live & Webinars',
                    //               style:
                    //                   CraftStyles.tsNeutral100W40010.copyWith(
                    //                 color: _currentSection == 3
                    //                     ? Colors.green
                    //                     : (_currentSection == 0
                    //                         ? Colors.white
                    //                         : Colors.white),
                    //               ),
                    //             ),
                    //             onPressed: () {
                    //               _scrollToSection(
                    //                   _section3Key); // Scroll to Section 3
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

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

                    // Arrow Button to scroll to top when one of the sections is visible
                    if (_showArrowButton)
                      Positioned(
                        bottom: 150, // Adjust to your liking
                        right: 16,
                        child: FloatingActionButton(
                          onPressed: _scrollToTop,
                          backgroundColor: CraftColors.neutralBlue750,
                          child: Icon(Icons.arrow_upward,
                              color: CraftColors.neutral100),
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

  Widget upcomingCourses(String title) {
    
    return Consumer<CommunityProvider>(builder: (context, provider, _) {
      // if(provider.isgetUpcomgLoading)
      // {
      //   return Center(child: CircularProgressIndicator());
      // }
      return  provider.upcomingCourseList.isEmpty?Container(): Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Text(
                title,
                style: CraftStyles.tsWhiteNeutral50W700,
              ),
             SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1),
              Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: provider.upcomingCourseList
                      .length, // Use the length of the list from provider
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      width: SizeConfig.safeBlockHorizontal * 100,
                      decoration: BoxDecoration(
                        color: CraftColors.neutralBlue800,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    // Image Container
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal *
                                          100,
                                      height:
                                          SizeConfig.blockSizeVertical * 25,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                          image: NetworkImage(provider.upcomingCourseList[index].courseBannerMobile),
                                          fit: BoxFit
                                              .cover, // Optional: Ensures the image scales properly
                                        ),
                                      ),
                                    ),
            
                                    // "New!" label Container positioned outside the image using Transform
                                    Transform.translate(
                                      offset: Offset(-20,
                                          -1), // Move the "New!" label slightly outside the image (left and top)
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: CraftColors.secondary100,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(4.0),
                                            child: Text(
                                             provider.upcomingCourseList[index].tagName,
                                              style: CraftStyles
                                                  .tssecondary800W500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1),
                                Text(
                                 provider.upcomingCourseList[index].instructor,
                                  style: CraftStyles.tsWhiteNeutral50W60016
                                      .copyWith(fontSize: 14),
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 55,
                                      child: Text(
                                       provider.upcomingCourseList[index].shortDescription,
                                        style: CraftStyles
                                            .tsWhiteNeutral200W500
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          SizeConfig.safeBlockHorizontal * 5,
                                    ),
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 20,
                                      height:
                                          SizeConfig.blockSizeVertical * 12,
                                      decoration: BoxDecoration(
                                        color: CraftColors.neutralBlue750,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            provider.upcomingCourseList[index].courseStartDate,
                                            style: CraftStyles
                                                .tsWhiteNeutral50W600
                                                .copyWith(fontSize: 16),
                                          ),
                                         
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12.0,
                                      backgroundImage:
                                          NetworkImage(provider.upcomingCourseList[index].masterProfilePhoto),
                                    ),
                                    SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    Text(
                                      provider.upcomingCourseList[index].masterName,
                                      style: CraftStyles.tsWhiteNeutral300W500
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

void _showCommentBottomSheet(String postId) {
  showModalBottomSheet(
    backgroundColor: CraftColors.neutral900,
    context: routeGlobalKey.currentContext!,
    isScrollControlled: true, // Important
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Consumer<CommunityProvider>(
        builder: (context, communityprovider, _) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom, // Handle keyboard
              top: 20,
            ),
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.4,
              maxChildSize: 0.95,
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    Container(
                      height: 4,
                      width: 40,
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Text("Comments", style: CraftStyles.tsWhiteNeutral50W60016),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: communityprovider.commentList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              ShowDialogs.showConfirmDialogdelete(
                                  context,
                                  "Delete",
                                  "Are You Sure You Want To Remove Comment ?",
                                  () {
                                Navigator.pop(context);
                                communityprovider.deleteCommentCommunityAPI(
                                  communityprovider.commentList[index].commentId.toString(),
                                );
                                communityprovider.commentController.clear();
                                final post = communityprovider.communityList
                                    .firstWhere((post) => post.id.toString() == postId);
                                if (int.parse(post.commentCount) > 0) {
                                  post.commentCount =
                                      (int.parse(post.commentCount) - 1).toString();
                                }
                                setState(() {});
                                Navigator.pop(context);
                              });
                            },
                            child: CommentWidget(
                              comment: communityprovider.commentList[index],
                              onLikeTap: (index) {
                                final post = communityprovider.commentList[index];
                                int postcount = int.parse(post.commentLikeCount ?? "0");
                                if (post.hasCommentLiked!) {
                                  post.hasCommentLiked = false;
                                  postcount--;
                                  communityprovider.unlikeCommentCommunityAPI(
                                      post.commentId.toString());
                                } else {
                                  post.hasCommentLiked = true;
                                  postcount++;
                                  post.commentLikeCount = postcount.toString();
                                  communityprovider.likeCommentCommunityAPI(
                                      post.commentId.toString());
                                }
                                setState(() {});
                              },
                              index: index,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: communityprovider.commentController,
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: CraftColors.neutral100),
                              ),
                              hintStyle: TextStyle(color: CraftColors.neutral100),
                            ),
                            style: TextStyle(color: CraftColors.neutral100),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            communityprovider.addCommentCommunityAPI(
                                postId, communityprovider.commentController.text);
                            communityprovider.commentController.clear();
                            final post = communityprovider.communityList
                                .firstWhere((post) => post.id.toString() == postId);
                            post.commentCount =
                                (int.parse(post.commentCount) + 1).toString();
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              CraftImagePath.publishlogo,
                              width: 24,
                              height: 24,
                              color: CraftColors.neutral100,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}

}
