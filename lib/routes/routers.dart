import 'package:craft_school/dto/ForgetPasswordDTO.dart';
import 'package:craft_school/screens/CreatePostScreen.dart';
import 'package:craft_school/screens/HelpSupport.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/MasterScreen.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/screens/TermsCondition.dart';
import 'package:craft_school/screens/Testimonial.dart';
import 'package:craft_school/screens/account_screen.dart';
import 'package:craft_school/screens/blog_screen.dart';
import 'package:craft_school/screens/change_plan.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/screens/create_password_screen.dart';
import 'package:craft_school/screens/forgetpassword_screen.dart';
import 'package:craft_school/screens/myCourse.dart';
import 'package:craft_school/screens/personal_screen.dart';
import 'package:craft_school/screens/savedCourse.dart';
import 'package:craft_school/screens/service.dart';
import 'package:craft_school/screens/service_plan_screen.dart';
import 'package:craft_school/screens/settings.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/screens/signup_screen.dart';
import 'package:craft_school/screens/splash_screen.dart';
import 'package:craft_school/screens/successful_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/BottomAppBarNavigationScreen.dart';

class Routers {
  // Create a static method to configure the router
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // To get arguments use settings.arguments
      // Arguments can be passed in the widget calling
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case SignInScreen.route:
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );
      case SignUpScreen.route:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case CreatePasswordScreen.route:
        return MaterialPageRoute(
          builder: (_) => CreatePasswordScreen(),
        );
      case LandingScreen.route:
        return MaterialPageRoute(
          builder: (_) => LandingScreen(),
        );
      case BlogsScreen.route:
        return MaterialPageRoute(
          builder: (_) => BlogsScreen(),
        );
      case PlanPriceCardScreen.route:
        return MaterialPageRoute(
          builder: (_) => PlanPriceCardScreen(),
        );
      case AspiringTrainingScreen.route:
        return MaterialPageRoute(
          builder: (_) => AspiringTrainingScreen(),
        );
      case MyCourseScreen.route:
        return MaterialPageRoute(
          builder: (_) => MyCourseScreen(),
        );
      //  case BottomAppBarWidget.route:
      // return MaterialPageRoute(
      //   builder: (_) =>  BottomAppBarWidget(),
      // );
      case AccountScreen.route:
        return MaterialPageRoute(
          builder: (_) => AccountScreen(),
        );
      case SuccessfulScreen.route:
        return MaterialPageRoute(
          builder: (_) => SuccessfulScreen(),
        );
      case ChangePlan.route:
        return MaterialPageRoute(
          builder: (_) => ChangePlan(),
        );
      case PersonalScreen.route:
        return MaterialPageRoute(
          builder: (_) => PersonalScreen(),
        );
      case MasterScreen.route:
        return MaterialPageRoute(
          builder: (_) => MasterScreen(),
        );
      case Settings.route:
        return MaterialPageRoute(
          builder: (_) => Settings(),
        );
      case SavedCourseScreen.route:
        return MaterialPageRoute(
          builder: (_) => SavedCourseScreen(),
        );
      case TermsCondition.route:
        return MaterialPageRoute(
          builder: (_) => TermsCondition(),
        );
      case HelpSupport.route:
        return MaterialPageRoute(
          builder: (_) => HelpSupport(),
        );
      case PostScreen.route:
        return MaterialPageRoute(
          builder: (_) => PostScreen(),
        );
      case CreatePostScreen.route:
        return MaterialPageRoute(
          builder: (_) => CreatePostScreen(),
        );
      case Testimonial.route:
        return MaterialPageRoute(
          builder: (_) => Testimonial(),
        );
      case Coursedetailscreen.route:
        return MaterialPageRoute(
          builder: (_) => Coursedetailscreen(),
        );
      case ForgetpasswordScreen.route:
        // Retrieve the arguments passed
        final args = settings.arguments as ForgetPasswordDTO?;
        if (settings.arguments == null) {
          return _errorRoute();
        }

        // If arguments are provided, pass them to the ForgetpasswordScreen constructor
        return MaterialPageRoute(
          builder: (_) => ForgetpasswordScreen(
            title: args?.title ?? '',
            detailText: args?.detailText ?? '',
            emailHint: args?.emailHint ?? '',
            buttonText: args?.buttonText ?? '',
            signInText: args?.signInText ?? '',
            isEmailSectionnVisble: args?.isEmailSectionnVisble ?? false,
            onButtonOnTap: args?.onButtonOnTap,
            onTextOnTap: args?.onTextOnTap,
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }

  // Define an error route for handling unknown routes
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Error',
            ),
          ),
          body: const Center(
            child: Text(
              'Error: Route not found!',
            ),
          ),
        );
      },
    );
  }
}
