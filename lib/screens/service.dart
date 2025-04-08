// Imports remain unchanged
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:craft_school/providers/GetServiceProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';

class AspiringTrainingScreen extends StatefulWidget {
  static const String route = "/services";
  const AspiringTrainingScreen({Key? key}) : super(key: key);

  @override
  _AspiringTrainingScreenState createState() => _AspiringTrainingScreenState();
}

class _AspiringTrainingScreenState extends State<AspiringTrainingScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final landingProvider = Provider.of<LandingScreenProvider>(context, listen: false);
      final serviceProvider = Provider.of<GetServiceProvider>(context, listen: false);

      if (!landingProvider.isSubscriptionLoading) {
        landingProvider.getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }

      await serviceProvider.getServiceAPI();

      if (serviceProvider.serviceData.length > 3) {
        final videoUrl = serviceProvider.serviceData[3].media1;

        _controller = VideoPlayerController.network(videoUrl);
        _initializeVideoPlayerFuture = _controller.initialize().then((_) {
          setState(() {
            _isControllerInitialized = true;
          });
        }).catchError((e) {
          print("❌ Failed to initialize video: $e");
        });
      }
    });
  }

  @override
  void dispose() {
    if (_isControllerInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingScreenProvider(),
      child: Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
          return WillPopScope(
            onWillPop: () async {
              provider.onBackPressed();
              return false;
            },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(
                  isContainerVisible: provider.isContainerVisible,
                  isCategoryVisible: provider.isCategoryVisible,
                  onMenuPressed: provider.toggleSlidingContainer,
                  onCategoriesPressed: provider.toggleSlidingCategory,
                  isSearchClickVisible: () => provider.toggleSearchIconCategory(),
                  isSearchValueVisible: provider.isSearchIconVisible,
                ),
              ),
              backgroundColor: CraftColors.black18,
              bottomNavigationBar: BottomAppBarWidget(index: -1),
              floatingActionButton: FloatingActionButtonWidget(isOnLandingScreen: false),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              body: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      Text(
                        "Why Aspiring Filmmakers Choose Us for Training",
                        style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Consumer<GetServiceProvider>(
                        builder: (context, provider, _) {
                          if (provider.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.serviceData.length,
                            itemBuilder: (context, index) {
                              bool isOddIndex = index.isOdd;

                              return Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: CraftColors.neutralBlue800,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        isOddIndex ? MainAxisAlignment.start : MainAxisAlignment.end,
                                    children: [
                                      if (!isOddIndex) textBlock(provider, index),
                                      index == 3
                                          ? _buildVideoPlayer()
                                          : imageBlock(provider.serviceData[index].media1),
                                      if (isOddIndex) textBlock(provider, index),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  if (provider.isContainerVisible)
                    SlidingMenu(isVisible: provider.isContainerVisible),
                  if (provider.isCategoryVisible)
                    SlidingCategory(
                      isExpanded: provider.isCategoryVisible,
                      onToggleExpansion: provider.toggleSlidingCategory,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 40,
      height: SizeConfig.blockSizeVertical * 25,
      child: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && _controller.value.isInitialized) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          if (_isControllerInitialized)
            Positioned.fill(
              child: Center(
                child: IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _togglePlayPause,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget textBlock(GetServiceProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: SizeConfig.blockSizeHorizontal * 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(provider.getImagePath(index)),
            SizedBox(height: SizeConfig.blockSizeVertical * 1),
            Text(
              provider.serviceData[index].title,
              style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            Text(
              provider.serviceData[index].description,
              style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageBlock(String imageUrl) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 40,
      height: SizeConfig.blockSizeVertical * 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:craft_school/providers/GetServiceProvider.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/craft_styles.dart';
// import 'package:craft_school/utils/sizeConfig.dart';
// import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';
// import 'package:craft_school/widgets/FloatingActionButton.dart';
// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:craft_school/providers/LandingScreenProvider.dart';

// class AspiringTrainingScreen extends StatefulWidget {
//   static const String route = "/services";
//   const AspiringTrainingScreen({Key? key}) : super(key: key);

//   @override
//   _AspiringTrainingScreenState createState() => _AspiringTrainingScreenState();
// }

// class _AspiringTrainingScreenState extends State<AspiringTrainingScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isPlaying = false;
//   bool _isControllerInitialized = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller = VideoPlayerController.network(
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//     );

//     _initializeVideoPlayerFuture = _controller.initialize().then((_) {
//       print("✅ Video initialized successfully");
//       setState(() {
//         _isControllerInitialized = true;
//       });
//     }).catchError((e) {
//       print("❌ Failed to initialize video: $e");
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (_isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//       _isPlaying = !_isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {
//           return WillPopScope(
//             onWillPop: () async {
//               provider.onBackPressed();
//               return false;
//             },
//             child: Scaffold(
//               appBar: PreferredSize(
//                 preferredSize: const Size.fromHeight(kToolbarHeight),
//                 child: CustomAppBar(
//                   isContainerVisible: provider.isContainerVisible,
//                   isCategoryVisible: provider.isCategoryVisible,
//                   onMenuPressed: provider.toggleSlidingContainer,
//                   onCategoriesPressed: provider.toggleSlidingCategory,
//                   isSearchClickVisible: () => provider.toggleSearchIconCategory(),
//                   isSearchValueVisible: provider.isSearchIconVisible,
//                 ),
//               ),
//               backgroundColor: CraftColors.black18,
//               bottomNavigationBar: BottomAppBarWidget(index: -1),
//               floatingActionButton: FloatingActionButtonWidget(isOnLandingScreen: false),
//               floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//               body: Stack(
//                 children: [
//                   ListView(
//                     padding: const EdgeInsets.all(8),
//                     children: [
//                       Text(
//                         "Why Aspiring Filmmakers Choose Us for Training",
//                         style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
//                       ),
//                       const SizedBox(height: 16),
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: CraftColors.neutralBlue800,
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: const [
//                                     Text("Sample Video", style: TextStyle(color: Colors.white)),
//                                     SizedBox(height: 8),
//                                     Text("Watch this sample video to test video playback.",
//                                         style: TextStyle(color: Colors.white70)),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               _buildVideoPlayer(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
//                   if (provider.isCategoryVisible)
//                     SlidingCategory(
//                       isExpanded: provider.isCategoryVisible,
//                       onToggleExpansion: provider.toggleSlidingCategory,
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildVideoPlayer() {
//     return Container(
//       width: SizeConfig.blockSizeHorizontal * 40,
//       height: SizeConfig.blockSizeVertical * 25,
//       child: Stack(
//         children: [
//           FutureBuilder(
//             future: _initializeVideoPlayerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done && _controller.value.isInitialized) {
//                 return AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//           if (_isControllerInitialized)
//             Positioned.fill(
//               child: Center(
//                 child: IconButton(
//                   icon: Icon(
//                     _isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                   onPressed: _togglePlayPause,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }


// // import 'package:craft_school/providers/GetServiceProvider.dart';
// // import 'package:craft_school/utils/craft_colors.dart';
// // import 'package:craft_school/utils/craft_images.dart';
// // import 'package:craft_school/utils/craft_styles.dart';
// // import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
// // import 'package:craft_school/widgets/CustomAppBar.dart';
// // import 'package:craft_school/widgets/FloatingActionButton.dart';
// // import 'package:craft_school/widgets/SlidingCategory.dart';
// // import 'package:craft_school/widgets/SlidingMenu.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:flutter_svg/flutter_svg.dart'; // For SVG support
// // import 'package:craft_school/utils/sizeConfig.dart';
// // import 'package:craft_school/providers/LandingScreenProvider.dart';
// // import 'package:video_player/video_player.dart';

// // class AspiringTrainingScreen extends StatefulWidget {
// //    static const String route = "/services";
// //   const AspiringTrainingScreen({Key? key}) : super(key: key);

// //   @override
// //   _AspiringTrainingScreenState createState() => _AspiringTrainingScreenState();
// // }

// // class _AspiringTrainingScreenState extends State<AspiringTrainingScreen> {
// //     late VideoPlayerController _controller;
// //   bool _isControllerInitialized = false; // To track if the video controller has been initialized
// //  bool _isPlaying = false;
// //   @override
// //   void dispose() {
// //     if (_isControllerInitialized) {
// //       _controller.dispose(); // Dispose the controller if it was initialized
// //     }
// //     super.dispose();
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
   

// //     // Keeping your original code as requested
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
       
// //     final providerSubscription =
// //           Provider.of<LandingScreenProvider>(context, listen: false);

// //       if (!providerSubscription.isSubscriptionLoading) {
// //         providerSubscription
// //             .getcheckSubscriptionIndividualFlowWiseInfoAPI();
// //       }
// //       final provider = Provider.of<GetServiceProvider>(context, listen: false);
// //       if (!provider.isLoading) {
// //         print("_isControllerInitialized2");
// //         provider.getServiceAPI().then((val)
// //         {
// //             print("_isControllerInitialized");
// //             print(provider.serviceData[3].media1);
// //             //  _isControllerInitialized = true; 
// //  _controller = VideoPlayerController.network(provider.serviceData[3].media1)
// //           ..initialize().then((_) {
// //             setState(() {
// //               print("_isControllerInitialized1");
// //               _isControllerInitialized = true; // Mark controller as initialized
// //             });
// //           });
// //         });

       
// //       }
// //     });
// //   }
// //    // Function to toggle play/pause
// //   void _togglePlayPause() {
// //     setState(() {
// //       if (_isPlaying) {
// //         _controller.pause(); // Pause the video
// //       } else {
// //         _controller.play(); // Play the video
// //       }
// //       _isPlaying = !_isPlaying; // Toggle the play state
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //  return 
// //       ChangeNotifierProvider(
// //         create: (_) => LandingScreenProvider(),
// //         child: 
// //         Consumer<LandingScreenProvider>(
// //         builder: (context, provider, _) {
// //         return
// //     WillPopScope(
// //       onWillPop: ()async
// //       {
// //         provider.onBackPressed();
// //         return false;
// //       },
// //       child: Scaffold(
// //         appBar: PreferredSize(
// //               preferredSize: const Size.fromHeight(kToolbarHeight),
// //               child: CustomAppBar(
// //                 isContainerVisible: provider.isContainerVisible,
// //                 isCategoryVisible: provider.isCategoryVisible,
// //                 onMenuPressed: () {
// //                   provider
// //                       .toggleSlidingContainer(); // Trigger toggle when menu is pressed
// //                 },
// //                 onCategoriesPressed: () {
// //                   provider.toggleSlidingCategory();
// //                 },
// //                  isSearchClickVisible: ()
// //                 {
// //                   provider.toggleSearchIconCategory();
// //                 },
// //                 isSearchValueVisible: provider.isSearchIconVisible,
// //               ),
// //             ),
// //         backgroundColor: CraftColors.black18,
// //         bottomNavigationBar: BottomAppBarWidget(index: -1,),
// //         floatingActionButton:FloatingActionButtonWidget(isOnLandingScreen: false,),
// //         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //         body: Stack(
// //                 children: [
// //                   // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
// //                   ConstrainedBox(
// //                     constraints: BoxConstraints(minHeight: 0.0, maxHeight: double.infinity),
// //                     child: ListView(
// //                       shrinkWrap: true,
// //                       physics: ScrollPhysics(),
// //                       children: [
                  
// //                          aspiringTraining(),
                       
                        
// //                       ],
// //                     ),
// //                   ),
// //                   if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
// //                 if (provider.isCategoryVisible) SlidingCategory(
// //                   isExpanded: provider.isCategoryVisible,
// //                   onToggleExpansion: provider.toggleSlidingCategory,
// //                 ),
// //                 ],
// //               ),
// //       ),
// //     );
// //       }));
// //   }

// //   Widget aspiringTraining() {
// //     return Consumer<GetServiceProvider>(
// //       builder: (context, provider, child) {
// //          if (provider.isLoading) {
// //           return Center(child: CircularProgressIndicator());
// //         }
// //         return Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 "Why Aspiring Filmmakers Choose Us for Training",
// //                 style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
// //               ),
// //               SizedBox(
// //                 height: SizeConfig.blockSizeVertical * 2,
// //               ),
// //               SizedBox(
// //                 child: ListView.builder(
// //                   shrinkWrap: true,
// //                   scrollDirection: Axis.vertical,
// //                   physics: ScrollPhysics(),
// //                   itemCount: provider.serviceData
// //                       .length, // Use the length of the list from provider
// //                   itemBuilder: (context, index) {
// //                     bool isOddIndex = index.isOdd; // Check if index is odd
// //  if (index == 3 && !_isControllerInitialized) {
// //                   _controller = VideoPlayerController.network(provider.serviceData[3].media1)
// //                     ..initialize().then((_) {
// //                       setState(() {
// //                         _isControllerInitialized = true; // Mark controller as initialized
// //                       });
// //                     });
// //                 }

// //                     return Container(
// //                       margin: EdgeInsets.all(8),
// //                       width: SizeConfig.safeBlockHorizontal * 80,
// //                       decoration: BoxDecoration(
// //                         color: CraftColors.neutralBlue800,
// //                         borderRadius: BorderRadius.all(Radius.circular(16)),
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8),
// //                         child: Row(
// //                           mainAxisAlignment: isOddIndex
// //                               ? MainAxisAlignment.start
// //                               : MainAxisAlignment.end,
// //                           children: [
// //                             // First block (text)
// //                             if (!isOddIndex) ...[
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: SizeConfig.blockSizeHorizontal * 40,
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     children: [
// //                                       SvgPicture.asset(
// //                                         provider.getImagePath(index),
// //                                       ),
// //                                       SizedBox(
// //                                           height:
// //                                               SizeConfig.blockSizeVertical * 1),
// //                                       Text(
// //                                         provider.serviceData[index]
// //                                             .title,
// //                                         style: CraftStyles
// //                                             .tsWhiteNeutral50W60016
// //                                             .copyWith(fontSize: 14),
// //                                       ),
// //                                       SizedBox(
// //                                           height:
// //                                               SizeConfig.blockSizeVertical * 2),
// //                                       Text(
// //                                         provider.serviceData[index]
// //                                             .description,
// //                                         style: CraftStyles.tsWhiteNeutral300W500
// //                                             .copyWith(fontSize: 12),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                             // Second block (image)
// //                           index == 3
// //         ?  Container(
// //                             width: SizeConfig.blockSizeHorizontal * 40,  // Full width
// //                             height: SizeConfig.blockSizeVertical * 25, // Full height
// //                             child: _isControllerInitialized
// //                                 ? Stack(
// //                                     children: [
// //                                       AspectRatio(
// //                                         aspectRatio: _controller.value.aspectRatio,
// //                                         child: VideoPlayer(_controller),
// //                                       ),
// //                                       // Play/Pause button in the center of the video
// //                                       Center(
// //                                         child: IconButton(
// //                                           icon: Icon(
// //                                             _isPlaying ? Icons.pause : Icons.play_arrow,
// //                                             color: Colors.white,
// //                                             size: 25, // Size of the button
// //                                           ),
// //                                           onPressed: _togglePlayPause, // Toggle play/pause
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   )
// //                                 : Center(child: CircularProgressIndicator()),
// //                           ): Container(
// //                               width: SizeConfig.blockSizeHorizontal * 40,
// //                               height: SizeConfig.blockSizeVertical * 25,
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(20.0),
// //                                 image: DecorationImage(
// //                                   image: NetworkImage(provider
// //                                       .serviceData[index].media1),
// //                                   fit: BoxFit
// //                                       .cover, // Optional: Ensures the image scales properly
// //                                 ),
// //                               ),
// //                             ),
// //                             // Add first block (text) on the right when index is odd
// //                             if (isOddIndex) ...[
// //                               Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: SizedBox(
// //                                   width: SizeConfig.blockSizeHorizontal * 40,
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     children: [
// //                                       SvgPicture.asset(
// //                                         provider.getImagePath(index),
// //                                       ),
// //                                       SizedBox(
// //                                           height:
// //                                               SizeConfig.blockSizeVertical * 1),
// //                                       Text(
// //                                         provider.serviceData[index].title
// //                                             ,
// //                                         style: CraftStyles
// //                                             .tsWhiteNeutral50W60016
// //                                             .copyWith(fontSize: 14),
// //                                       ),
// //                                       SizedBox(
// //                                           height:
// //                                               SizeConfig.blockSizeVertical * 2),
// //                                       Text(
// //                                         provider.serviceData[index]
// //                                            .description,
// //                                         style: CraftStyles.tsWhiteNeutral300W500
// //                                             .copyWith(fontSize: 12),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               )
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
