import 'dart:io';
import 'package:craft_school/screens/Career.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/screens/CategoryCourseWidget.dart';
import 'package:craft_school/screens/ContactUs.dart';
import 'package:craft_school/screens/ExploreCourse.dart';
import 'package:craft_school/screens/FAQScreen.dart';
import 'package:craft_school/screens/HelpSupport.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/screens/TermsCondition.dart';
import 'package:craft_school/screens/Testimonial.dart';
import 'package:craft_school/screens/blog_screen.dart';
import 'package:craft_school/screens/myCourse.dart';
import 'package:craft_school/screens/savedCourse.dart';
import 'package:craft_school/screens/service.dart';
import 'package:craft_school/screens/service_plan_screen.dart';
import 'package:craft_school/screens/settings.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/SPManager.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';

class SlidingMenu extends StatelessWidget {
  final bool isVisible;

  const SlidingMenu({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 2),
      top: isVisible ? 0 : -200,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: isVisible
            ? Platform.isAndroid
                ? SizeConfig.blockSizeVertical * 60
                : SizeConfig.blockSizeVertical * 55
            : 0,
        color: CraftColors.neutralBlue800,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              _buildMenuItem(Icons.home, "Home", LandingScreen.route, context),
              _buildMenuItem(Icons.miscellaneous_services, "Services",
                  AspiringTrainingScreen.route, context),
              _buildMenuItem(
                  Icons.article, "Blogs", BlogsScreen.route, context),
              if (GlobalLists.authtoken != "")
                _buildMenuItem(
                    Icons.payment, "Plans", PlanPriceCardScreen.route, context),
              _buildMenuItem(
                  Icons.reviews, "Testimonial", Testimonial.route, context),
              _buildMenuItem(Icons.bookmark, "Saved Courses",
                  SavedCourseScreen.route, context),
              _buildMenuItem(Icons.category, "All Categories",
                  CategoryCourseWidget.route, context),
              _buildMenuItem(Icons.support_agent, "Help & Support",
                  HelpSupport.route, context),
              _buildMenuItem(Icons.assignment, "Terms & Conditions",
                  TermsCondition.route, context),
              _buildMenuItem(
                  Icons.contact_mail, "Contact Us", ContactUs.route, context),
              _buildMenuItem(Icons.explore, "Explore Courses",
                  ExploreCourse.route, context),
              _buildMenuItem(
                  Icons.question_answer, "FAQ", FAQScreen.route, context),
              _buildMenuItem(Icons.work, "Career", Career.route, context),
              if (GlobalLists.authtoken != "")
                _buildMenuItem(
                    Icons.settings, "Settings", Settings.route, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon, String title, String route, BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          dense: true,
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
          ),
          onTap: () => Navigator.of(context).pushNamed(route),
        ),
        const Divider(thickness: 0.2, color: Colors.white30),
      ],
    );
  }
}

// import 'dart:io';

// import 'package:craft_school/screens/CategoryCourseWidget.dart';
// import 'package:craft_school/screens/ContactUs.dart';
// import 'package:craft_school/screens/ExploreCourse.dart';
// import 'package:craft_school/screens/FAQScreen.dart';
// import 'package:craft_school/screens/HelpSupport.dart';
// import 'package:craft_school/screens/Landing_Screen.dart';
// import 'package:craft_school/screens/PostScreen.dart';
// import 'package:craft_school/screens/TermsCondition.dart';
// import 'package:craft_school/screens/Testimonial.dart';
// import 'package:craft_school/screens/blog_screen.dart';
// import 'package:craft_school/screens/myCourse.dart';
// import 'package:craft_school/screens/savedCourse.dart';
// import 'package:craft_school/screens/service.dart';
// import 'package:craft_school/screens/service_plan_screen.dart';
// import 'package:craft_school/screens/settings.dart';
// import 'package:craft_school/utils/GlobalLists.dart';
// import 'package:craft_school/utils/SPManager.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/craft_strings.dart';
// import 'package:craft_school/utils/craft_styles.dart';
// import 'package:craft_school/utils/sizeConfig.dart';
// import 'package:flutter/material.dart';

