// import 'package:flutter/material.dart';

// import 'package:craft_school/screens/AllCourses.dart';
// import 'package:craft_school/screens/PostScreen.dart';
// import 'package:craft_school/screens/myCourse.dart';
// import 'package:craft_school/screens/settings.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// class BottomNavScreen extends StatefulWidget {
//   @override
//   _BottomNavScreenState createState() => _BottomNavScreenState();
// }

// class _BottomNavScreenState extends State<BottomNavScreen> {
//   final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

//   List<Widget> _buildScreens() {
//     return [MyCourseScreen(), AllCourses(), PostScreen(), Settings()];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(icon: Icon(Icons.school), title: "Courses", activeColorPrimary: Colors.blue),
//       PersistentBottomNavBarItem(icon: Icon(Icons.book), title: "All Courses", activeColorPrimary: Colors.blue),
//       PersistentBottomNavBarItem(icon: Icon(Icons.comment), title: "Community", activeColorPrimary: Colors.blue),
//       PersistentBottomNavBarItem(icon: Icon(Icons.settings), title: "Settings", activeColorPrimary: Colors.blue),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       backgroundColor: Colors.white,
//       navBarStyle: NavBarStyle.style3, // Customize style
//      handleAndroidBackButtonPress: true, // ✅ Ensures proper back handling
//   resizeToAvoidBottomInset: true, // ✅ Prevents UI freeze
//   stateManagement: true, // ✅ Allows state updates
//   onItemSelected: (index) {
//     if (mounted) setState(() {
//       _controller.jumpToTab(index);
//     }); // ✅ Forces rebuild
//   },
//     );
//   }
// }
