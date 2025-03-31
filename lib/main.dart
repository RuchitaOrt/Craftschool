
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
