import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/PostWidget.dart';
import 'package:craft_school/screens/CreatePostScreen.dart';
import 'package:provider/provider.dart';

class Post {
  final String username;
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;

  Post({
    required this.username,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
  });
}

class PostScreen extends StatefulWidget {
  static const String route = "/postscreen";

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ScrollController _scrollController = ScrollController();
 //   final ScrollController _scrollController = ScrollController();
  final List<Post> posts = [
    Post(
      username: 'john_doe',
      imageUrl: CraftImagePath.image6,
      caption:
          'Vel et a doloremque ut quis eos necessitatibus illo. Laudantium voluptatum quibusdam doloremque ut quam aut et.🤔',
      likes: 120,
      comments: 45,
    ),
    Post(
      username: 'jane_doe',
      imageUrl: CraftImagePath.image9,
      caption: 'Loving this sunset! 🌅',
      likes: 200,
      comments: 50,
    ),
    // Add more posts here
  ];

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
        _showArrowButton = true; // Show the arrow button when any section is in view
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          isCategoryVisible: false,
          onMenuPressed: () {
            // Handle menu press if needed
          },
               onCategoriesPressed: () {  }, isContainerVisible: false,
        ),
      ),
      backgroundColor: CraftColors.black18,
      body: Stack(
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
                      Text(
                        "Hello Vinnet !",
                        style: CraftStyles.tsWhiteNeutral50W700,
                      ),
                      Text(
                        "What’s new with you? Would you like to share something with the community?🤗",
                        style: CraftStyles.tsWhiteNeutral300W400,
                      ),
                    ],
                  ),
                ),

                // List of posts
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostWidget(post: posts[index]);
                  },
                ),

                // Section 1
                Container(
                  key: _section1Key, // Add key to scroll to this section
                  height: SizeConfig.safeBlockVertical * 100,
                  child: upcomingCourses("Upcoming Courses"),
                ),
                // Section 2
                Container(
                  key: _section2Key, // Add key to scroll to this section
                  height: SizeConfig.safeBlockVertical * 100,
                  child: upcomingCourses("Competitions"),
                ),
                // Section 3
                Container(
                  key: _section3Key, // Add key to scroll to this section
                  height: SizeConfig.safeBlockVertical * 100,
                  child: upcomingCourses("Live & Webinars"),
                ),
              ],
            ),
          ),

          // Floating action row fixed at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // "Upcoming Courses" button with color change
                    IconButton(
                      icon: Text(
                        'Upcoming Courses',
                        style: CraftStyles.tsNeutral100W40010.copyWith(
                          color: _currentSection == 1
                              ? Colors.green
                              : (_currentSection == 0
                                  ? Colors.white
                                  : Colors.white),
                        ),
                      ),
                      onPressed: () {
                        _scrollToSection(_section1Key); // Scroll to Section 1
                      },
                    ),
                    // "Competitions" button with color change
                    IconButton(
                      icon: Text(
                        'Competitions',
                        style: CraftStyles.tsNeutral100W40010.copyWith(
                          color: _currentSection == 2
                              ? Colors.green
                              : (_currentSection == 0
                                  ? Colors.white
                                  : Colors.white),
                        ),
                      ),
                      onPressed: () {
                        _scrollToSection(_section2Key); // Scroll to Section 2
                      },
                    ),
                    // "Live & Webinars" button with color change
                    IconButton(
                      icon: Text(
                        'Live & Webinars',
                        style: CraftStyles.tsNeutral100W40010.copyWith(
                          color: _currentSection == 3
                              ? Colors.green
                              : (_currentSection == 0
                                  ? Colors.white
                                  : Colors.white),
                        ),
                      ),
                      onPressed: () {
                        _scrollToSection(_section3Key); // Scroll to Section 3
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating action button for creating post
          Positioned(
            bottom: 80, // Position the create post button slightly above the row
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CreatePostScreen.route);
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
                child: Icon(Icons.arrow_upward, color: CraftColors.neutral100),
              ),
            ),
        ],
      ),
    );
  }


  Widget upcomingCourses(String title) {
    return ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return SizedBox(
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                  Text(
                       title,
                        style: CraftStyles.tsWhiteNeutral50W700,
                      ),
                Padding(
                  padding:  EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: provider.aspiringListItems
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
                                        width: SizeConfig.blockSizeHorizontal * 100,
                                        height: SizeConfig.blockSizeVertical * 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          image: DecorationImage(
                                            image: AssetImage(provider
                                                .aspiringListItems[index]['image']!),
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
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                "Actor",
                                                style: CraftStyles.tssecondary800W500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                  Text(
                                    "Senior Configuration Director",
                                    style: CraftStyles.tsWhiteNeutral50W60016
                                        .copyWith(fontSize: 14),
                                  ),
                                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal * 62,
                                        child: Text(
                                          "Vel et a doloremque ut quis eos necessitatibus illo. Laudantium voluptatum quibusdam remque ut quam aut et. Dolores qui occaecati sed molestiae voluptatem quod nisi dolorem expedita.Vel et a doloremque ut quis eos necessitatibus illo. Laudantium voluptatum quibusdam remque ut quam aut et. Dolores qui occaecati sed molestiae voluptatem quod nisi dolorem.",
                                          style: CraftStyles.tsWhiteNeutral200W500
                                              .copyWith(fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(width: SizeConfig.safeBlockHorizontal*5,),
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal * 18,
                                        height: SizeConfig.blockSizeVertical * 12,
                                        decoration: BoxDecoration(
                                          color: CraftColors.neutralBlue750,
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(16)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          
                                          children: [
                                             Text(
                                          "13",
                                          style: CraftStyles.tsWhiteNeutral50W600
                                              .copyWith(fontSize: 16),
                                        ),
                                         Text(
                                          "Dec",
                                          style: CraftStyles.tsWhiteNeutral300W500
                                              .copyWith(fontSize: 14),
                                        ),
                                          ],),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12.0,
                                        backgroundImage:
                                            AssetImage(CraftImagePath.image1),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * 2,
                                      ),
                                      Text(
                                        "Aashif Shaikh",
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
          );
        }));
  }
}

// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/utils/sizeConfig.dart';
// import 'package:flutter/material.dart';
// import 'package:craft_school/screens/CreatePostScreen.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/craft_images.dart';
// import 'package:craft_school/utils/craft_styles.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';
// import 'package:craft_school/widgets/PostWidget.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class Post {
//   final String username;
//   final String imageUrl;
//   final String caption;
//   final int likes;
//   final int comments;

//   Post({
//     required this.username,
//     required this.imageUrl,
//     required this.caption,
//     required this.likes,
//     required this.comments,
//   });
// }

// class PostScreen extends StatefulWidget {
//   static const String route = "/postscreen";

//   @override
//   _PostScreenState createState() => _PostScreenState();
// }

// class _PostScreenState extends State<PostScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final List<Post> posts = [
//     Post(
//       username: 'john_doe',
//       imageUrl: CraftImagePath.image6,
//       caption:
//           'Vel et a doloremque ut quis eos necessitatibus illo. Laudantium voluptatum quibusdam doloremque ut quam aut et.🤔',
//       likes: 120,
//       comments: 45,
//     ),
//     Post(
//       username: 'jane_doe',
//       imageUrl: CraftImagePath.image9,
//       caption: 'Loving this sunset! 🌅',
//       likes: 200,
//       comments: 50,
//     ),
//     // Add more posts here
//   ];

//   final GlobalKey _section1Key = GlobalKey();
//   final GlobalKey _section2Key = GlobalKey();
//   final GlobalKey _section3Key = GlobalKey();

//   int _currentSection = 0;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       _checkSectionVisibility();
//     });
//   }

//   // Function to check which section is currently in view
//   void _checkSectionVisibility() {
//     final section1Position = _getSectionPosition(_section1Key);
//     final section2Position = _getSectionPosition(_section2Key);
//     final section3Position = _getSectionPosition(_section3Key);

//     // Determine if any section is in view
//     bool section1InView = section1Position != null &&
//         section1Position < SizeConfig.blockSizeVertical*80 &&
//         section1Position > 0;
//     bool section2InView = section2Position != null &&
//         section2Position < SizeConfig.blockSizeVertical*80 &&
//         section2Position > 0;
//     bool section3InView = section3Position != null &&
//         section3Position < SizeConfig.blockSizeVertical*80 &&
//         section3Position > 0;

//     // Debug prints
//     print("Section 1 Position: $section1Position");
//     print("Section 2 Position: $section2Position");
//     print("Section 3 Position: $section3Position");

