

import 'package:craft_school/dto/ForgetPasswordDTO.dart';
import 'package:craft_school/providers/BlogProvider.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:craft_school/providers/GetServiceProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/providers/TestimonialProvider.dart';
import 'package:craft_school/providers/membership_provider.dart';
import 'package:craft_school/providers/personal_account_provider.dart';
import 'package:craft_school/screens/AllCourses.dart';
import 'package:craft_school/screens/BlogDetailScreen.dart';
import 'package:craft_school/screens/Career.dart';
import 'package:craft_school/screens/CategoryCourseWidget.dart';
import 'package:craft_school/screens/ContactUs.dart';
import 'package:craft_school/screens/CreatePostScreen.dart';
import 'package:craft_school/screens/DeviceLimitReachedScreen.dart';
import 'package:craft_school/screens/ExploreCourse.dart';
import 'package:craft_school/screens/FAQScreen.dart';
import 'package:craft_school/screens/HelpSupport.dart';
import 'package:craft_school/screens/JoinFlimFest.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/MasterScreen.dart';
import 'package:craft_school/screens/MasterScreenDetail.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/screens/SavedPostScreen.dart';
import 'package:craft_school/screens/SearchScreen.dart';
import 'package:craft_school/screens/TermsCondition.dart';
import 'package:craft_school/screens/Testimonial.dart';
import 'package:craft_school/screens/VideoScreen.dart';
import 'package:craft_school/screens/account_screen.dart';
import 'package:craft_school/screens/autoscroll.dart';
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
import 'package:provider/provider.dart';

class Routers {
  // Create a static method to configure the router
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // To get arguments use settings.arguments
      // Arguments can be passed in the widget calling
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
        );
         case SignInScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  SignInScreen(),
        );
         case ExploreCourse.route:
        return MaterialPageRoute(
          builder: (_) =>  ExploreCourse(),
        );
          case FAQScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  FAQScreen(),
        );
      case SignUpScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  SignUpScreen(),
        );
        //  case SlantedImageReel.route:
        // return MaterialPageRoute(
        //   builder: (_) =>  SlantedImageReel(),
        // );
        
         case ContactUs.route:
        return MaterialPageRoute(
          builder: (_) =>  ContactUs(),
        );
         case Career.route:
        return MaterialPageRoute(
          builder: (_) =>  Career(),
        );
       
         case JoinFlimFest.route:
          final args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) =>  JoinFlimFest(flimId: args ?? "",),
        );
 case CategoryCourseWidget.route:
        return MaterialPageRoute(
          builder: (_) =>  CategoryCourseWidget(),
        );

        
        case CreatePasswordScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  CreatePasswordScreen(),
        );
          case SearchScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  SearchScreen(),
        );
         case LandingScreen.route:
          final args = settings.arguments as bool?;

        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => LandingScreenProvider(),
          child: LandingScreen(isSignUp: args ?? false,),
        ),
        );
        //  case BlogsScreen.route:
        // return MaterialPageRoute(
        //   builder: (_) =>  ChangeNotifierProvider(
        //   create: (_) => BlogProvider(),
        //   child: BlogsScreen(),
        // ),
        // );
         case BlogsScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  BlogsScreen(),
        );
        case PlanPriceCardScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => LandingScreenProvider(),
          child: PlanPriceCardScreen(),
        ),
        );
        
         case AspiringTrainingScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => GetServiceProvider(),
          child: AspiringTrainingScreen(),
        ),
        );
        case MyCourseScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  MyCourseScreen(),
        );
         case AccountScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => PersonalAccountProvider(),
          child: AccountScreen(),
        ),
        );
        
        case SuccessfulScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  SuccessfulScreen(),
        );
        
         case ChangePlan.route:
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => MembershipProvider(),
          child: ChangePlan(),
        ),
        );
        case PersonalScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => PersonalAccountProvider(),
          child: PersonalScreen(),
        ),
        );
        case MasterScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => MasterAllProvider(),
          child: MasterScreen(),
        ),
        );
          case MasterScreenDetail.route:
         final args = settings.arguments as String?;
  if (args == null) {
    return _errorRoute(); // Return an error route if slug is null
  }

        return MaterialPageRoute(
          
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => MasterAllProvider(),
          
          child: MasterScreenDetail( slug: args),
        ),
        );
         case BlogDetailScreen.route:
         final args = settings.arguments as String?;
  if (args == null) {
    return _errorRoute(); // Return an error route if slug is null
  }

        return MaterialPageRoute(
          
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => BlogProvider(),
          
          child: BlogDetailScreen( slug: args),
        ),
        );
        case Settings.route:
        
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => PersonalAccountProvider(),
          child: Settings(),
        ),
        );
         case AllCourses.route:
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => CoursesProvider(),
          child: AllCourses(),
        ),
        );
        
         case SavedCourseScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  SavedCourseScreen(),
        );
         case TermsCondition.route:
        return MaterialPageRoute(
          builder: (_) =>  TermsCondition(),
        );
         case HelpSupport.route:
        return MaterialPageRoute(
          builder: (_) =>  HelpSupport(),
        );
         case VideoScreen.route:
         final args = settings.arguments  as Map<String, dynamic>;
  if (args == null) {
    return _errorRoute(); // Return an error route if slug is null
  }
        return MaterialPageRoute(
          builder: (_) =>  VideoScreen(video: args['video'] ?? '',videoTopicSlug: args['videoTopicSlug'] ?? '',videoCourseSlug: args['videoCourseSlug'] ?? '',videoWatchTime:args['videoWatchTime']),
        );
         case PostScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  PostScreen(),
        );
 case SavedPostScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  SavedPostScreen(),
        );
         case DeviceLimitReachedScreen.route:
          final args = settings.arguments as String?;
  if (args == null) {
    return _errorRoute(); // Return an error route if slug is null
  }
        return MaterialPageRoute(
          builder: (_) =>  DeviceLimitReachedScreen(msg: args,),
        );
        
     case CreatePostScreen.route:
  final args = settings.arguments as Map<String, dynamic>; // Here we expect a Map
  return MaterialPageRoute(
    builder: (_) => CreatePostScreen(
      postcomment: args['postcomment'] ?? '', // Default value if null
      postId: args['postId'] ?? '', // Default value if null
      medias: List<dynamic>.from(args['medias'] ?? []), // Default empty list if null
      iseditView: args['iseditView'] ?? false, // Default to false if null
    ),
  );
        case Testimonial.route:
        return MaterialPageRoute(
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => TestimonialProvider(),
          child: Testimonial(),
        ),
        );
        case Coursedetailscreen.route:
         final args = settings.arguments as String?;
  if (args == null) {
    return _errorRoute(); // Return an error route if slug is null
  }

        return MaterialPageRoute(
          
          builder: (_) =>  ChangeNotifierProvider(
          create: (_) => CoursesProvider(),
          
          child: Coursedetailscreen( slug: args),
        ),
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
            isEmailSectionnVisble:args?.isEmailSectionnVisble?? false,
            onButtonOnTap: args?.onButtonOnTap,
            onTextOnTap: args?.onTextOnTap,

          ),
        );
      
      default:
         return MaterialPageRoute(builder: (_) =>  SplashScreen());
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
