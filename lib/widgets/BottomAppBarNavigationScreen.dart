import 'dart:io';
import 'package:craft_school/screens/AllCourses.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/screens/blog_screen.dart';
import 'package:craft_school/screens/myCourse.dart';
import 'package:craft_school/screens/service.dart';
import 'package:craft_school/screens/settings.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomAppBarWidget extends StatefulWidget {
  final int index;
  const BottomAppBarWidget({super.key, required this.index});

  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  int _selectedIndex = 0;

  final List<String> _tabTitles = [
    'My Courses',
    'Courses',
    'Community',
    'My Space',
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  void _onTabSelected(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      await Navigator.of(context).pushNamed(MyCourseScreen.route);
    } else if (index == 1) {
      await Navigator.of(context).pushNamed(AllCourses.route);
    } else if (index == 2) {
      await Navigator.of(context).pushNamed(PostScreen.route);
    } else if (index == 3) {
      await Navigator.of(context).pushNamed(Settings.route);
    }
    // ❗️ Don't reset the index here! Just keep last selected tab.
  }

  @override
  Widget build(BuildContext context) {
    double bottomAppBarHeight = Platform.isAndroid
        ? SizeConfig.blockSizeVertical * 9
        : SizeConfig.blockSizeVertical * 12;

    return Container(
      height: bottomAppBarHeight,
      decoration: BoxDecoration(
        color: CraftColors.neutralBlue800,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabIcon(CraftImagePath.courses, _tabTitles[0], 0),
            _buildTabIcon(CraftImagePath.services, _tabTitles[1], 1),
            const SizedBox(width: 20),
            _buildTabIcon(CraftImagePath.blogs, _tabTitles[2], 2),
            _buildTabIcon(CraftImagePath.myspace, _tabTitles[3], 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon(String icon, String title, int index) {
    return Flexible(
      child: GestureDetector(
        onTap: () => _onTabSelected(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 18,
              height: 18,
              color: _selectedIndex == index ? Colors.white : Colors.grey,
            ),
            Text(
              title,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.white : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'package:craft_school/screens/PostScreen.dart';
// import 'package:craft_school/screens/blog_screen.dart';
// import 'package:craft_school/screens/myCourse.dart';
// import 'package:craft_school/screens/service.dart';
// import 'package:craft_school/screens/settings.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/craft_images.dart';
// import 'package:craft_school/utils/sizeConfig.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class BottomAppBarWidget extends StatefulWidget {
//   final int index;
//   const BottomAppBarWidget({super.key, required this.index});

//   @override
//   _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
// }

// class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.index;
//   }

//   final List<String> _tabTitles = [
//     'My Courses',
//     'Services',
//     'Blog',
//     'My Space',
//   ];

//   // Function to handle tab selection
//   // void _onTabSelected(int index) {
//   //   setState(() {
//   //     _selectedIndex = index; // Update selected tab index
//   //   });

//   //   // Navigate based on the selected index
//   //   if (_selectedIndex == 0) {
//   //     Navigator.of(context).pushNamed(MyCourseScreen.route).then((value) {
//   //       setState(() {
//   //         _selectedIndex = 0; // Ensure the correct tab is highlighted
//   //       });
//   //     });
//   //   } else if (_selectedIndex == 2) {
//   //     Navigator.of(context).pushNamed(BlogsScreen.route).then((value) {
//   //       setState(() {
//   //         _selectedIndex = 2; // Ensure the Blog tab is highlighted
//   //       });
//   //     });
//   //   } else if (_selectedIndex == 1) {
//   //     Navigator.of(context)
//   //         .pushNamed(AspiringTrainingScreen.route)
//   //         .then((value) {
//   //       setState(() {
//   //         _selectedIndex = 1; // Ensure the Services tab is highlighted
//   //       });
//   //     });
//   //   } else if (_selectedIndex == 3) {
//   //     Navigator.of(context).pushNamed(Settings.route).then((value) {});
//   //   }
//   // }
// void _onTabSelected(int index) {
//   setState(() {
//     _selectedIndex = index;
//   });

//   if (index == 0) {
//     Navigator.of(context).pushNamed(MyCourseScreen.route);
//   } else if (index == 1) {
//     Navigator.of(context).pushNamed(AspiringTrainingScreen.route);
//   } else if (index == 2) {
//     Navigator.of(context).pushNamed(BlogsScreen.route);
//   } else if (index == 3) {
//     Navigator.of(context).pushNamed(Settings.route);
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     double bottomAppBarHeight = Platform.isAndroid
//         ? SizeConfig.blockSizeVertical * 9
//         : SizeConfig.blockSizeVertical * 12;

//     return Container(
//       height: bottomAppBarHeight, // Adjust the height based on platform
//       decoration: BoxDecoration(
//         color: CraftColors.neutralBlue800,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: BottomAppBar(
//         elevation: 0,
//         color: Colors.transparent,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildTabIcon(CraftImagePath.courses, _tabTitles[0], 0),
//             _buildTabIcon(CraftImagePath.services, _tabTitles[1], 1),
//             const SizedBox(
//                 width: 20), // Space for the Floating Action Button (FAB)
//             _buildTabIcon(CraftImagePath.blogs, _tabTitles[2], 2),
//             _buildTabIcon(CraftImagePath.myspace, _tabTitles[3], 3),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper function to build a tab icon with text
//   Widget _buildTabIcon(String icon, String title, int index) {
//     return Flexible(
//       child: GestureDetector(
//         onTap: () => _onTabSelected(index),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Icon(
//             //   icon,
//             //   color: _selectedIndex == index ? Colors.white : Colors.grey,
//             // ),
//             SvgPicture.asset(
//               icon,
//               width: 18,
//               height: 18,
//               color: _selectedIndex == index ? Colors.white : Colors.grey,
//             ),
//             Text(
//               title,
//               style: TextStyle(
//                 color: _selectedIndex == index ? Colors.white : Colors.grey,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
