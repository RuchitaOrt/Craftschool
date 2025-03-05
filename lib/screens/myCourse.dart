import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/ProgressBar.dart';
import 'package:craft_school/widgets/TrendingSkill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final List<Video> videos = [
    Video(
      url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnail: 'https://fastly.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s',
      title: 'Big Buck Bunny',
      subtitle: 'By Blender Foundation',
      description: 'Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself...',
    ),
    Video(
      url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      thumbnail: 'https://fastly.picsum.photos/id/22/4434/3729.jpg?hmac=fjZdkSMZJNFgsoDh8Qo5zdA_nSGUAWvKLyyqmEt2xs0',
      title: 'Elephant Dream',
      subtitle: 'By Blender Foundation',
      description: 'The first Blender Open Movie from 2006...',
    ),
    Video(
      url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      thumbnail: 'https://fastly.picsum.photos/id/27/3264/1836.jpg?hmac=p3BVIgKKQpHhfGRRCbsi2MCAzw8mWBCayBsKxxtWO8g',
      title: 'Sintel',
      subtitle: 'By Blender Foundation',
      description: 'Sintel is an independently produced short film...',
    ),
    Video(
      url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
      thumbnail: 'https://fastly.picsum.photos/id/7/4728/3168.jpg?hmac=c5B5tfYFM9blHHMhuu4UKmhnbZoJqrzNOP9xjkV4w3o',
      title: 'Tears of Steel',
      subtitle: 'By Blender Foundation',
      description: 'Tears of Steel was realized with crowd-funding...',
    ),
  ];

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
 List<String> _imagePaths = [
    CraftImagePath.image1,
    CraftImagePath.image2,
    CraftImagePath.image3,
    CraftImagePath.image1,
  ];
  bool _isPlaying = false;
  double _currentPosition = 0.0;
  double _videoDuration = 0.0;

  Map<String, double> videoProgressMap = {};

  @override
  void initState() {
    super.initState();
    _currentVideo = widget.videos[0]; // Set initial video to the first one
    _initializeVideoPlayerFuture = _initializeController(_currentVideo.url);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  void _videoPlayerListener() {
    if (_controller.value.isInitialized && _controller.value.isPlaying) {
      setState(() {
        _currentPosition = _controller.value.position.inSeconds.toDouble();
      });
      videoProgressMap[_currentVideo.url] = _currentPosition;
    }
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
    int mins = (seconds / 60).floor();
    int secs = (seconds % 60).toInt();
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<bool> _onBackPressed() async {
    if (_isFullscreen) {
      _toggleFullscreen(); // Reset fullscreen when back is pressed
      return false; // Prevent default back press behavior
    }
    return true; // Allow default back press behavior
  }

@override
Widget build(BuildContext context) {
  final double bottomNavHeight = kBottomNavigationBarHeight;
  final orientation = MediaQuery.of(context).orientation;

  // Adjust video height based on orientation
  double videoHeight = (orientation == Orientation.portrait)
      ? MediaQuery.of(context).size.height * 0.30  // 30% of the screen height in portrait
      : MediaQuery.of(context).size.height; // Full screen in landscape

  double bottomPadding = MediaQuery.of(context).viewInsets.bottom;

  return Scaffold(
    appBar: _isFullscreen
        ? null
        : PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
               isCategoryVisible: false,
              onMenuPressed: () {},
                 onCategoriesPressed: () {  }, isContainerVisible: false,
            ),
          ),
    backgroundColor: CraftColors.black18,
    body: WillPopScope(
      onWillPop: _onBackPressed, // Handle the back press
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust the video height based on orientation
          videoHeight = (orientation == Orientation.portrait)
              ? MediaQuery.of(context).size.height * 0.30 // 30% in portrait mode
              :MediaQuery.of(context).size.height; //constraints.maxHeight - MediaQuery.of(context).padding.top - bottomNavHeight;

          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                // Video player container with dynamic height
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: videoHeight - bottomPadding, // Set dynamic height
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
                                      value: _currentPosition,
                                      min: 0.0,
                                      max: _videoDuration,
                                      onChanged: (double value) {
                                        setState(() {
                                          _controller.seekTo(Duration(seconds: value.toInt()));
                                          _currentPosition = value;
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
                ),
                if (!_isFullscreen)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          CraftStrings.strMyCourses,
                          style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                if (!_isFullscreen)
                  Container(
                    height: SizeConfig.blockSizeVertical * 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.videos.length,
                      itemBuilder: (context, index) {
                        final video = widget.videos[index];
                        return Card(
                          color: CraftColors.neutralBlue850,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 50,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: CraftColors.neutralBlue800,
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        image: DecorationImage(image: NetworkImage(video.thumbnail), fit: BoxFit.cover),
                                      ),
                                      height: SizeConfig.blockSizeVertical * 28,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.play_arrow, color: Colors.black),
                                      onPressed: () => _changeVideo(video),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 1,
                                      ),
                                      _buildSeekBar(video),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 1,
                                      ),
                                      Text(
                                        video.title,
                                        style: CraftStyles.tsWhiteNeutral50W600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16.0,
                                            backgroundImage: AssetImage(CraftImagePath.image3),
                                          ),
                                          SizedBox(
                                            width: SizeConfig.blockSizeHorizontal * 2,
                                          ),
                                          Container(
                                            width: SizeConfig.blockSizeHorizontal * 32,
                                            child: Text(
                                              "Komal Nahata",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 12),
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
                        );
                      },
                    ),
                  ),
                if (!_isFullscreen)
                  TrendingSkill(
                    imagePaths: _imagePaths,
                    title: CraftStrings.strtrendingSkills,
                    onPressed: () {},
                  ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget _buildSeekBar(Video video) {
  double progress = videoProgressMap[video.url] ?? 0.0;  // Current video position
  double percentage = (_videoDuration > 0) ? (progress / _videoDuration) * 100 : 0;  // Calculate percentage completed, ensuring no division by zero

  // Determine label text based on the progress percentage
  String statusLabel;
  if (percentage == 0) {
    statusLabel = 'Not Started';
  } else if (percentage == 100) {
    statusLabel = 'Completed';
  } else {
    statusLabel = 'In Progress';
  }
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
              style:CraftStyles.tsWhiteNeutral300W400,
            ),
            Text(
              '${percentage.toStringAsFixed(1)}%', 
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 5), // Space between labels and progress bar
     (progress != null && _videoDuration > 0)
            ? ProgressBar(
                currentPosition: progress,
                duration: _videoDuration, // Total video duration
              )
            : Container(),
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  } else {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Add a delay to allow for layout changes to complete
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {});
    });
  }
}

}


// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/sizeConfig.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';  // Import this for SystemChrome
// import 'package:video_player/video_player.dart';

// class VideoListScreen extends StatelessWidget {
//   static const String route = "/videoListscreen";

//   // List of video URLs (could be from a server, or any video URL)
//   final List<String> videoLinks = [
//     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
//     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
//     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
//     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar: PreferredSize(
//               preferredSize: const Size.fromHeight(kToolbarHeight),
//               child: CustomAppBar(
//                 onMenuPressed: () {
//                   // provider.toggleSlidingContainer(); // Trigger toggle when menu is pressed
//                 },
//               ),
//             ),
//             backgroundColor: CraftColors.black18,
//       body: ListView.builder(
//         itemCount: videoLinks.length,
//         itemBuilder: (context, index) {
//           final videoLink = videoLinks[index];

//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text('Video ${index + 1}'),
//               subtitle: Text(videoLink),
//               trailing: Icon(Icons.play_arrow),
//               onTap: () {
//                 // Navigate to the video player screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => VideoPlayerScreen(videoUrl: videoLink),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;

//   VideoPlayerScreen({required this.videoUrl});

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isFullscreen = false;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the video player with the URL passed
//     _controller = VideoPlayerController.network(widget.videoUrl);

//     // Initialize the controller and video player
//     _initializeVideoPlayerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose(); // Dispose of the controller when done
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_isFullscreen) {
//           // Handle the back button press in fullscreen mode
//           _toggleFullscreen(); // Reset to portrait mode and show system UI
//         }
//         return true;  // Allow the pop action
//       },
//       child: Scaffold(
//         backgroundColor: CraftColors.black18,
//         body: Container(
//           child: Center(
//             child: Stack(
//               children: [
//                 // Video Player
//                 FutureBuilder(
//                   future: _initializeVideoPlayerFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       return AspectRatio(
//                         aspectRatio: _controller.value.aspectRatio,
//                         child: VideoPlayer(_controller),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error loading video'));
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),
//                 // Controls (Seekbar, Play/Pause and Fullscreen Button)
//                 Positioned(
//                   bottom: 20,  // Adjust this to position your controls as needed
//                   left: 0,
//                   right: 0,
//                   child: Column(
//                     children: [
//                       _buildSeekBar(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSeekBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           _buildPlayPauseControls(),
//           Expanded(
//             child: Slider(
//               value: _controller.value.position.inSeconds.toDouble(),
//               min: 0.0,
//               max: _controller.value.duration.inSeconds.toDouble(),
//               onChanged: (double value) {
//                 setState(() {
//                   _controller.seekTo(Duration(seconds: value.toInt()));
//                 });
//               },
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.fullscreen),
//             onPressed: _toggleFullscreen,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPlayPauseControls() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//           onPressed: () {
//             setState(() {
//               if (_controller.value.isPlaying) {
//                 _controller.pause();
//               } else {
//                 _controller.play();
//               }
//             });
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.volume_up),
//           onPressed: () {
//             // Handle volume control here (this can be implemented with a volume package)
//           },
//         ),
//       ],
//     );
//   }

//   // Toggle fullscreen
//   void _toggleFullscreen() {
//     setState(() {
//       _isFullscreen = !_isFullscreen;
//     });

//     if (_isFullscreen) {
//       // Hide system UI and force landscape orientation
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//       SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
//     } else {
//       // Restore system UI and portrait orientation
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//       SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     }
//   }
// }
