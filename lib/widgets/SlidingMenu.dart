import 'package:flutter/material.dart';
import 'package:craft_school/screens/HelpSupport.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/screens/TermsCondition.dart';
import 'package:craft_school/screens/Testimonial.dart';
import 'package:craft_school/screens/savedCourse.dart';
import 'package:craft_school/screens/service_plan_screen.dart';
import 'package:craft_school/screens/settings.dart';
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
      duration: const Duration(milliseconds: 500),
      top: isVisible ? 0 : -200,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: isVisible ? SizeConfig.blockSizeVertical * 50 : 0,
        decoration: BoxDecoration(
          color: CraftColors.neutralBlue800.withOpacity(0.9),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CraftColors.neutralBlue800,
              CraftColors.neutralBlue850,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuItem(
                context,
                CraftStrings.strCommunity,
                PostScreen.route,
                Icons.people_outline,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 20,
              ),
              _buildMenuItem(
                context,
                CraftStrings.strPlans,
                PlanPriceCardScreen.route,
                Icons.credit_card_outlined,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 20,
              ),
              _buildMenuItem(
                context,
                CraftStrings.strTestimonial,
                Testimonial.route,
                Icons.star_outline,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 20,
              ),
              _buildMenuItem(
                context,
                CraftStrings.strSavedCourse,
                SavedCourseScreen.route,
                Icons.bookmark_outline,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 20,
              ),
              _buildMenuItem(
                context,
                CraftStrings.strHelpandsupport,
                HelpSupport.route,
                Icons.help_outline,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 20,
              ),
              _buildMenuItem(
                context,
                CraftStrings.strTermscondition,
                TermsCondition.route,
                Icons.description_outlined,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 20,
              ),
              _buildMenuItem(
                context,
                CraftStrings.strSetting,
                Settings.route,
                Icons.settings_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, String route, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      borderRadius: BorderRadius.circular(10),
      hoverColor: Colors.white.withOpacity(0.1),
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: CraftStyles.tsWhiteNeutral50W60016.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.7),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
