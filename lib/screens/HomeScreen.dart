// import 'package:craft_school/screens/blog_screen.dart';
// import 'package:craft_school/screens/landing_screen.dart';
// import 'package:craft_school/screens/myCourse.dart';
// import 'package:craft_school/screens/service.dart';
// import 'package:craft_school/screens/settings.dart';
// import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;

//   void _onTabChanged(int index) async {
//     if (index == 0) {
//       setState(() {
//         _currentIndex = 0;
//       });
//     } else {
//       setState(() {
//         _currentIndex = index;
//       });

//       Widget nextScreen;
//       if (index == 1) {
//         nextScreen = const AspiringTrainingScreen();
//       } else if (index == 2) {
//         nextScreen = const BlogsScreen();
//       } else {
//         nextScreen = const Settings();
//       }

//       await Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => nextScreen),
//       );

//       // When coming back
//       setState(() {
//         _currentIndex = 0; // Reset to Landing screen after back
//       });
//     }
//   }

//   void _onFabPressed() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('FAB Clicked')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: const LandingScreen(),
//       bottomNavigationBar: BottomAppBarWidget(
//         index: _currentIndex,
//         onTabSelected: _onTabChanged,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _onFabPressed,
//         backgroundColor: Colors.white,
//         child: const Icon(Icons.add, color: Colors.black),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
