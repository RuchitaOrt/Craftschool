import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:craft_school/utils/craft_colors.dart';
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

class VideoScreen extends StatefulWidget {
  static const String route = "/videoscreen";

  final String video;
  final String videoTopicSlug;
  final String videoCourseSlug;
  final String videoWatchTime;

  const VideoScreen({super.key, required this.video, required this.videoTopicSlug, required this.videoCourseSlug, required this.videoWatchTime});

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoScreen> with WidgetsBindingObserver {
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
  bool _hasApiCalled = false;  // Flag to ensure the API is called only once

  Map<String, double> videoProgressMap = {};
  double parseDuration(String duration) {
    print("DURATION");
    print(duration);
    List<String> parts = duration.split(':'); // Split the string by ":"
    
    // Make sure the duration is in correct format
    if (parts.length != 3) {
      throw FormatException("Invalid duration format. Expected hh:mm:ss.");
    }

    // Parse hours, minutes, and seconds
    double hours = double.parse(parts[0]);
    double minutes = double.parse(parts[1]);
    double seconds = double.parse(parts[2]);

    // Convert the total duration to seconds (as double)
    return (hours * 3600) + (minutes * 60) + seconds;
  }

  bool _isInitialized = false;  // To track initialization

  @override
  void initState() {
    super.initState();
    _currentPosition = parseDuration(widget.videoWatchTime);  // Set starting position
    _currentVideo = Video(url: widget.video, thumbnail: '', title: '', subtitle: '', description: '');
    _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerSubscription = Provider.of<LandingScreenProvider>(context, listen: false);
      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI(courseslug: widget.videoCourseSlug);
      }

      // final providermaster = Provider.of<MasterAllProvider>(context, listen: false);
      // if (!providermaster.isLoading) {
      //   providermaster.getTrendingMasterAPI();
      //   providermaster.getTrendingClassAPI();
      // }
    });

    // Register to observe app lifecycle
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    // Unregister lifecycle observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initializeController(String videoUrl) async {
    if (_isInitialized) return; // Prevent re-initialization

    _controller = VideoPlayerController.network(videoUrl)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          // Ensure the video duration is set after initialization
          _videoDuration = _controller.value.duration.inSeconds.toDouble();
         
          // Seek to the current position (starts from widget.videoWatchTime)
          _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
        });
      });

    _controller.addListener(_videoPlayerListener);
    _isInitialized = true;
    return _controller.initialize();
  }

  void _videoPlayerListener() {
    if (_controller.value.isInitialized && _controller.value.isPlaying) {
      setState(() {
        _currentPosition = _controller.value.position.inSeconds.toDouble();
      });
      videoProgressMap[_currentVideo.url] = _currentPosition;

      // Call watchTimeAPI every minute (60 seconds)
      if (_currentPosition % 60 == 0) {
        // Ensure the API is called only once per minute
        if (_currentPosition > 0) {
          _callWatchTimeAPI();
        }
      }
    }
  }

  void _callWatchTimeAPI() {
    // Your API call to update watch time
    print("API called to update watch time: $_currentPosition seconds");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only call the API if it's not already loading
      final provider = Provider.of<LandingScreenProvider>(context, listen: false);
      if (!provider.isWatchTimeLoading) {
        provider.watchTimeAPI(
          courseSlug: widget.videoCourseSlug,
          topicSlug: widget.videoTopicSlug,
          courseStatus: GlobalLists.courseStatus,
          coursesTime: _formatTime(_currentPosition).toString(),
        );
      }
    });
    // Set the flag after the API call
    _hasApiCalled = true;
  }

  void _changeVideo(Video video) {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    }

    videoProgressMap[_currentVideo.url] = _currentPosition;

    setState(() {
      _currentVideo = video;
      _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
      _isPlaying = false;
    });

    _controller.play();
    setState(() {
      _isPlaying = true;
    });
  }

  String _formatTime(double seconds) {
    int hours = (seconds / 3600).floor();  // Calculate hours
    int mins = ((seconds % 3600) / 60).floor();  // Calculate minutes
    int secs = (seconds % 60).toInt();  // Calculate seconds

    return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<bool> _onBackPressed() async {
    if (_isFullscreen) {
      setState(() {
        _isFullscreen = false;  // Exit fullscreen mode
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // Set portrait mode
      });
      return false; // Prevent default back press behavior
    } else {
      print("_callWatchTimeAPI backpress");
      _callWatchTimeAPI();
      Navigator.pop(context, true); // The 'true' value can be used to trigger the refresh
      return false; // Prevent default back press behavior
    }
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;  // Toggle fullscreen state
    });

    if (_isFullscreen) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);  // Switch back to portrait
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      // App is going to the background, save watch time
      print("_callWatchTimeAPI paused state");
      _callWatchTimeAPI();
    } else if (state == AppLifecycleState.resumed) {
      // App has come back to the foreground, update watch time
      print("_callWatchTimeAPI resumed");
      _callWatchTimeAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    double videoHeight = (orientation == Orientation.portrait)
        ? MediaQuery.of(context).size.height * 0.30
        : MediaQuery.of(context).size.height;

    double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    if (_isFullscreen) {
      videoHeight = MediaQuery.of(context).size.height;
      bottomPadding = 0.0;
    }

    return ChangeNotifierProvider(
      create: (_) => LandingScreenProvider(),
      child: Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: _isFullscreen
                ? null
                : PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: CustomAppBar(
                      isCategoryVisible: provider.isCategoryVisible,
                      onMenuPressed: () {
                        provider.toggleSlidingContainer();
                      },
                      onCategoriesPressed: () {
                        provider.toggleSlidingCategory();
                      },
                      isContainerVisible: provider.isCategoryVisible,
                    ),
                  ),
            backgroundColor: CraftColors.black18,
            body: WillPopScope(
              onWillPop: _onBackPressed,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: videoHeight - bottomPadding,
                        child: Center(
                          child: Stack(
                            children: [
                              FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    if (_controller.value.isInitialized) {
                                      return AspectRatio(
                                        aspectRatio: _controller.value.aspectRatio,
                                        child: VideoPlayer(_controller),
                                      );
                                    }
                                  }
                                  return Center(child: CircularProgressIndicator());
                                },
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: _buildPlayPauseControls(),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  icon: Icon(Icons.fullscreen, color: Colors.white),
                                  onPressed: _toggleFullscreen,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 16,
                                right: 16,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        _formatTime(_currentPosition),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Slider(
                                          value: _currentPosition.clamp(0.0, _videoDuration),
                                          min: 0.0,
                                          max: _videoDuration > 0.0 ? _videoDuration : 1.0,
                                          onChanged: (double value) {
                                            setState(() {
                                              _controller.seekTo(Duration(seconds: value.toInt()));
                                              _currentPosition = value.clamp(0.0, _videoDuration); 
                                            });
                                          },
                                        ),
                                      ),
                                      Text(
                                        _formatTime(_videoDuration),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
                  if (provider.isCategoryVisible) SlidingCategory(
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
            _callWatchTimeAPI();
          } else {
            _controller.play();
            _callWatchTimeAPI();
          }
          _isPlaying = !_isPlaying;
        });
      },
    );
  }
}

// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/providers/MasterAllProvider.dart';
// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';

// class Video {
//   final String url;
//   final String thumbnail;
//   final String title;
//   final String subtitle;
//   final String description;

//   Video({
//     required this.url,
//     required this.thumbnail,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//   });
// }

// class VideoScreen extends StatefulWidget {
//   static const String route = "/videoscreen";

//   final String video;
//   final String videoSlug;

//   const VideoScreen({super.key, required this.video, required this.videoSlug});

//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isFullscreen = false;
//   Video _currentVideo = Video(
//     url: '',
//     thumbnail: '',
//     title: '',
//     subtitle: '',
//     description: '',
//   );

//   bool _isPlaying = false;
//   double _currentPosition = 0.0;
//   double _videoDuration = 0.0;

//   Map<String, double> videoProgressMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _currentVideo = Video(url: widget.video, thumbnail: '', title: '', subtitle: '', description: '');
//     print("VIDEOLINK");
//     print(widget.video);
//     _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final providerSubscription =
//           Provider.of<LandingScreenProvider>(context, listen: false);

//       if (!providerSubscription.isSubscriptionLoading) {
//         providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI(courseslug: widget.videoSlug);
//       }

//       final providermaster = Provider.of<MasterAllProvider>(context, listen: false);
//       if (!providermaster.isLoading) {
//         providermaster.getTrendingMasterAPI();
//         providermaster.getTrendingClassAPI();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _initializeController(String videoUrl) async {
//     _controller = VideoPlayerController.network(videoUrl)
//       ..setLooping(true)
//       ..initialize().then((_) {
//         setState(() {
//           _videoDuration = _controller.value.duration.inSeconds.toDouble();
//           _currentPosition = videoProgressMap[videoUrl] ?? 0.0;
//           _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
//         });
//       });

//     _controller.addListener(_videoPlayerListener);
//     return _controller.initialize();
//   }

//   void _videoPlayerListener() {
//     if (_controller.value.isInitialized && _controller.value.isPlaying) {
//       setState(() {
//         _currentPosition = _controller.value.position.inSeconds.toDouble();
//       });
//       videoProgressMap[_currentVideo.url] = _currentPosition;
//     }
//   }

//   void _changeVideo(Video video) {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//       setState(() {
//         _isPlaying = false;
//       });
//     }

//     videoProgressMap[_currentVideo.url] = _currentPosition;

//     setState(() {
//       _currentVideo = video;
//       _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
//       _isPlaying = false;
//     });

//     _controller.play();
//     setState(() {
//       _isPlaying = true;
//     });
//   }

//   String _formatTime(double seconds) {
//     int hours = (seconds / 3600).floor();  // Calculate hours
//     int mins = ((seconds % 3600) / 60).floor();  // Calculate minutes
//     int secs = (seconds % 60).toInt();  // Calculate seconds

//     return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   Future<bool> _onBackPressed() async {
//     if (_isFullscreen) {
//       setState(() {
//         _isFullscreen = false;  // Exit fullscreen mode
//         SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // Set portrait mode
//       });
//       return false; // Prevent default back press behavior
//     } else {
//       Navigator.pop(context, true); // The 'true' value can be used to trigger the refresh
//       return false; // Prevent default back press behavior
//     }
//   }

//   void _toggleFullscreen() {
//     setState(() {
//       _isFullscreen = !_isFullscreen;  // Toggle fullscreen state
//     });

//     if (_isFullscreen) {
//       SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//     } else {
//       SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);  // Switch back to portrait
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orientation = MediaQuery.of(context).orientation;

//     // Adjust video height based on orientation and fullscreen state
//     double videoHeight = (orientation == Orientation.portrait)
//         ? MediaQuery.of(context).size.height * 0.30  // 30% of the screen height in portrait
//         : MediaQuery.of(context).size.height; // Full screen in landscape

//     double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

//     // Adjust the video height and padding for fullscreen mode
//     if (_isFullscreen) {
//       videoHeight = MediaQuery.of(context).size.height;  // Fullscreen height
//       bottomPadding = 0.0;  // Remove bottom padding in fullscreen mode
//     }