// class SlidingMenu extends StatelessWidget {
//   final bool isVisible;

//   const SlidingMenu({super.key, required this.isVisible});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedPositioned(
//       duration: const Duration(seconds: 2),
//       top: isVisible ? 0 : -200,
//       left: 0,
//       right: 0,
//       child: AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           height: isVisible ?Platform.isAndroid?SizeConfig.blockSizeVertical * 60 : SizeConfig.blockSizeVertical * 55 : 0,
//           color: CraftColors.neutralBlue800,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ListView(
//               shrinkWrap: true,
//               physics: ScrollPhysics(),
//               // mainAxisAlignment: MainAxisAlignment.start,
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           LandingScreen.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strHome,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 // GlobalLists.communityPlan == "Yes"
//                 //     ? GestureDetector(
//                 //         onTap: () {
//                 //           Navigator.of(context)
//                 //               .pushNamed(
//                 //                 PostScreen.route,
//                 //               )
//                 //               .then((value) {});
//                 //         },
//                 //         child: Text(
//                 //           CraftStrings.strCommunity,
//                 //           style: CraftStyles.tsWhiteNeutral50W60016
//                 //               .copyWith(fontSize: 14),
//                 //         ),
//                 //       )
//                 //     : Container(),
//                 GestureDetector(
//                         onTap: () {
//                           Navigator.of(context)
//                               .pushNamed(
//                                 AspiringTrainingScreen.route,
//                               )
//                               .then((value) {});
//                         },
//                         child: Text(
//                           "Services",
//                           style: CraftStyles.tsWhiteNeutral50W60016
//                               .copyWith(fontSize: 14),
//                         ),
//                       ),
//                 Divider(
//                         thickness: 0.2,
//                       )
//                     ,
//                 GestureDetector(
//                         onTap: () {
//                           Navigator.of(context)
//                               .pushNamed(
//                                 BlogsScreen.route,
//                               )
//                               .then((value) {});
//                         },
//                         child: Text(
//                           "Blogs",
//                           style: CraftStyles.tsWhiteNeutral50W60016
//                               .copyWith(fontSize: 14),
//                         ),
//                       ),
//                 Divider(
//                         thickness: 0.2,
//                       )
//                     ,
//                 GlobalLists.authtoken != ""
//                     ? GestureDetector(
//                         onTap: () {
//                           Navigator.of(context)
//                               .pushNamed(
//                                 PlanPriceCardScreen.route,
//                               )
//                               .then((value) {});
//                         },
//                         child: Text(
//                           CraftStrings.strPlans,
//                           style: CraftStyles.tsWhiteNeutral50W60016
//                               .copyWith(fontSize: 14),
//                         ),
//                       )
//                     : Container(),
//                 GlobalLists.authtoken != ""
//                     ? Divider(
//                         thickness: 0.2,
//                       )
//                     : Container(),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           Testimonial.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strTestimonial,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           SavedCourseScreen.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strSavedCourse,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           CategoryCourseWidget.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strAllCategory,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           HelpSupport.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strHelpandsupport,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           TermsCondition.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strTermscondition,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           ContactUs.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strContactUs,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           ExploreCourse.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strExploreCourse,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                  GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamed(
//                           FAQScreen.route,
//                         )
//                         .then((value) {});
//                   },
//                   child: Text(
//                     CraftStrings.strFAQ,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 14),
//                   ),
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 GlobalLists.authtoken != ""
//                     ? GestureDetector(
//                         onTap: () {
//                           Navigator.of(context)
//                               .pushNamed(
//                                 Settings.route,
//                               )
//                               .then((value) {});
//                         },
//                         child: Text(
//                           CraftStrings.strSetting,
//                           style: CraftStyles.tsWhiteNeutral50W60016
//                               .copyWith(fontSize: 14),
//                         ),
//                       )
//                     : Container(),
//               ],
//             ),
//           )),
//     );
//   }
// }
