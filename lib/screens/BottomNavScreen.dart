// import 'package:craft_school/screens/Landing_Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:craft_school/screens/AllCourses.dart';
// import 'package:craft_school/screens/PostScreen.dart';
// import 'package:craft_school/screens/myCourse.dart';
// import 'package:craft_school/screens/settings.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/craft_images.dart';

// class BottomNavScreen extends StatefulWidget {
//   const BottomNavScreen({super.key});

//   @override
//   _BottomNavScreenState createState() => _BottomNavScreenState();
// }

// class _BottomNavScreenState extends State<BottomNavScreen> {
//   int _selectedIndex = 0;
//   final List<int> _navigationHistory = []; // Store navigation history

//   final List<Widget> _screens = [
 
//     MyCourseScreen(),
//     AllCourses(),
//     PostScreen(),
//     Settings(),
//   ];

//   void _onTabSelected(int index) {
//     if (_selectedIndex != index) {
//       _navigationHistory.add(_selectedIndex); // Store current tab before switching
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   Future<bool> _onWillPop() async {
//     if (_navigationHistory.isNotEmpty) {
//       setState(() {
//         _selectedIndex = _navigationHistory.removeLast(); // Go to previous tab
//       });
//       return false; // Prevent app exit
//     }
//     return true; // Exit app if history is empty (only when on the first tab)
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         body: IndexedStack(
//           index: _selectedIndex,
//           children: _screens,
//         ),
//         bottomNavigationBar: _buildBottomNavBar(),
//       ),
//     );
//   }

//   Widget _buildBottomNavBar() {
//     return Container(
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
            
//             _buildTabIcon(CraftImagePath.courses, "My Courses", 0),
//             _buildTabIcon(CraftImagePath.services, "Courses", 1),
//             const SizedBox(width: 20), // Space for FloatingActionButton if needed
//             _buildTabIcon(CraftImagePath.blogs, "Community", 2),
//             _buildTabIcon(CraftImagePath.myspace, "My Space", 3),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabIcon(String icon, String title, int index) {
//     return Flexible(
//       child: GestureDetector(
//         onTap: () => _onTabSelected(index),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
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
