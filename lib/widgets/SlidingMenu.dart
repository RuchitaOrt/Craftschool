import 'package:craft_school/screens/HelpSupport.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/screens/TermsCondition.dart';
import 'package:craft_school/screens/Testimonial.dart';
import 'package:craft_school/screens/myCourse.dart';
import 'package:craft_school/screens/savedCourse.dart';
import 'package:craft_school/screens/service_plan_screen.dart';
import 'package:craft_school/screens/settings.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

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
          height: isVisible ? SizeConfig.blockSizeVertical*40 : 0,
          color: CraftColors.neutralBlue800,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: ()
                  {
                     Navigator.of(context)
                        .pushNamed(
                          PostScreen.route,
                        )
                        .then((value) {});
                  },
                  child: Text(
                    CraftStrings.strCommunity,
                    style:
                        CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                  ),
                ),
                Divider(
                  thickness: 0.2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(
                          PlanPriceCardScreen.route,
                        )
                        .then((value) {});
                  },
                  child: Text(
                    CraftStrings.strPlans,
                    style: CraftStyles.tsWhiteNeutral50W60016
                        .copyWith(fontSize: 14),
                  ),
                ),
                Divider(
                  thickness: 0.2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(
                          Testimonial.route,
                        )
                        .then((value) {});
                  },
                  child: Text(
                    CraftStrings.strTestimonial,
                    style: CraftStyles.tsWhiteNeutral50W60016
                        .copyWith(fontSize: 14),
                  ),
                ),
                 Divider(
                  thickness: 0.2,
                ),
                GestureDetector(
                  onTap: () {
                     Navigator.of(context)
                        .pushNamed(
                          SavedCourseScreen.route,
                        )
                        .then((value) {});
                  },
                  child: Text(
                    CraftStrings.strSavedCourse,
                    style: CraftStyles.tsWhiteNeutral50W60016
                        .copyWith(fontSize: 14),
                  ),
                ),
                 Divider(
                  thickness: 0.2,
                ),
                 GestureDetector(
                  onTap: () {
                   Navigator.of(context)
                        .pushNamed(
                          HelpSupport.route,
                        )
                        .then((value) {});
                  },
                  child: Text(
                    CraftStrings.strHelpandsupport,
                    style: CraftStyles.tsWhiteNeutral50W60016
                        .copyWith(fontSize: 14),
                  ),
                ),
                 Divider(
                  thickness: 0.2,
                ),
                 GestureDetector(
                  onTap: () {
                           Navigator.of(context)
                        .pushNamed(
                          TermsCondition.route,
                        )
                        .then((value) {});
                  },
                  child: Text(
                    CraftStrings.strTermscondition,
                    style: CraftStyles.tsWhiteNeutral50W60016
                        .copyWith(fontSize: 14),
                  ),
                ),
                 Divider(
                  thickness: 0.2,
                ),
                 GestureDetector(
                  onTap: () {
                      Navigator.of(context)
                        .pushNamed(
                          Settings.route,
                        )
                        .then((value) {});
                  },
                  child: Text(
                    CraftStrings.strSetting,
                    style: CraftStyles.tsWhiteNeutral50W60016
                        .copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
