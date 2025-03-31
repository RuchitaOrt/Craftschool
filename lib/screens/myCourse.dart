import 'package:craft_school/dto/MycourseResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CategoryListProvider.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/screens/AllCourses.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/BrowseTrendingCourse.dart';
import 'package:craft_school/widgets/ProgressBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/TrendingSkill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';

class Video {
  final String url;
  final String thumbnail;
  final String title;
  final String subtitle;
  final String description;

  Video({
    required this.url,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class MyCourseScreen extends StatefulWidget {
  static const String route = "/videoListscreen";

  // final List<Video> videos = [
  //   Video(
  //     url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  //     thumbnail: 'https://fastly.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s',
  //     title: 'Big Buck Bunny',
  //     subtitle: 'By Blender Foundation',
  //     description: 'Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself...',
  //   ),
  //   Video(
  //     url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  //     thumbnail: 'https://fastly.picsum.photos/id/22/4434/3729.jpg?hmac=fjZdkSMZJNFgsoDh8Qo5zdA_nSGUAWvKLyyqmEt2xs0',
  //     title: 'Elephant Dream',
  //     subtitle: 'By Blender Foundation',
  //     description: 'The first Blender Open Movie from 2006...',
  //   ),
  //   Video(
  //     url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
  //     thumbnail: 'https://fastly.picsum.photos/id/27/3264/1836.jpg?hmac=p3BVIgKKQpHhfGRRCbsi2MCAzw8mWBCayBsKxxtWO8g',
  //     title: 'Sintel',
  //     subtitle: 'By Blender Foundation',
  //     description: 'Sintel is an independently produced short film...',
  //   ),
  //   Video(
  //     url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
  //     thumbnail: 'https://fastly.picsum.photos/id/7/4728/3168.jpg?hmac=c5B5tfYFM9blHHMhuu4UKmhnbZoJqrzNOP9xjkV4w3o',
  //     title: 'Tears of Steel',
  //     subtitle: 'By Blender Foundation',
  //     description: 'Tears of Steel was realized with crowd-funding...',
  //   ),
  // ];

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<MyCourseScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isFullscreen = false;
  Video _currentVideo = Video(
    url: '',
    thumbnail: '',
    title: '',
    subtitle: '',
    description: '',
  );

  bool _isPlaying = false;
  double _currentPosition = 0.0;
  double _videoDuration = 0.0;

  Map<String, double> videoProgressMap = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }
      final providermaster =
          Provider.of<MasterAllProvider>(context, listen: false);
      if (!providermaster.isLoading) {
        print("Mycoursese");
        providermaster.getMasterAllAPI();
       
        providermaster.getTrendingClassAPI();
      }
      if(!providermaster.istrendingMasterLoading)
      {
 providermaster.getTrendingMasterAPI();
      }
      print("Mycourse11");
      final providercourse =
          Provider.of<CoursesProvider>(context, listen: false);
      if (!providercourse.ismycourseLoading) {
        print("Mycourse1");
        if (GlobalLists.authtoken != "") {
          print("Mycourse2");
          providercourse.getMyCourseAPI("0", "0", "0");
        }
      }
    });
 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget bannerImages() {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 40,
      child: Container(
        margin: EdgeInsets.all(8),
        width: SizeConfig.safeBlockHorizontal * 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
                image: AssetImage(
                  CraftImagePath.backgroundCourses,

                  // Get image from the provider list
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Image.asset(
                CraftImagePath.cards,
                width: SizeConfig.blockSizeHorizontal * 30,
                height: SizeConfig.blockSizeVertical * 10,
              ),
              Text(
                "Your learning journey is waiting to begin!",
                style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Text(
                "Start exploring courses and enroll in the ones that inspire you to create, learn, and grow.",
                style: CraftStyles.tsWhiteNeutral200W500.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Center(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(routeGlobalKey.currentContext!)
                          .pushNamed(
                            AllCourses.route,
                          )
                          .then((value) {});
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(SizeConfig.blockSizeVertical * 40,
                          SizeConfig.blockSizeVertical * 4),
                      backgroundColor: CraftColors.primaryBlue500,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add some spacing between icon and text
                        Text(
                          CraftStrings.strBrowseCourse,
                          style: CraftStyles.tsWhiteNeutral50W60016,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initializeController(String videoUrl) async {
    _controller = VideoPlayerController.network(videoUrl)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _videoDuration = _controller.value.duration.inSeconds.toDouble();
          _currentPosition = videoProgressMap[videoUrl] ?? 0.0;
          _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
        });
      });

    _controller.addListener(_videoPlayerListener);
    return _controller.initialize();
  }

  Widget browseOtherCourse() {
    return Consumer<MasterAllProvider>(
      builder: (context, provider, child) {
        return BrowseTrendingCourse(
          imagePaths: provider.trendingClassData,
          title: CraftStrings.strTrendingClass,
          onPressed: () {},
           onSaveButtonOnTap: (index) {
                  provider.saveTrendingCourse(index);
                },
                onunSaveButtonOnTap: (index) {
                  provider.unsaveTrendingCourse(index);
                },
        );
      },
    );
  }

  void _videoPlayerListener() {
    if (_controller.value.isInitialized && _controller.value.isPlaying) {
      setState(() {
        _currentPosition = _controller.value.position.inSeconds.toDouble();
      });
      videoProgressMap[_currentVideo.url] = _currentPosition;
    }
  }

  void _changeVideo(Datum video) {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    }

    videoProgressMap[_currentVideo.url] = _currentPosition;

    // setState(() {
    //   _currentVideo = video;
    //   _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
    //   _isPlaying = false;
    // });

    // _controller.play();
    // setState(() {
    //   _isPlaying = true;
    // });
  }

  String _formatTime(double seconds) {
    int mins = (seconds / 60).floor();
    int secs = (seconds % 60).toInt();
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<bool> _onBackPressed() async {
    if (_isFullscreen) {
      _toggleFullscreen(); // Reset fullscreen when back is pressed
      return false; // Prevent default back press behavior
    }else{
       Navigator.of(routeGlobalKey.currentContext!).pushNamed(LandingScreen.route);
    }
    return true; // Allow default back press behavior
  }

  @override
  Widget build(BuildContext context) {
    final double bottomNavHeight = kBottomNavigationBarHeight;
    final orientation = MediaQuery.of(context).orientation;

    // Adjust video height based on orientation
    double videoHeight = (orientation == Orientation.portrait)
        ? MediaQuery.of(context).size.height *
            0.30 // 30% of the screen height in portrait
        : MediaQuery.of(context).size.height; // Full screen in landscape

    double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return Scaffold(
            appBar: _isFullscreen
                ? null
                : PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: CustomAppBar(
                      isCategoryVisible: provider.isCategoryVisible,
                      onMenuPressed: () {
                        provider
                            .toggleSlidingContainer(); // Trigger toggle when menu is pressed
                      },
                      onCategoriesPressed: () {
                        provider.toggleSlidingCategory();
                      },
                      isContainerVisible: provider.isContainerVisible,
                    ),
                  ),
            backgroundColor: CraftColors.black18,
            body: WillPopScope(
              onWillPop: _onBackPressed, // Handle the back press
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Adjust the video height based on orientation
                  videoHeight = (orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height *
                          0.30 // 30% in portrait mode
                      : MediaQuery.of(context)
                          .size
                          .height; //constraints.maxHeight - MediaQuery.of(context).padding.top - bottomNavHeight;

                  return Consumer<CoursesProvider>(
                      builder: (context, courseprovider, child) {
                    return Stack(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: [
                            // Video player container with dynamic height
                            courseprovider.mycourseList.isNotEmpty
                                ? ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: [
                                      //      Expanded(
                                      //   child: SizedBox(
                                      //     width: double.infinity,
                                      //     height: videoHeight - bottomPadding, // Set dynamic height
                                      //     child: Center(
                                      //       child: Stack(
                                      //         children: [
                                      //           FutureBuilder(
                                      //             future: _initializeVideoPlayerFuture,
                                      //             builder: (context, snapshot) {
                                      //               if (snapshot.connectionState == ConnectionState.done) {
                                      //                 if (_controller.value.isInitialized) {
                                      //                   return AspectRatio(
                                      //                     aspectRatio: _controller.value.aspectRatio,
                                      //                     child: VideoPlayer(_controller),
                                      //                   );
                                      //                 }
                                      //               }
                                      //               return Center(child: CircularProgressIndicator());
                                      //             },
                                      //           ),
                                      //           Positioned.fill(
                                      //             child: Center(
                                      //               child: _buildPlayPauseControls(),
                                      //             ),
                                      //           ),
                                      //           Positioned(
                                      //             top: 10,
                                      //             right: 10,
                                      //             child: IconButton(
                                      //               icon: Icon(Icons.fullscreen, color: Colors.white),
                                      //               onPressed: _toggleFullscreen,
                                      //             ),
                                      //           ),
                                      //           Positioned(
                                      //             bottom: 10,
                                      //             left: 16,
                                      //             right: 16,
                                      //             child: Padding(
                                      //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      //               child: Row(
                                      //                 children: [
                                      //                   Text(
                                      //                     _formatTime(_currentPosition),
                                      //                     style: TextStyle(color: Colors.white),
                                      //                   ),
                                      //                   Expanded(
                                      //                     child: Slider(
                                      //                       value: _currentPosition,
                                      //                       min: 0.0,
                                      //                       max: _videoDuration,
                                      //                       onChanged: (double value) {
                                      //                         setState(() {
                                      //                           _controller.seekTo(Duration(seconds: value.toInt()));
                                      //                           _currentPosition = value;
                                      //                         });
                                      //                       },
                                      //                     ),
                                      //                   ),
                                      //                   Text(
                                      //                     _formatTime(_videoDuration),
                                      //                     style: TextStyle(color: Colors.white),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      if (!_isFullscreen)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                CraftStrings.strMyCourses,
                                                style: CraftStyles
                                                    .tsWhiteNeutral50W700
                                                    .copyWith(fontSize: 18),
                                              ),
                                            ),
                                               Padding(
                                                 padding: const EdgeInsets.only(top: 8),
                                                 child: Row(
                                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                                   children: [
                                                 GestureDetector(
                                                   onTap: ()
                                                   {
                                                     ShowCategoryFilter();
                                                   },
                                                   child: Padding(
                                                     padding: const EdgeInsets.only(right: 15),
                                                     child: Image.asset(CraftImagePath.filter,color: CraftColors.neutral100,width: 20,height: 20,),
                                                   )),
                                                                          
                                                                 ],),
                                               )
                                          ],
                                        ),
                                      // SizedBox(height: SizeConfig.blockSizeVertical * 2),
                                      if (!_isFullscreen)
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 45,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: courseprovider
                                                .mycourseList.length,
                                            itemBuilder: (context, index) {
                                              final video = courseprovider
                                                  .mycourseList[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(routeGlobalKey
                                                          .currentContext!)
                                                      .pushNamed(
                                                          Coursedetailscreen
                                                              .route,
                                                          arguments:
                                                              video.courseSlug)
                                                      .then((value) {});
                                                },
                                                child: Card(
                                                  color: CraftColors
                                                      .neutralBlue850,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                                  child: Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        50,
                                                    child: Column(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: CraftColors
                                                                    .neutralBlue800,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            16)),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        video
                                                                            .courseBannerMobile),
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                              height: SizeConfig
                                                                      .blockSizeVertical *
                                                                  28,
                                                            ),
      GlobalLists.authtoken!=""?                                                     
  courseprovider.mycourseList[index].savedFlag?GestureDetector(
      onTap: ()
      {
        
         courseprovider.unSavedCourseAPI(
                             courseprovider.mycourseList[index].courseId);
                              setState(() {
            courseprovider.mycourseList[index].savedFlag = false;
          });
      },
      child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: SvgPicture.asset(
                      CraftImagePath.save,
                      width: 22, // Play button size
                      height: 22, // Adjust size as needed
                    ),
                  ),
                ),
    ): GestureDetector(
      onTap: ()
      {
        
         courseprovider.savedCourseAPI(
                             courseprovider.mycourseList[index].courseId);
                              setState(() {
            courseprovider.mycourseList[index].savedFlag = true;
          });
      },
      child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: SvgPicture.asset(
                      CraftImagePath.saved,
                      width: 30, // Play button size
                      height: 30, // Adjust size as needed
                    ),
                  ),
                ),
    ):Container(),
                                                          ],
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    1,
                                                              ),
                                                              _buildSeekBar(
                                                                  video),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    1,
                                                              ),
                                                              Text(
                                                                video
                                                                    .courseName,
                                                                style: CraftStyles
                                                                    .tsWhiteNeutral50W600,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              SizedBox(
                                                                  height: SizeConfig
                                                                          .blockSizeVertical *
                                                                      2),
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius:
                                                                        16.0,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            video.masterProfilePhoto),
                                                                  ),
                                                                  SizedBox(
                                                                    width: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        2,
                                                                  ),
                                                                  Container(
                                                                    width: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        32,
                                                                    child: Text(
                                                                      video
                                                                          .masterName,
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: CraftStyles
                                                                          .tsWhiteNeutral50W700
                                                                          .copyWith(
                                                                              fontSize: 12),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  )
                                : bannerImages(),

                            if (!_isFullscreen)
                              Consumer<MasterAllProvider>(
                                  builder: (context, provider, child) {
                                return provider.trendingMasterData.isEmpty
                                    ? Container()
                                    : TrendingSkill(
                                        imagePaths: provider.trendingMasterData,
                                        title: CraftStrings.strtrendingSkills,
                                        onPressed: () {});
                              }),
                            if (!_isFullscreen) browseOtherCourse()
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
                    );
                  });
                },
              ),
            ),
          );
        }));
  }

  Widget _buildSeekBar(Datum video) {
    double progress = double.parse(video.completionPercentage
        .toString()); //videoProgressMap[video.url] ?? 0.0;  // Current video position
    double percentage = double.parse(video.completionPercentage
        .toString()); //(video.courseDurationSeconds > 0) ? (progress / video.courseDurationSeconds) * 100 : 0;  // Calculate percentage completed, ensuring no division by zero

    // Determine label text based on the progress percentage
    String statusLabel = video.completionStatus;
    // if (percentage == 0) {
    //   statusLabel = 'Not Started';
    // } else if (percentage == 100) {
    //   statusLabel = 'Completed';
    // } else {
    //   statusLabel = 'In Progress';
    // }
    print("progress");
    print(progress);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                statusLabel, // Display the dynamic status label
                style: CraftStyles.tsWhiteNeutral300W400,
              ),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 5), // Space between labels and progress bar
          (progress != null && video.courseDurationSeconds > 0)
              ? 
              ProgressBar(
                  currentPosition:
                      double.parse(video.totalWatchTimeSeconds.toString()),
                  duration: double.parse(video.courseDurationSeconds
                      .toString()), // Total video duration
                )
              : Container() // Total video duration
                
        ],
      ),
    );
  }

  // Widget _buildSeekBar(Video video) {
  //   double progress = videoProgressMap[video.url] ?? 0.0;
  //   return Row(
  //     children: [

  //       Slider(
  //         value: progress,
  //         min: 0.0,
  //         max: _videoDuration,
  //         onChanged: (double value) {
  //           setState(() {
  //             _controller.seekTo(Duration(seconds: value.toInt()));
  //             videoProgressMap[video.url] = value;
  //           });
  //         },
  //       ),

  //     ],
  //   );
  // }

  Widget _buildPlayPauseControls() {
    return IconButton(
      icon: Icon(
        _isPlaying ? Icons.pause : Icons.play_arrow,
        size: 50,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          if (_isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
          _isPlaying = !_isPlaying;
        });
      },
    );
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });

    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      // Add a delay to allow for layout changes to complete
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {});
      });
    }
  }

  int? selectedCategoryId=0;
    int? selectedMasterId=0;
  String selectedProgress = 'Progress'; // Default selection for Sort By
  String currentSection = 'Category'; // Default section is Category
  String currentProgress = '0';
  String selectedMaster = 'Master';
  ShowCategoryFilter() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: CraftColors.neutralBlue850,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Consumer<CategoryListProvider>(
          builder: (context, provider, child) {
            return StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    // Wrap everything inside a scroll view
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display selected filters text
                        Text(
                          "Filter by",
                          style: CraftStyles.tsWhiteNeutral50W700
                              .copyWith(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                    
                        SizedBox(height: 10),

                        // Row to divide the left section (Category, SortBy) and right section (Options)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Left Section: Category and Sort By options
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Category Option
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentSection =
                                            'Category'; // Change to Category
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: currentSection == 'Category'
                                            ? CraftColors.neutralBlue750
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Category",
                                        style: CraftStyles.tsWhiteNeutral50W700
                                            .copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                 
                                  SizedBox(height: 20),
                                  // Sort By Option
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentSection =
                                            'SortBy'; // Change to SortBy
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: currentSection == 'SortBy'
                                            ? CraftColors.neutralBlue750
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Sort By",
                                        style: CraftStyles.tsWhiteNeutral50W700
                                            .copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                   SizedBox(height: 20),
                                  // Sort By Option
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentSection =
                                            'Master'; // Change to SortBy
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: currentSection == 'Master'
                                            ? CraftColors.neutralBlue750
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Master",
                                        style: CraftStyles.tsWhiteNeutral50W700
                                            .copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: 1,
                              color: Colors.white,
                              height: SizeConfig.blockSizeVertical * 35,
                            ),

                            Expanded(
                              flex: 3,
                              child: currentSection == 'Category'
                                  ? SizedBox(
                                      height: SizeConfig.blockSizeVertical * 35,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: provider.categoryList.length,
                                        itemBuilder: (context, index) {
                                          return RadioListTile<int>(
                                            dense: true,
                                            activeColor:
                                                CraftColors.secondary100,
                                            title: Text(
                                              provider.categoryList[index]
                                                  .categoryName,
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W700
                                                  .copyWith(fontSize: 12),
                                            ),
                                            value:
                                                provider.categoryList[index].id,
                                            groupValue: selectedCategoryId,
                                            onChanged: (int? value) {
                                              setState(() {
                                                selectedCategoryId = value;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  :currentSection == 'Master'
                                  ?
                                  Consumer<MasterAllProvider>(
                                  builder: (context, masterprovider, child) {
                                return
                                   SizedBox(
                                      height: SizeConfig.blockSizeVertical * 35,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: masterprovider.masterAllData.length,
                                        itemBuilder: (context, index) {
                                          return RadioListTile<int>(
                                            dense: true,
                                            activeColor:
                                                CraftColors.secondary100,
                                            title: Text(
                                              masterprovider.masterAllData[index]
                                                  .name,
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W700
                                                  .copyWith(fontSize: 12),
                                            ),
                                            value:
                                                masterprovider.masterAllData[index].id,
                                            groupValue: selectedMasterId,
                                            onChanged: (int? value) {
                                              setState(() {
                                                selectedMasterId = value;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    );}): SizedBox(
                                      height: SizeConfig.blockSizeVertical * 35,
                                      child: Column(
                                        children: [
                                          // Sort By List
                                          ListTile(
                                            title: Text(
                                              "Not Started",
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W700
                                                  .copyWith(fontSize: 12),
                                            ),
                                            leading: Radio<String>(
                                              value: 'Latest',
                                              groupValue: selectedProgress,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedProgress = value!;
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              "In Progress",
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W700
                                                  .copyWith(fontSize: 12),
                                            ),
                                            leading: Radio<String>(
                                              value: 'In Progress',
                                              groupValue: selectedProgress,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedProgress = value!;
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Completed",
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W700
                                                  .copyWith(fontSize: 12),
                                            ),
                                            leading: Radio<String>(
                                              value: 'Completed',
                                              groupValue: selectedProgress,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedProgress = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        // Spacer to push the button to the bottom
                        SizedBox(
                            height: 20), // Space between content and button
                        // Apply Button at the bottom
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle "Apply" button click (pass the selected category ID and sort by option)
                              print(
                                  "Selected Category ID: $selectedCategoryId");
                              print("Selected Sort By: $selectedProgress");
                              if (selectedProgress == "Completed") {
                                currentProgress = "3";
                              } else if (selectedProgress == "In Progress") {
                                currentProgress = "2";
                              } else if (selectedProgress == "Not Started") {
                                currentProgress = "1";
                              } else {
                                currentProgress = "0";
                              }

                              Navigator.pop(context); // Close the bottom sheet
                              // Example of using the selected values to filter blogs
                              final provider = Provider.of<CoursesProvider>(
                                  context,
                                  listen: false);

                              if (!provider.isLoading) {
                                provider.getMyCourseAPI(
                                    selectedCategoryId.toString(), currentProgress, selectedMasterId.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  double.infinity, 50), // Full-width button
                              backgroundColor: CraftColors.neutralBlue800,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              "Apply",
                              style: CraftStyles.tsWhiteNeutral50W60016
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