//     return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {
//           return Scaffold(
//             appBar: _isFullscreen
//                 ? null
//                 : PreferredSize(
//                     preferredSize: const Size.fromHeight(kToolbarHeight),
//                     child: CustomAppBar(
//                       isCategoryVisible: provider.isCategoryVisible,
//                       onMenuPressed: () {
//                         provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
//                       },
//                       onCategoriesPressed: () {  
//                         provider.toggleSlidingCategory();
//                       },
//                       isContainerVisible: provider.isCategoryVisible,
//                     ),
//                   ),
//             backgroundColor: CraftColors.black18,
//             body: WillPopScope(
//               onWillPop: _onBackPressed, // Handle the back press
//               child: Stack(
//                 children: [
//                   // Avoid ListView or any scrollable widget in fullscreen mode
//                   // Use a SingleChildScrollView if you need to scroll some content, but ensure video doesn't scroll
//                   Column(
//                     children: [
//                       // Video player container with dynamic height
//                       Container(
//                         width: double.infinity,
//                         height: videoHeight - bottomPadding, // Set dynamic height
//                         child: Center(
//                           child: Stack(
//                             children: [
//                               FutureBuilder(
//                                 future: _initializeVideoPlayerFuture,
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState == ConnectionState.done) {
//                                     if (_controller.value.isInitialized) {
//                                       return AspectRatio(
//                                         aspectRatio: _controller.value.aspectRatio,
//                                         child: VideoPlayer(_controller),
//                                       );
//                                     }
//                                   }
//                                   return Center(child: CircularProgressIndicator());
//                                 },
//                               ),
//                               Positioned.fill(
//                                 child: Center(
//                                   child: _buildPlayPauseControls(),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 10,
//                                 right: 10,
//                                 child: IconButton(
//                                   icon: Icon(Icons.fullscreen, color: Colors.white),
//                                   onPressed: _toggleFullscreen,
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 10,
//                                 left: 16,
//                                 right: 16,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         _formatTime(_currentPosition),
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       Expanded(
//                                         child: Slider(
//                                           value: _currentPosition,
//                                           min: 0.0,
//                                           max: _videoDuration,
//                                           onChanged: (double value) {
//                                             setState(() {
//                                               _controller.seekTo(Duration(seconds: value.toInt()));
//                                               _currentPosition = value;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                       Text(
//                                         _formatTime(_videoDuration),
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
//                   if (provider.isCategoryVisible) SlidingCategory(
//                     isExpanded: provider.isCategoryVisible,
//                     onToggleExpansion: provider.toggleSlidingCategory,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPlayPauseControls() {
//     return IconButton(
//       icon: Icon(
//         _isPlaying ? Icons.pause : Icons.play_arrow,
//         size: 50,
//         color: Colors.white,
//       ),
//       onPressed: () {
//         setState(() {
//           if (_isPlaying) {
//             _controller.pause();
//           } else {
//             _controller.play();
//           }
//           _isPlaying = !_isPlaying;
//         });
//       },
//     );
//   }
// }

// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/providers/MasterAllProvider.dart';

// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';

// class Video {
//   final String url;
//   final String thumbnail;
//   final String title;
//   final String subtitle;
//   final String description;

//   Video({
//     required this.url,
//     required this.thumbnail,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//   });
// }

// class VideoScreen extends StatefulWidget {
//   static const String route = "/videoscreen";

//   final String video;
//   final String videoSlug;

//   const VideoScreen({super.key, required this.video, required this.videoSlug});

//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isFullscreen = false;
//   Video _currentVideo = Video(
//     url: '',
//     thumbnail: '',
//     title: '',
//     subtitle: '',
//     description: '',
//   );

//   bool _isPlaying = false;
//   double _currentPosition = 0.0;
//   double _videoDuration = 0.0;

//   Map<String, double> videoProgressMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _currentVideo = Video(url: widget.video, thumbnail: '', title: '', subtitle: '', description: '');
//     print("VIDOE");
//     print(widget.video);
//     _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final providerSubscription =
//           Provider.of<LandingScreenProvider>(context, listen: false);

//       if (!providerSubscription.isSubscriptionLoading) {
//         providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI(courseslug: widget.videoSlug);
//       }

//       final providermaster = Provider.of<MasterAllProvider>(context, listen: false);
//       if (!providermaster.isLoading) {
//         providermaster.getTrendingMasterAPI();
//         providermaster.getTrendingClassAPI();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _initializeController(String videoUrl) async {
//     _controller = VideoPlayerController.network(videoUrl)
//       ..setLooping(true)
//       ..initialize().then((_) {
//         setState(() {
//           _videoDuration = _controller.value.duration.inSeconds.toDouble();
//           _currentPosition = videoProgressMap[videoUrl] ?? 0.0;
//           _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
//         });
//       });

//     _controller.addListener(_videoPlayerListener);
//     return _controller.initialize();
//   }

//   void _videoPlayerListener() {
//     if (_controller.value.isInitialized && _controller.value.isPlaying) {
//       setState(() {
//         _currentPosition = _controller.value.position.inSeconds.toDouble();
//       });
//       videoProgressMap[_currentVideo.url] = _currentPosition;
//     }
//   }

//   void _changeVideo(Video video) {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//       setState(() {
//         _isPlaying = false;
//       });
//     }

//     videoProgressMap[_currentVideo.url] = _currentPosition;

//     setState(() {
//       _currentVideo = video;
//       _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
//       _isPlaying = false;
//     });

//     _controller.play();
//     setState(() {
//       _isPlaying = true;
//     });
//   }

//   String _formatTime(double seconds) {
//     int hours = (seconds / 3600).floor();  // Calculate hours
//     int mins = ((seconds % 3600) / 60).floor();  // Calculate minutes
//     int secs = (seconds % 60).toInt();  // Calculate seconds

//     return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   Future<bool> _onBackPressed() async {
//     if (_isFullscreen) {
//       setState(() {
//         _isFullscreen = false;  // Exit fullscreen mode
//         SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // Set portrait mode
//       });
//       return false; // Prevent default back press behavior
//     } else {
//       Navigator.pop(context, true); // The 'true' value can be used to trigger the refresh
//       return false; // Prevent default back press behavior
//     }
//   }

//   void _toggleFullscreen() {
//     setState(() {
//       _isFullscreen = !_isFullscreen;  // Toggle fullscreen state
//     });

//     if (_isFullscreen) {
//       SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//     } else {
//       SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);  // Switch back to portrait
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double bottomNavHeight = kBottomNavigationBarHeight;
//     final orientation = MediaQuery.of(context).orientation;

//     // Adjust video height based on orientation and fullscreen state
//     double videoHeight = (orientation == Orientation.portrait)
//         ? MediaQuery.of(context).size.height * 0.30  // 30% of the screen height in portrait
//         : MediaQuery.of(context).size.height; // Full screen in landscape

//     double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

//     // Adjust the video height and padding for fullscreen mode
//     if (_isFullscreen) {
//       videoHeight = MediaQuery.of(context).size.height;  // Fullscreen height
//       bottomPadding = 0.0;  // Remove bottom padding in fullscreen mode
//     }

//     return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {
//           return Scaffold(
//             appBar: _isFullscreen
//                 ? null
//                 : PreferredSize(
//                     preferredSize: const Size.fromHeight(kToolbarHeight),
//                     child: CustomAppBar(
//                       isCategoryVisible: provider.isCategoryVisible,
//                       onMenuPressed: () {
//                         provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
//                       },
//                       onCategoriesPressed: () {  
//                         provider.toggleSlidingCategory();
//                       },
//                       isContainerVisible: provider.isCategoryVisible,
//                     ),
//                   ),
//             backgroundColor: CraftColors.black18,
//             body: WillPopScope(
//               onWillPop: _onBackPressed, // Handle the back press
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return Stack(
//                     children: [
//                       ListView(
//                         shrinkWrap: true,
//                         physics: ScrollPhysics(),
//                         children: [
//                           // Video player container with dynamic height
//                           SizedBox(
//                             width: double.infinity,
//                             height: videoHeight - bottomPadding, // Set dynamic height
//                             child: Center(
//                               child: Stack(
//                                 children: [
//                                   FutureBuilder(
//                                     future: _initializeVideoPlayerFuture,
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState == ConnectionState.done) {
//                                         if (_controller.value.isInitialized) {
//                                           return AspectRatio(
//                                             aspectRatio: _controller.value.aspectRatio,
//                                             child: VideoPlayer(_controller),
//                                           );
//                                         }
//                                       }
//                                       return Center(child: CircularProgressIndicator());
//                                     },
//                                   ),
//                                   Positioned.fill(
//                                     child: Center(
//                                       child: _buildPlayPauseControls(),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 10,
//                                     right: 10,
//                                     child: IconButton(
//                                       icon: Icon(Icons.fullscreen, color: Colors.white),
//                                       onPressed: _toggleFullscreen,
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 10,
//                                     left: 16,
//                                     right: 16,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             _formatTime(_currentPosition),
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                           Expanded(
//                                             child: Slider(
//                                               value: _currentPosition,
//                                               min: 0.0,
//                                               max: _videoDuration,
//                                               onChanged: (double value) {
//                                                 setState(() {
//                                                   _controller.seekTo(Duration(seconds: value.toInt()));
//                                                   _currentPosition = value;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           Text(
//                                             _formatTime(_videoDuration),
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
//                       if (provider.isCategoryVisible) SlidingCategory(
//                         isExpanded: provider.isCategoryVisible,
//                         onToggleExpansion: provider.toggleSlidingCategory,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPlayPauseControls() {
//     return IconButton(
//       icon: Icon(
//         _isPlaying ? Icons.pause : Icons.play_arrow,
//         size: 50,
//         color: Colors.white,
//       ),
//       onPressed: () {
//         setState(() {
//           if (_isPlaying) {
//             _controller.pause();
//           } else {
//             _controller.play();
//           }
//           _isPlaying = !_isPlaying;
//         });
//       },
//     );
//   }
// }

// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/providers/MasterAllProvider.dart';

// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';

// class Video {
//   final String url;
//   final String thumbnail;
//   final String title;
//   final String subtitle;
//   final String description;

//   Video({
//     required this.url,
//     required this.thumbnail,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//   });
// }

// class VideoScreen extends StatefulWidget {
//   static const String route = "/videoscreen";

//   final String video;
//   final String videoSlug;

//   const VideoScreen({super.key, required this.video, required this.videoSlug});

//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isFullscreen = false;
//   Video _currentVideo = Video(
//     url: '',
//     thumbnail: '',
//     title: '',
//     subtitle: '',
//     description: '',
//   );

//   bool _isPlaying = false;
//   double _currentPosition = 0.0;
//   double _videoDuration = 0.0;

//   Map<String, double> videoProgressMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _currentVideo = Video(url: widget.video, thumbnail: '', title: '', subtitle: '', description: '');
//     print(widget.video);
//     _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final providerSubscription =
//           Provider.of<LandingScreenProvider>(context, listen: false);

//       if (!providerSubscription.isSubscriptionLoading) {
//         providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI(courseslug: widget.videoSlug);
//       }

//       final providermaster = Provider.of<MasterAllProvider>(context, listen: false);
//       if (!providermaster.isLoading) {
//         providermaster.getTrendingMasterAPI();
//         providermaster.getTrendingClassAPI();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _initializeController(String videoUrl) async {
//     _controller = VideoPlayerController.network(videoUrl)
//       ..setLooping(true)
//       ..initialize().then((_) {
//         setState(() {
//           _videoDuration = _controller.value.duration.inSeconds.toDouble();
//           _currentPosition = videoProgressMap[videoUrl] ?? 0.0;
//           _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
//         });
//       });

//     _controller.addListener(_videoPlayerListener);
//     return _controller.initialize();
//   }

//   void _videoPlayerListener() {
//     if (_controller.value.isInitialized && _controller.value.isPlaying) {
//       setState(() {
//         _currentPosition = _controller.value.position.inSeconds.toDouble();
//       });
//       videoProgressMap[_currentVideo.url] = _currentPosition;
//     }
//   }

//   void _changeVideo(Video video) {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//       setState(() {
//         _isPlaying = false;
//       });
//     }

//     videoProgressMap[_currentVideo.url] = _currentPosition;

//     setState(() {
//       _currentVideo = video;
//       _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
//       _isPlaying = false;
//     });

//     _controller.play();
//     setState(() {
//       _isPlaying = true;
//     });
//   }

//   String _formatTime(double seconds) {
//     int hours = (seconds / 3600).floor();  // Calculate hours
//     int mins = ((seconds % 3600) / 60).floor();  // Calculate minutes
//     int secs = (seconds % 60).toInt();  // Calculate seconds

//     return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   Future<bool> _onBackPressed() async {
//     if (_isFullscreen) {
//       setState(() {
//         _isFullscreen = false;  // Exit fullscreen mode
//         SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // Set portrait mode
//       });
//       return false; // Prevent default back press behavior
//     } else {
//       Navigator.pop(context, true); // The 'true' value can be used to trigger the refresh
//       return false; // Prevent default back press behavior
//     }
//   }

//   void _toggleFullscreen() {
//     setState(() {
//       _isFullscreen = !_isFullscreen;  // Toggle fullscreen state
//     });

//     if (_isFullscreen) {
//       SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//     } else {
//       SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);  // Switch back to portrait
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double bottomNavHeight = kBottomNavigationBarHeight;
//     final orientation = MediaQuery.of(context).orientation;

//     // Adjust video height based on orientation and fullscreen state
//     double videoHeight = (orientation == Orientation.portrait)
//         ? MediaQuery.of(context).size.height * 0.30  // 30% of the screen height in portrait
//         : MediaQuery.of(context).size.height; // Full screen in landscape

//     double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

//     // Adjust the video height and padding for fullscreen mode
//     if (_isFullscreen) {
//       videoHeight = MediaQuery.of(context).size.height;  // Fullscreen height
//       bottomPadding = 0.0;  // Remove bottom padding in fullscreen mode
//     }

//     return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {
//           return Scaffold(
//             appBar: _isFullscreen
//                 ? null
//                 : PreferredSize(
//                     preferredSize: const Size.fromHeight(kToolbarHeight),
//                     child: CustomAppBar(
//                       isCategoryVisible: provider.isCategoryVisible,
//                       onMenuPressed: () {
//                         provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
//                       },
//                       onCategoriesPressed: () {  
//                         provider.toggleSlidingCategory();
//                       },
//                       isContainerVisible: provider.isCategoryVisible,
//                     ),
//                   ),
//             backgroundColor: CraftColors.black18,
//             body: WillPopScope(
//               onWillPop: _onBackPressed, // Handle the back press
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return Stack(
//                     children: [
//                       ListView(
//                         shrinkWrap: true,
//                         physics: ScrollPhysics(),
//                         children: [
//                           // Video player container with dynamic height
//                           SizedBox(
//                             width: double.infinity,
//                             height: videoHeight - bottomPadding, // Set dynamic height
//                             child: Center(
//                               child: Stack(
//                                 children: [
//                                   FutureBuilder(
//                                     future: _initializeVideoPlayerFuture,
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState == ConnectionState.done) {
//                                         if (_controller.value.isInitialized) {
//                                           return AspectRatio(
//                                             aspectRatio: _controller.value.aspectRatio,
//                                             child: VideoPlayer(_controller),
//                                           );
//                                         }
//                                       }
//                                       return Center(child: CircularProgressIndicator());
//                                     },
//                                   ),
//                                   Positioned.fill(
//                                     child: Center(
//                                       child: _buildPlayPauseControls(),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 10,
//                                     right: 10,
//                                     child: IconButton(
//                                       icon: Icon(Icons.fullscreen, color: Colors.white),
//                                       onPressed: _toggleFullscreen,
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 10,
//                                     left: 16,
//                                     right: 16,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             _formatTime(_currentPosition),
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                           Expanded(
//                                             child: Slider(
//                                               value: _currentPosition,
//                                               min: 0.0,
//                                               max: _videoDuration,
//                                               onChanged: (double value) {
//                                                 setState(() {
//                                                   _controller.seekTo(Duration(seconds: value.toInt()));
//                                                   _currentPosition = value;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           Text(
//                                             _formatTime(_videoDuration),
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
//                       if (provider.isCategoryVisible) SlidingCategory(
//                         isExpanded: provider.isCategoryVisible,
//                         onToggleExpansion: provider.toggleSlidingCategory,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPlayPauseControls() {
//     return IconButton(
//       icon: Icon(
//         _isPlaying ? Icons.pause : Icons.play_arrow,
//         size: 50,
//         color: Colors.white,
//       ),
//       onPressed: () {
//         setState(() {
//           if (_isPlaying) {
//             _controller.pause();
//           } else {
//             _controller.play();
//           }
//           _isPlaying = !_isPlaying;
//         });
//       },
//     );
//   }
// }

// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/providers/MasterAllProvider.dart';

// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';

// class Video {
//   final String url;
//   final String thumbnail;
//   final String title;
//   final String subtitle;
//   final String description;

//   Video({
//     required this.url,
//     required this.thumbnail,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//   });
// }

// class VideoScreen extends StatefulWidget {
//   static const String route = "/videoscreen";

//   final String video;
//   final String videoSlug;

//   const VideoScreen({super.key, required this.video, required this.videoSlug});

//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isFullscreen = false;
//   Video _currentVideo = Video(
//     url: '',
//     thumbnail: '',
//     title: '',
//     subtitle: '',
//     description: '',
//   );

//   bool _isPlaying = false;
//   double _currentPosition = 0.0;
//   double _videoDuration = 0.0;

//   Map<String, double> videoProgressMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _currentVideo = Video(url: widget.video, thumbnail: '', title: '', subtitle: '', description: '');
//     _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final providerSubscription =
//           Provider.of<LandingScreenProvider>(context, listen: false);

//       if (!providerSubscription.isSubscriptionLoading) {
//         providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI(courseslug: widget.videoSlug);
//       }

//       final providermaster = Provider.of<MasterAllProvider>(context, listen: false);
//       if (!providermaster.isLoading) {
//         providermaster.getTrendingMasterAPI();
//         providermaster.getTrendingClassAPI();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _initializeController(String videoUrl) async {
//     _controller = VideoPlayerController.network(videoUrl)
//       ..setLooping(true)
//       ..initialize().then((_) {
//         setState(() {
//           _videoDuration = _controller.value.duration.inSeconds.toDouble();
//           _currentPosition = videoProgressMap[videoUrl] ?? 0.0;
//           _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
//         });
//       });

//     _controller.addListener(_videoPlayerListener);
//     return _controller.initialize();
//   }

//   void _videoPlayerListener() {
//     if (_controller.value.isInitialized && _controller.value.isPlaying) {
//       setState(() {
//         _currentPosition = _controller.value.position.inSeconds.toDouble();
//       });
//       videoProgressMap[_currentVideo.url] = _currentPosition;
//     }
//   }

//   void _changeVideo(Video video) {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//       setState(() {
//         _isPlaying = false;
//       });
//     }

//     videoProgressMap[_currentVideo.url] = _currentPosition;

//     setState(() {
//       _currentVideo = video;
//       _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
//       _isPlaying = false;
//     });

//     _controller.play();
//     setState(() {
//       _isPlaying = true;
//     });
//   }

//   String _formatTime(double seconds) {
//     int hours = (seconds / 3600).floor();  // Calculate hours
//     int mins = ((seconds % 3600) / 60).floor();  // Calculate minutes
//     int secs = (seconds % 60).toInt();  // Calculate seconds

//     return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   Future<bool> _onBackPressed() async {
//     if (_isFullscreen) {
//       setState(() {
//         _isFullscreen = false;  // Exit fullscreen mode
//       });
//       return false; // Prevent default back press behavior
//     } else {
//       Navigator.pop(context, true); // The 'true' value can be used to trigger the refresh
//       return false; // Prevent default back press behavior
//     }
//   }

//   void _toggleFullscreen() {
//     setState(() {
//       _isFullscreen = !_isFullscreen;  // Toggle fullscreen state
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double bottomNavHeight = kBottomNavigationBarHeight;
//     final orientation = MediaQuery.of(context).orientation;

//     // Adjust video height based on orientation and fullscreen state
//     double videoHeight = (orientation == Orientation.portrait)
//         ? MediaQuery.of(context).size.height * 0.30  // 30% of the screen height in portrait
//         : MediaQuery.of(context).size.height; // Full screen in landscape

//     double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

//     // Adjust the video height and padding for fullscreen mode
//     if (_isFullscreen) {
//       videoHeight = MediaQuery.of(context).size.height;  // Fullscreen height
//       bottomPadding = 0.0;  // Remove bottom padding in fullscreen mode
//     }

//     return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {
//           return Scaffold(
//             appBar: _isFullscreen
//                 ? null
//                 : PreferredSize(
//                     preferredSize: const Size.fromHeight(kToolbarHeight),
//                     child: CustomAppBar(
//                       isCategoryVisible: provider.isCategoryVisible,
//                       onMenuPressed: () {
//                         provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
//                       },
//                       onCategoriesPressed: () {  
//                         provider.toggleSlidingCategory();
//                       },
//                       isContainerVisible: provider.isCategoryVisible,
//                     ),
//                   ),
//             backgroundColor: CraftColors.black18,
//             body: WillPopScope(
//               onWillPop: _onBackPressed, // Handle the back press
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return Stack(
//                     children: [
//                       ListView(
//                         shrinkWrap: true,
//                         physics: ScrollPhysics(),
//                         children: [
//                           // Video player container with dynamic height
//                           SizedBox(
//                             width: double.infinity,
//                             height: videoHeight - bottomPadding, // Set dynamic height
//                             child: Center(
//                               child: Stack(
//                                 children: [
//                                   FutureBuilder(
//                                     future: _initializeVideoPlayerFuture,
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState == ConnectionState.done) {
//                                         if (_controller.value.isInitialized) {
//                                           return AspectRatio(
//                                             aspectRatio: _controller.value.aspectRatio,
//                                             child: VideoPlayer(_controller),
//                                           );
//                                         }
//                                       }
//                                       return Center(child: CircularProgressIndicator());
//                                     },
//                                   ),
//                                   Positioned.fill(
//                                     child: Center(
//                                       child: _buildPlayPauseControls(),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 10,
//                                     right: 10,
//                                     child: IconButton(
//                                       icon: Icon(Icons.fullscreen, color: Colors.white),
//                                       onPressed: _toggleFullscreen,
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 10,
//                                     left: 16,
//                                     right: 16,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             _formatTime(_currentPosition),
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                           Expanded(
//                                             child: Slider(
//                                               value: _currentPosition,
//                                               min: 0.0,
//                                               max: _videoDuration,
//                                               onChanged: (double value) {
//                                                 setState(() {
//                                                   _controller.seekTo(Duration(seconds: value.toInt()));
//                                                   _currentPosition = value;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           Text(
//                                             _formatTime(_videoDuration),
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
//                       if (provider.isCategoryVisible) SlidingCategory(
//                         isExpanded: provider.isCategoryVisible,
//                         onToggleExpansion: provider.toggleSlidingCategory,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPlayPauseControls() {
//     return IconButton(
//       icon: Icon(
//         _isPlaying ? Icons.pause : Icons.play_arrow,
//         size: 50,
//         color: Colors.white,
//       ),
//       onPressed: () {
//         setState(() {
//           if (_isPlaying) {
//             _controller.pause();
//           } else {
//             _controller.play();
//           }
//           _isPlaying = !_isPlaying;
//         });
//       },
//     );
//   }
// }


// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/providers/MasterAllProvider.dart';

// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';

// class Video {
//   final String url;
//   final String thumbnail;
//   final String title;
//   final String subtitle;
//   final String description;

//   Video({
//     required this.url,
//     required this.thumbnail,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//   });
// }

// class VideoScreen extends StatefulWidget {
//   static const String route = "/videoscreen";

//   final String video;
//   final String videoSlug;

//   const VideoScreen({super.key, required this.video, required this.videoSlug});

//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isFullscreen = false;
//   Video _currentVideo = Video(
//     url: '',
//     thumbnail: '',
//     title: '',
//     subtitle: '',
//     description: '',
//   );

//   bool _isPlaying = false;
//   double _currentPosition = 0.0;
//   double _videoDuration = 0.0;

//   Map<String, double> videoProgressMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _currentVideo = Video(url: widget.video, thumbnail: '', title: '', subtitle: '', description: '');
//     _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final providerSubscription =
//           Provider.of<LandingScreenProvider>(context, listen: false);

//       if (!providerSubscription.isSubscriptionLoading) {
//         providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI(courseslug: widget.videoSlug);
//       }

//       final providermaster = Provider.of<MasterAllProvider>(context, listen: false);
//       if (!providermaster.isLoading) {
//         providermaster.getTrendingMasterAPI();
//         providermaster.getTrendingClassAPI();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _initializeController(String videoUrl) async {
//     _controller = VideoPlayerController.network(videoUrl)
//       ..setLooping(true)
//       ..initialize().then((_) {
//         setState(() {
//           _videoDuration = _controller.value.duration.inSeconds.toDouble();
//           _currentPosition = videoProgressMap[videoUrl] ?? 0.0;
//           _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
//         });
//       });

//     _controller.addListener(_videoPlayerListener);
//     return _controller.initialize();
//   }

//   void _videoPlayerListener() {
//     if (_controller.value.isInitialized && _controller.value.isPlaying) {
//       setState(() {
//         _currentPosition = _controller.value.position.inSeconds.toDouble();
//       });
//       videoProgressMap[_currentVideo.url] = _currentPosition;
//     }
//   }

//   void _changeVideo(Video video) {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//       setState(() {
//         _isPlaying = false;
//       });
//     }

//     videoProgressMap[_currentVideo.url] = _currentPosition;

//     setState(() {
//       _currentVideo = video;
//       _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
//       _isPlaying = false;
//     });

//     _controller.play();
//     setState(() {
//       _isPlaying = true;
//     });
//   }

//   String _formatTime(double seconds) {
//     int hours = (seconds / 3600).floor();  // Calculate hours
//     int mins = ((seconds % 3600) / 60).floor();  // Calculate minutes
//     int secs = (seconds % 60).toInt();  // Calculate seconds

//     return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   Future<bool> _onBackPressed() async {
//     if (_isFullscreen) {
//       _toggleFullscreen(); // Reset fullscreen when back is pressed
//       return false; // Prevent default back press behavior
//     } else {
//       // Pop the screen and signal the previous screen to refresh
//       Navigator.pop(context, true); // The 'true' value can be used to trigger the refresh
//       return false; // Prevent default back press behavior
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double bottomNavHeight = kBottomNavigationBarHeight;
//     final orientation = MediaQuery.of(context).orientation;

//     // Adjust video height based on orientation
//     double videoHeight = (orientation == Orientation.portrait)
//         ? MediaQuery.of(context).size.height * 0.30  // 30% of the screen height in portrait
//         : MediaQuery.of(context).size.height; // Full screen in landscape

//     double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

//     // Adjust the video height and padding for fullscreen mode
//     if (_isFullscreen) {
//       videoHeight = MediaQuery.of(context).size.height;
//       bottomPadding = 0.0;  // Remove bottom padding in fullscreen mode
//     }
//     else{
// videoHeight = (orientation == Orientation.portrait)
//         ? MediaQuery.of(context).size.height * 0.30  // 30% of the screen height in portrait
//         : MediaQuery.of(context).size.height;
//         bottomPadding = MediaQuery.of(context).viewInsets.bottom;
//     }

//     return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {
//           return Scaffold(
//             appBar: _isFullscreen
//                 ? null
//                 : PreferredSize(
//                     preferredSize: const Size.fromHeight(kToolbarHeight),
//                     child: CustomAppBar(
//                       isCategoryVisible: provider.isCategoryVisible,
//                       onMenuPressed: () {
//                         provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
//                       },
//                       onCategoriesPressed: () {  
//                         provider.toggleSlidingCategory();
//                       },
//                       isContainerVisible: provider.isCategoryVisible,
//                     ),
//                   ),
//             backgroundColor: CraftColors.black18,
//             body: WillPopScope(
//               onWillPop: _onBackPressed, // Handle the back press
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return Stack(
//                     children: [
//                       ListView(
//                         shrinkWrap: true,
//                         physics: ScrollPhysics(),
//                         children: [
//                           // Video player container with dynamic height
//                           SizedBox(
//                             width: double.infinity,
//                             height: videoHeight - bottomPadding, // Set dynamic height
//                             child: Center(
//                               child: Stack(
//                                 children: [
//                                   FutureBuilder(
//                                     future: _initializeVideoPlayerFuture,
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState == ConnectionState.done) {
//                                         if (_controller.value.isInitialized) {
//                                           return AspectRatio(
//                                             aspectRatio: _controller.value.aspectRatio,
//                                             child: VideoPlayer(_controller),
//                                           );
//                                         }
//                                       }
//                                       return Center(child: CircularProgressIndicator());
//                                     },
//                                   ),
//                                   Positioned.fill(
//                                     child: Center(
//                                       child: _buildPlayPauseControls(),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 10,
//                                     right: 10,
//                                     child: IconButton(
//                                       icon: Icon(Icons.fullscreen, color: Colors.white),
//                                       onPressed: _toggleFullscreen,
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 10,
//                                     left: 16,
//                                     right: 16,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             _formatTime(_currentPosition),
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                           Expanded(
//                                             child: Slider(
//                                               value: _currentPosition,
//                                               min: 0.0,
//                                               max: _videoDuration,
//                                               onChanged: (double value) {
//                                                 setState(() {
//                                                   _controller.seekTo(Duration(seconds: value.toInt()));
//                                                   _currentPosition = value;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           Text(
//                                             _formatTime(_videoDuration),
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
//                       if (provider.isCategoryVisible) SlidingCategory(
//                         isExpanded: provider.isCategoryVisible,
//                         onToggleExpansion: provider.toggleSlidingCategory,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPlayPauseControls() {
//     return IconButton(
//       icon: Icon(
//         _isPlaying ? Icons.pause : Icons.play_arrow,
//         size: 50,
//         color: Colors.white,
//       ),
//       onPressed: () {
//         setState(() {
//           if (_isPlaying) {
//             _controller.pause();
//           } else {
//             _controller.play();
//           }
//           _isPlaying = !_isPlaying;
//         });
//       },
//     );
//   }

// void _toggleFullscreen() {
//   setState(() {
//     _isFullscreen = !_isFullscreen; // Toggle fullscreen mode
//   });

//   if (_isFullscreen) {
//     // Enter fullscreen mode
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
//   } else {
//     // Exit fullscreen mode
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

//     // Ensure the layout is updated without a forced delay
//  WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {
//         // Any layout changes you need to trigger can go here
//       });
//     });
//   }
// }

// }

//old
// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/providers/MasterAllProvider.dart';
// import 'package:craft_school/utils/craft_styles.dart';
// import 'package:craft_school/widgets/ProgressBar.dart';
// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';

// class Video {
//   final String url;
//   final String thumbnail;
//   final String title;
//   final String subtitle;
//   final String description;

//   Video({
//     required this.url,
//     required this.thumbnail,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//   });
// }

// class VideoScreen extends StatefulWidget {
//   static const String route = "/videoscreen";

//  final String video;

//   const VideoScreen({super.key, required this.video});

//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isFullscreen = false;
//   Video _currentVideo = Video(
//     url: '',
//     thumbnail: '',
//     title: '',
//     subtitle: '',
//     description: '',
//   );

//   bool _isPlaying = false;
//   double _currentPosition = 0.0;
//   double _videoDuration = 0.0;

//   Map<String, double> videoProgressMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _currentVideo = Video(url: widget.video, thumbnail: '', title: '', subtitle: '', description: ''); // Set initial video to the first one
//     _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
  
  
//  WidgetsBinding.instance.addPostFrameCallback((_) {
//     final providerSubscription =
//           Provider.of<LandingScreenProvider>(context, listen: false);

//       if (!providerSubscription.isSubscriptionLoading) {
//         providerSubscription
//             .getcheckSubscriptionIndividualFlowWiseInfoAPI();
//       }
//        final providermaster = Provider.of<MasterAllProvider>(context, listen: false);
//       if (!providermaster.isLoading) {
//        print("Mycoursese");
//          providermaster.getTrendingMasterAPI();
//          providermaster.getTrendingClassAPI();
  
//       }  
//     });

//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }


//   Future<void> _initializeController(String videoUrl) async {
//     _controller = VideoPlayerController.network(videoUrl)
//       ..setLooping(true)
//       ..initialize().then((_) {
//         setState(() {
//           _videoDuration = _controller.value.duration.inSeconds.toDouble();
//           _currentPosition = videoProgressMap[videoUrl] ?? 0.0;
//           _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
//         });
//       });

//     _controller.addListener(_videoPlayerListener);
//     return _controller.initialize();
//   }

//   void _videoPlayerListener() {
//     if (_controller.value.isInitialized && _controller.value.isPlaying) {
//       setState(() {
//         _currentPosition = _controller.value.position.inSeconds.toDouble();
//       });
//       videoProgressMap[_currentVideo.url] = _currentPosition;
//     }
//   }

//   void _changeVideo(Video video) {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//       setState(() {
//         _isPlaying = false;
//       });
//     }

//     videoProgressMap[_currentVideo.url] = _currentPosition;

//     setState(() {
//       _currentVideo = video;
//       _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
//       _isPlaying = false;
//     });

//     _controller.play();
//     setState(() {
//       _isPlaying = true;
//     });
//   }

//   String _formatTime(double seconds) {
//     int mins = (seconds / 60).floor();
//     int secs = (seconds % 60).toInt();
//     return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   Future<bool> _onBackPressed() async {
//     if (_isFullscreen) {
//       _toggleFullscreen(); // Reset fullscreen when back is pressed
//       return false; // Prevent default back press behavior
//     }
//     return true; // Allow default back press behavior
//   }

// @override
// Widget build(BuildContext context) {
//   final double bottomNavHeight = kBottomNavigationBarHeight;
//   final orientation = MediaQuery.of(context).orientation;

//   // Adjust video height based on orientation
//   double videoHeight = (orientation == Orientation.portrait)
//       ? MediaQuery.of(context).size.height * 0.30  // 30% of the screen height in portrait
//       : MediaQuery.of(context).size.height; // Full screen in landscape

//   double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

//   return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {return Scaffold(
//     appBar: PreferredSize(
//               preferredSize: const Size.fromHeight(kToolbarHeight),
//               child: CustomAppBar(
//                 isCategoryVisible: provider.isCategoryVisible,
//                 onMenuPressed: () {
//                   provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
//                 },
//                    onCategoriesPressed: () {  provider.toggleSlidingCategory();}, isContainerVisible: provider.isCategoryVisible,
//               ),
//             ),
//     backgroundColor: CraftColors.black18,
//     body: WillPopScope(
//       onWillPop: _onBackPressed, // Handle the back press
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           // Adjust the video height based on orientation
//           videoHeight = (orientation == Orientation.portrait)
//               ? MediaQuery.of(context).size.height * 0.30 // 30% in portrait mode
//               :MediaQuery.of(context).size.height; //constraints.maxHeight - MediaQuery.of(context).padding.top - bottomNavHeight;

//           return Stack(
//             children: [
//               SafeArea(
//                 child: ListView(
//                   shrinkWrap: true,
//                   physics: ScrollPhysics(),
//                   children: [
//                     // Video player container with dynamic height
//                    SizedBox(
//                      width: double.infinity,
//                      height: videoHeight - bottomPadding, // Set dynamic height
//                      child: Center(
//                                    child: Stack(
//                                      children: [
//                                        FutureBuilder(
//                                          future: _initializeVideoPlayerFuture,
//                                          builder: (context, snapshot) {
//                                            if (snapshot.connectionState == ConnectionState.done) {
//                                              if (_controller.value.isInitialized) {
//                                                return AspectRatio(
//                                                  aspectRatio: _controller.value.aspectRatio,
//                                                  child: VideoPlayer(_controller),
//                                                );
//                                              }
//                                            }
//                                            return Center(child: CircularProgressIndicator());
//                                          },
//                                        ),
//                                        Positioned.fill(
//                                          child: Center(
//                                            child: _buildPlayPauseControls(),
//                                          ),
//                                        ),
//                                        Positioned(
//                                          top: 10,
//                                          right: 10,
//                                          child: IconButton(
//                                            icon: Icon(Icons.fullscreen, color: Colors.white),
//                                            onPressed: _toggleFullscreen,
//                                          ),
//                                        ),
//                                        Positioned(
//                                          bottom: 10,
//                                          left: 16,
//                                          right: 16,
//                                          child: Padding(
//                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                            child: Row(
//                                              children: [
//                                                Text(
//                                                  _formatTime(_currentPosition),
//                                                  style: TextStyle(color: Colors.white),
//                                                ),
//                                                Expanded(
//                                                  child: Slider(
//                                                    value: _currentPosition,
//                                                    min: 0.0,
//                                                    max: _videoDuration,
//                                                    onChanged: (double value) {
//                     setState(() {
//                       _controller.seekTo(Duration(seconds: value.toInt()));
//                       _currentPosition = value;
//                     });
//                                                    },
//                                                  ),
//                                                ),
//                                                Text(
//                                                  _formatTime(_videoDuration),
//                                                  style: TextStyle(color: Colors.white),
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                      ),
//                    ),
                   
                   
//                   ],
//                 ),
//               ),
//                 if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
//               if (provider.isCategoryVisible) SlidingCategory(
//                 isExpanded: provider.isCategoryVisible,
//                 onToggleExpansion: provider.toggleSlidingCategory,
//               ),
//             ],
//           );
//         },
//       ),
//     ),
//   );
//         }));
// }

// Widget _buildSeekBar(Video video) {
//   double progress = videoProgressMap[video.url] ?? 0.0;  // Current video position
//   double percentage = (_videoDuration > 0) ? (progress / _videoDuration) * 100 : 0;  // Calculate percentage completed, ensuring no division by zero

//   // Determine label text based on the progress percentage
//   String statusLabel;
//   if (percentage == 0) {
//     statusLabel = 'Not Started';
//   } else if (percentage == 100) {
//     statusLabel = 'Completed';
//   } else {
//     statusLabel = 'In Progress';
//   }
//   print("progress");
// print(progress);
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 0.0),
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               statusLabel, // Display the dynamic status label
//               style:CraftStyles.tsWhiteNeutral300W400,
//             ),
//             Text(
//               '${percentage.toStringAsFixed(1)}%', 
//               style: TextStyle(color: Colors.white, fontSize: 14),
//             ),
//           ],
//         ),
//         SizedBox(height: 5), // Space between labels and progress bar
//      (progress != null && _videoDuration > 0)
//             ? ProgressBar(
//                 currentPosition: progress,
//                 duration: _videoDuration, // Total video duration
//               )
//             : Container(),
//       ],
//     ),
//   );
// }



//   // Widget _buildSeekBar(Video video) {
//   //   double progress = videoProgressMap[video.url] ?? 0.0;
//   //   return Row(
//   //     children: [
        
//   //       Slider(
//   //         value: progress,
//   //         min: 0.0,
//   //         max: _videoDuration,
//   //         onChanged: (double value) {
//   //           setState(() {
//   //             _controller.seekTo(Duration(seconds: value.toInt()));
//   //             videoProgressMap[video.url] = value;
//   //           });
//   //         },
//   //       ),
        
//   //     ],
//   //   );
//   // }

//   Widget _buildPlayPauseControls() {
//     return IconButton(
//       icon: Icon(
//         _isPlaying ? Icons.pause : Icons.play_arrow,
//         size: 50,
//         color: Colors.white,
//       ),
//       onPressed: () {
//         setState(() {
//           if (_isPlaying) {
//             _controller.pause();
//           } else {
//             _controller.play();
//           }
//           _isPlaying = !_isPlaying;
//         });
//       },
//     );
//   }

// void _toggleFullscreen() {
//   setState(() {
//     _isFullscreen = !_isFullscreen;
//   });

//   if (_isFullscreen) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
//   } else {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

//     // Add a delay to allow for layout changes to complete
//     Future.delayed(Duration(milliseconds: 100), () {
//       setState(() {});
//     });
//   }
// }

// }