import 'package:craft_school/providers/bottom_tab_provider.dart';
import 'package:craft_school/screens/blog_screen.dart';
import 'package:craft_school/screens/myCourse.dart';
import 'package:craft_school/screens/service.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomAppBarWidget extends StatelessWidget {
  final List<String> _tabTitles = [
    'My Courses',
    'Services',
    'Blog',
    'Community',
    'Categories',
  ];

  final Map<int, Widget> _routeMap = {
    0: MyCourseScreen(),
    1: AspiringTrainingScreen(),
    2: BlogsScreen(),
  };

  void _navigateToScreen(BuildContext context, Widget screen, int index) {
    Navigator.of(context)
        .pushReplacement(
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
        duration: Duration(milliseconds: 300),
      ),
    )
        .then((value) {
      Provider.of<BottomTabProvider>(context, listen: false)
          .setSelectedIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabState = Provider.of<BottomTabProvider>(context);
    final _selectedIndex = tabState.selectedIndex;

    return Container(
      height: SizeConfig.blockSizeVertical * 11.5,
      decoration: BoxDecoration(
        color: CraftColors.neutralBlue800,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabIcon(context, Icons.home, _tabTitles[0], 0),
            _buildTabIcon(context, Icons.search, _tabTitles[1], 1),
            const SizedBox(width: 40),
            _buildTabIcon(context, Icons.notifications, _tabTitles[2], 2),
            _buildTabIcon(context, Icons.settings, _tabTitles[3], 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon(
      BuildContext context, IconData icon, String title, int index) {
    final tabState = Provider.of<BottomTabProvider>(context);
    final _selectedIndex = tabState.selectedIndex;

    return GestureDetector(
      onTap: () {
        tabState.setSelectedIndex(index);
        if (_routeMap.containsKey(index)) {
          _navigateToScreen(context, _routeMap[index]!, index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.white : Colors.grey,
          ),
          Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
