// import 'package:craft_school/routes/routers.dart';
// import 'package:craft_school/screens/Landing_Screen.dart';
// import 'package:craft_school/screens/blog_screen.dart';
// import 'package:craft_school/screens/myCourse.dart';
// import 'package:craft_school/screens/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:craft_school/providers/BlogProvider.dart';
// import 'package:craft_school/providers/CategoryListProvider.dart';
// import 'package:craft_school/providers/CommunityProvider.dart';
// import 'package:craft_school/providers/CourseDetailProvider.dart';
// import 'package:craft_school/providers/CoursesProvider.dart';
// import 'package:craft_school/providers/Faq_provider.dart';
// import 'package:craft_school/providers/GetServiceProvider.dart';
// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/providers/MasterAllProvider.dart';
// import 'package:craft_school/providers/membership_provider.dart';
// import 'package:craft_school/providers/personal_account_provider.dart';
// import 'package:craft_school/providers/sign_up_provider.dart';

// final GlobalKey<NavigatorState> routeGlobalKey = GlobalKey();

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<SignUpProvider>(
//           create: (context) => SignUpProvider(),
//         ),
//         ChangeNotifierProvider<CategoryListProvider>(
//           create: (context) => CategoryListProvider(),
//         ),
//         ChangeNotifierProvider<LandingScreenProvider>(
//           create: (context) => LandingScreenProvider(),
//         ),
//         ChangeNotifierProvider<MasterAllProvider>(
//           create: (context) => MasterAllProvider(),
//         ),
//         ChangeNotifierProvider<BlogProvider>(
//           create: (context) => BlogProvider(),
//         ),
//         ChangeNotifierProvider<CourseDetailProvider>(
//           create: (context) => CourseDetailProvider(),
//         ),
//         ChangeNotifierProvider<CoursesProvider>(
//           create: (context) => CoursesProvider(),
//         ),
//         ChangeNotifierProvider<CommunityProvider>(
//           create: (context) => CommunityProvider(),
//         ),
//         ChangeNotifierProvider<MembershipProvider>(
//           create: (context) => MembershipProvider(),
//         ),
//         ChangeNotifierProvider<PersonalAccountProvider>(
//           create: (context) => PersonalAccountProvider(),
//         ),
//         ChangeNotifierProvider<FAQProvider>(
//           create: (context) => FAQProvider(),
//         ),
//         ChangeNotifierProvider<GetServiceProvider>(
//           create: (context) => GetServiceProvider(),
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Craft School',
//         debugShowCheckedModeBanner: false,
//         navigatorKey: routeGlobalKey,
//         theme: ThemeData(
//           textTheme: GoogleFonts.interTextTheme(),
//         ),
//         initialRoute: SplashScreen.route,
//         onGenerateRoute: Routers.generateRoute,
//       ),
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//   List<int> _navigationHistory = [0]; // Track navigation history

//   final List<Widget> _pages = [
//     LandingScreen(),
//     BlogsScreen(),
//     MyCourseScreen(),
//   ];

//   Future<bool> _onWillPop() async {
//     if (_navigationHistory.length > 1) {
//       setState(() {
//         _navigationHistory.removeLast();
//         _selectedIndex = _navigationHistory.last;
//       });
//       return false; // Prevent app from closing
//     }
//     return true; // Allow app to exit if already on Home
//   }

//   void _onTabTapped(int index) {
//     if (_selectedIndex != index) {
//       setState(() {
//         _selectedIndex = index;
//         _navigationHistory.add(index); // Store visited tab
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         body: IndexedStack(
//           index: _selectedIndex,
//           children: _pages,
//         ),
//         bottomNavigationBar: BottomAppBarWidget(
//           currentIndex: _selectedIndex,
//           onTabSelected: _onTabTapped,
//         ),
//       ),
//     );
//   }
// }

// class BottomAppBarWidget extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTabSelected;

//   BottomAppBarWidget({required this.currentIndex, required this.onTabSelected});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTabSelected,
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//       ],
//     );
//   }
// }





import 'package:craft_school/providers/BlogProvider.dart';
import 'package:craft_school/providers/CategoryListProvider.dart';
import 'package:craft_school/providers/CommunityProvider.dart';
import 'package:craft_school/providers/CourseDetailProvider.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:craft_school/providers/Faq_provider.dart';
import 'package:craft_school/providers/GetServiceProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/providers/membership_provider.dart';
import 'package:craft_school/providers/personal_account_provider.dart';
import 'package:craft_school/providers/sign_up_provider.dart';
import 'package:craft_school/routes/routers.dart';
import 'package:craft_school/screens/splash_screen.dart';
import 'package:craft_school/widgets/VideoThumbnail.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
final GlobalKey<NavigatorState> routeGlobalKey = GlobalKey();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform,
  //   );
SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp() : super();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(),
        ), 
        ChangeNotifierProvider<CategoryListProvider>(
          create: (context) => CategoryListProvider(),
        ),
         ChangeNotifierProvider<LandingScreenProvider>(
          create: (context) => LandingScreenProvider(),
        ),
         ChangeNotifierProvider<MasterAllProvider>(
          create: (context) => MasterAllProvider(),
        ),
          ChangeNotifierProvider<BlogProvider>(
          create: (context) => BlogProvider(),
        ),
          ChangeNotifierProvider<CourseDetailProvider>(
          create: (context) => CourseDetailProvider(),
        ),
         ChangeNotifierProvider<CoursesProvider>(
          create: (context) => CoursesProvider(),
        ),
        ChangeNotifierProvider<CommunityProvider>(
          create: (context) => CommunityProvider(),
        ),
         ChangeNotifierProvider<MembershipProvider>(
          create: (context) => MembershipProvider(),
        ),
        ChangeNotifierProvider<PersonalAccountProvider>(
          create: (context) => PersonalAccountProvider(),
        ),
        ChangeNotifierProvider<FAQProvider>(
          create: (context) => FAQProvider(),
        ),
          ChangeNotifierProvider<GetServiceProvider>(
          create: (context) => GetServiceProvider(),
        ),
              ChangeNotifierProvider<VideoThumbnailCache>(
          create: (context) => VideoThumbnailCache(),
        ),
      ],
      child: MaterialApp(
        title: 'Craft School',
        debugShowCheckedModeBanner: false,
        navigatorKey: routeGlobalKey,
       theme: ThemeData(
      textTheme: GoogleFonts.interTextTheme(),
        ),
        initialRoute: SplashScreen.route,
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
