import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_colors.dart';

class SlantedImageReel extends StatefulWidget {
  @override
  _SlantedImageReelState createState() => _SlantedImageReelState();
}

class _SlantedImageReelState extends State<SlantedImageReel> {
  List<String> images = [
    CraftImagePath.image1,
    CraftImagePath.image2,
    CraftImagePath.image3,
    CraftImagePath.image4,
    CraftImagePath.image5,
    CraftImagePath.image6,
  ];

  final int rows = 3;
  final double imageSize = 80.0;
  final double rowSpacing = 20.0;
  final double slantAngle = -0.10;

  List<ScrollController> controllers = [];
  List<double> speeds = [];

  @override
  void initState() {
    super.initState();
    _initializeScrolling();
  }

  void _initializeScrolling() {
    for (int i = 0; i < rows; i++) {
      controllers.add(ScrollController());
      speeds.add(i % 2 == 0 ? 50 : -50);
      _autoScrollRow(i);
    }
  }

  void _autoScrollRow(int index) {
    Future.delayed(Duration(milliseconds: 1000), () async {
      while (mounted) {
        if (controllers[index].hasClients) {
          double maxScroll = controllers[index].position.maxScrollExtent;
          double minScroll = 0;
          double targetScroll = speeds[index] > 0 ? maxScroll : minScroll;

          await controllers[index].animateTo(
            targetScroll,
            duration: Duration(seconds: 20),
            curve: Curves.linear,
          );
          controllers[index].jumpTo(speeds[index] > 0 ? minScroll : maxScroll);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(rows, (rowIndex) {
          return Container(
            height: imageSize + 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: CraftColors.neutralBlue850,
            ),
            child: ClipRect( // ✅ Ensures images stay inside
              child: Transform.rotate(
                angle: slantAngle,
                child: ListView.builder(
                  controller: controllers[rowIndex],
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: images.length * 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      
                      child: ClipRRect( // ✅ Prevents image corners from sticking out
                        borderRadius: BorderRadius.circular(0),
                        child: Container(
                          width: imageSize,
                          height: imageSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(images[index % images.length]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

// import 'dart:async';
// import 'dart:math';
// import 'package:craft_school/dto/MasterListResponse.dart';
// import 'package:craft_school/providers/MasterAllProvider.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:craft_school/utils/craft_images.dart';
// import 'package:provider/provider.dart';

// class SlantedImageReel extends StatefulWidget {
//   @override
//   _SlantedImageReelState createState() => _SlantedImageReelState();
// }

// class _SlantedImageReelState extends State<SlantedImageReel> {
  
//   List<String> images = [
//     CraftImagePath.image1,
//     CraftImagePath.image2,
//     CraftImagePath.image3,
//     CraftImagePath.image4,
//     CraftImagePath.image5,
//     CraftImagePath.image6,
//   ];

// final int rows = 3; // Number of rows
//   final double imageSize = 100.0; // Image size
//   final double rowSpacing = 20.0; // Space between rows
//   final double slantAngle = -0.10; // Angle for the entire row


//   List<ScrollController> controllers = [];
//   List<double> speeds = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeScrolling();
//   }

//   void _initializeScrolling() {
//     for (int i = 0; i < rows; i++) {
//       controllers.add(ScrollController());
//       speeds.add(i % 2 == 0 ? 50 : -50); // Alternate scrolling direction
//       _autoScrollRow(i);
//     }
//   }

//   void _autoScrollRow(int index) {
//     Future.delayed(Duration(milliseconds: 1000), () async {
//       while (mounted) {
//         if (controllers[index].hasClients) {
//           double maxScroll = controllers[index].position.maxScrollExtent;
//           double minScroll = 0;
//           double targetScroll = speeds[index] > 0 ? maxScroll : minScroll;

//           await controllers[index].animateTo(
//             targetScroll,
//             duration: Duration(seconds: 20), // Adjust speed here
//             curve: Curves.linear,
//           );
//           controllers[index].jumpTo(speeds[index] > 0 ? minScroll : maxScroll); // Reset seamlessly
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(rows, (rowIndex) {
//           return Container(
//             height: imageSize + 20, // Adjust row height
//             decoration: BoxDecoration(
//               color: CraftColors.secondary550 , // Background for better contrast
//               // borderRadius: BorderRadius.circular(20),
//             ),
//             child: Transform.rotate(
//               angle: slantAngle, // Slant the entire row
//               child: ListView.builder(
//                 controller: controllers[rowIndex],
//                 scrollDirection: Axis.horizontal,
//                 physics: NeverScrollableScrollPhysics(), // Prevent manual scrolling
//                 itemCount: images.length * 2, // Duplicate images for seamless effect
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                     child: Container(
//                       width: imageSize,
//                       height: imageSize,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         image: DecorationImage(
//                           image: AssetImage(images[index % images.length]),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// //   final ScrollController _scrollController = ScrollController();
// //   late Timer _timer;


// //   @override
// //   void initState() {
// //     super.initState();
// //  final provider = Provider.of<MasterAllProvider>(context, listen: false);
// //       if (!provider.isLoading) {
// //         provider.getMasterAllAPI();
       
       
// //       }
   
// //     _startAutoScroll();
// //   }

// //   void _startAutoScroll() {
// //     _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
// //       if (_scrollController.hasClients) {
// //         _scrollController.animateTo(
// //           _scrollController.offset + 2, // Moves right continuously
// //           duration: Duration(milliseconds: 50),
// //           curve: Curves.linear,
// //         );
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _timer.cancel();
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double screenWidth = MediaQuery.of(context).size.width;
// //     double gridHeight = MediaQuery.of(context).size.height * 0.3;

// //     return    Consumer<MasterAllProvider>(
// //                 builder: (context, provider, child) {return SizedBox(
// //       height: gridHeight,
// //       width: screenWidth, // Full width
// //       child: GridView.builder(
// //         controller: _scrollController,
// //         scrollDirection: Axis.horizontal, // Scroll in horizontal direction
// //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
// //           maxCrossAxisExtent: 120, // Controls height of each image
// //           mainAxisSpacing: 10,
// //           crossAxisSpacing: 17,
// //           childAspectRatio: 1, // Square items
// //         ),
// //         itemCount: provider.masterAllData.length * 1000, // Infinite effect
// //         itemBuilder: (context, index) {
// //           return _buildSlantedImage(provider.masterAllData[index % provider.masterAllData.length]);
// //         },
// //       ),
// //     );
// //                 });
// //   }

// //   Widget _buildSlantedImage(Datum imagePath) {
// //     return Transform.rotate(
// //       angle: -0.15,
// //       child: Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(12),
// //           image: DecorationImage(
// //             image: NetworkImage(imagePath.masterImage),
// //             fit: BoxFit.cover,
// //           ),
// //           boxShadow: [
// //             BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// }