//     // Update the current section based on which one is in view
//     if (section1InView) {
//       setState(() {
//         _currentSection = 1;
//       });
//     } else if (section2InView) {
//       setState(() {
//         _currentSection = 2;
//       });
//     } else if (section3InView) {
//       setState(() {
//         _currentSection = 3;
//       });
//     } else {
//       // If no section is in view, reset to default (white)
//       setState(() {
//         _currentSection = 0;
//       });
//     }
//   }

//   // Function to get the position of the section
//   double? _getSectionPosition(GlobalKey key) {
//     final context = key.currentContext;
//     if (context != null) {
//       final box = context.findRenderObject() as RenderBox?;
//       return box?.localToGlobal(Offset.zero).dy;
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: CustomAppBar(
//           onMenuPressed: () {
//             // provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
//           },
//         ),
//       ),
//       backgroundColor: CraftColors.black18,
//       body: Stack(
//         children: [
//           // Main content (ListView and other widgets)
//           SingleChildScrollView(
//             controller: _scrollController,
//             physics: ScrollPhysics(),
//             child: ListView(
//               shrinkWrap: true,
//               physics: ScrollPhysics(),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Hello Vinnet !",
//                         style: CraftStyles.tsWhiteNeutral50W700,
//                       ),
//                       Text(
//                         "What’s new with you? Would you like to share something with community?🤗",
//                         style: CraftStyles.tsWhiteNeutral300W400,
//                       ),
//                     ],
//                   ),
//                 ),

//                 // List of posts
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: ScrollPhysics(),
//                   itemCount: posts.length,
//                   itemBuilder: (context, index) {
//                     return PostWidget(post: posts[index]);
//                   },
//                 ),
//                 // Section 1
//                 Container(
//                   key: _section1Key, // Add key to scroll to this section

//                    height: SizeConfig.safeBlockVertical*100,
//                   child: upcomingCourses("Upcoming Courses"),
//                 ),
//                 // Section 2
//                 Container(
//                   key: _section2Key, // Add key to scroll to this section
//                 height: SizeConfig.safeBlockVertical*100,
//                   child: upcomingCourses("Competitions"),
//                 ),

//                 // Section 3
//                 Container(
//                   key: _section3Key, // Add key to scroll to this section
//                   height: SizeConfig.safeBlockVertical*100,
//                   child: upcomingCourses("Live & Webinars"),
//                 ),
//               ],
//             ),
//           ),

//           // Floating action row fixed at the bottom
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // "Upcoming Courses" button with color change
//                     IconButton(
//                       icon: Text(
//                         'Upcoming Courses',
//                         style: CraftStyles.tsNeutral100W40010.copyWith(
//                           color: _currentSection == 1
//                               ? Colors.green
//                               : (_currentSection == 0
//                                   ? Colors.white
//                                   : Colors.white),
//                         ),
//                       ),
//                       onPressed: () {
//                         _scrollToSection(_section1Key); // Scroll to Section 1
//                       },
//                     ),

//                     // "Competitions" button with color change
//                     IconButton(
//                       icon: Text(
//                         'Competitions',
//                         style: CraftStyles.tsNeutral100W40010.copyWith(
//                           color: _currentSection == 2
//                               ? Colors.green
//                               : (_currentSection == 0
//                                   ? Colors.white
//                                   : Colors.white),
//                         ),
//                       ),
//                       onPressed: () {
//                         _scrollToSection(_section2Key); // Scroll to Section 2
//                       },
//                     ),

//                     // "Live & Webinars" button with color change
//                     IconButton(
//                       icon: Text(
//                         'Live & Webinars',
//                         style: CraftStyles.tsNeutral100W40010.copyWith(
//                           color: _currentSection == 3
//                               ? Colors.green
//                               : (_currentSection == 0
//                                   ? Colors.white
//                                   : Colors.white),
//                         ),
//                       ),
//                       onPressed: () {
//                         _scrollToSection(_section3Key); // Scroll to Section 3
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Floating action button for creating post
//           Positioned(
//             bottom:
//                 80, // Position the create post button slightly above the row
//             right: 16,
//             child: FloatingActionButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(CreatePostScreen.route);
//               },
//               backgroundColor: CraftColors.neutralBlue750,
//               child: Icon(Icons.add, color: CraftColors.neutral100),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Function to scroll to specific section
//   void _scrollToSection(GlobalKey key) {
//     final context = key.currentContext;
//     if (context != null) {
//       Scrollable.ensureVisible(context,
//           duration: Duration(milliseconds: 300), curve: Curves.easeIn);
//     }
//   }

//   Widget upcomingCourses(String title) {
//     return ChangeNotifierProvider(
//         create: (_) => LandingScreenProvider(),
//         child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
//           return SizedBox(
//             child: ListView(
//               shrinkWrap: true,
//               physics: ScrollPhysics(),
//               children: [
//                   Text(
//                        title,
//                         style: CraftStyles.tsWhiteNeutral50W700,
//                       ),
//                 Padding(
//                   padding:  EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*10),
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     physics: ScrollPhysics(),
//                     itemCount: provider.aspiringListItems
//                         .length, // Use the length of the list from provider
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin: EdgeInsets.all(8),
//                         width: SizeConfig.safeBlockHorizontal * 100,
//                         decoration: BoxDecoration(
//                           color: CraftColors.neutralBlue800,
//                           borderRadius: BorderRadius.all(Radius.circular(16)),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SizedBox(
//                               width: SizeConfig.blockSizeHorizontal * 40,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       // Image Container
//                                       Container(
//                                         width: SizeConfig.blockSizeHorizontal * 100,
//                                         height: SizeConfig.blockSizeVertical * 25,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(20.0),
//                                           image: DecorationImage(
//                                             image: AssetImage(provider
//                                                 .aspiringListItems[index]['image']!),
//                                             fit: BoxFit
//                                                 .cover, // Optional: Ensures the image scales properly
//                                           ),
//                                         ),
//                                       ),
                  
//                                       // "New!" label Container positioned outside the image using Transform
//                                       Transform.translate(
//                                         offset: Offset(-20,
//                                             -1), // Move the "New!" label slightly outside the image (left and top)
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: CraftColors.secondary100,
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(4.0),
//                                               child: Text(
//                                                 "Actor",
//                                                 style: CraftStyles.tssecondary800W500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: SizeConfig.blockSizeVertical * 1),
//                                   Text(
//                                     "Senior Configuration Director",
//                                     style: CraftStyles.tsWhiteNeutral50W60016
//                                         .copyWith(fontSize: 14),
//                                   ),
//                                   SizedBox(height: SizeConfig.blockSizeVertical * 1),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: SizeConfig.blockSizeHorizontal * 62,
//                                         child: Text(
//                                           "Vel et a doloremque ut quis eos necessitatibus illo. Laudantium voluptatum quibusdam remque ut quam aut et. Dolores qui occaecati sed molestiae voluptatem quod nisi dolorem expedita.Vel et a doloremque ut quis eos necessitatibus illo. Laudantium voluptatum quibusdam remque ut quam aut et. Dolores qui occaecati sed molestiae voluptatem quod nisi dolorem.",
//                                           style: CraftStyles.tsWhiteNeutral200W500
//                                               .copyWith(fontSize: 12),
//                                         ),
//                                       ),
//                                       SizedBox(width: SizeConfig.safeBlockHorizontal*5,),
//                                       Container(
//                                         width: SizeConfig.blockSizeHorizontal * 18,
//                                         height: SizeConfig.blockSizeVertical * 12,
//                                         decoration: BoxDecoration(
//                                           color: CraftColors.neutralBlue750,
//                                           borderRadius:
//                                               BorderRadius.all(Radius.circular(16)),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
                                          
//                                           children: [
//                                              Text(
//                                           "13",
//                                           style: CraftStyles.tsWhiteNeutral50W600
//                                               .copyWith(fontSize: 16),
//                                         ),
//                                          Text(
//                                           "Dec",
//                                           style: CraftStyles.tsWhiteNeutral300W500
//                                               .copyWith(fontSize: 14),
//                                         ),
//                                           ],),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: SizeConfig.blockSizeVertical * 1),
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 12.0,
//                                         backgroundImage:
//                                             AssetImage(CraftImagePath.image1),
//                                       ),
//                                       SizedBox(
//                                         width: SizeConfig.blockSizeHorizontal * 2,
//                                       ),
//                                       Text(
//                                         "Aashif Shaikh",
//                                         style: CraftStyles.tsWhiteNeutral300W500
//                                             .copyWith(fontSize: 14),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }));
//   }
// }
