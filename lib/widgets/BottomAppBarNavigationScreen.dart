import 'package:craft_school/screens/blog_screen.dart';
import 'package:craft_school/screens/myCourse.dart';
import 'package:craft_school/screens/service.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatefulWidget {
  final int index;
  const BottomAppBarWidget({super.key, required this.index});

  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}
class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  int _selectedIndex = 0;
@override
  void initState() {
    super.initState();
    // Now you can safely access 'widget' and initialize _selectedIndex
    _selectedIndex = widget.index; // Example of using 'widget' safely
  }
  final List<String> _tabTitles = [
    'My Courses',
    'Services',
    'Blog',
    'Community',
    'Categories',
  ];

  // Function to handle tab selection
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index; // Update selected tab index
    });

    // Navigate based on the selected index
    if (_selectedIndex == 0) {
      Navigator.of(context)
        .pushReplacementNamed(MyCourseScreen.route) // Use pushReplacementNamed
        .then((value) {
          // This will ensure that once the user returns, the state is updated
          setState(() {
            _selectedIndex = 0;  // Ensure the correct tab is highlighted
          });
        });
    } else if (_selectedIndex == 2) {
      Navigator.of(context)
        .pushReplacementNamed(BlogsScreen.route) // Use pushReplacementNamed
        .then((value) {
          setState(() {
            _selectedIndex = 2;  // Ensure the Blog tab is highlighted
          });
        });
    } else if (_selectedIndex == 1) {
      Navigator.of(context)
        .pushReplacementNamed(AspiringTrainingScreen.route) // Use pushReplacementNamed
        .then((value) {
          setState(() {
            _selectedIndex = 1;  // Ensure the Services tab is highlighted
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabIcon(Icons.home, _tabTitles[0], 0),
            _buildTabIcon(Icons.search, _tabTitles[1], 1),
            const SizedBox(width: 40), // Space for the Floating Action Button (FAB)
            _buildTabIcon(Icons.notifications, _tabTitles[2], 2),
            _buildTabIcon(Icons.settings, _tabTitles[3], 3),
          ],
        ),
      ),
    );
  }

  // Helper function to build a tab icon with text
  Widget _buildTabIcon(IconData icon, String title, int index) {
    return GestureDetector(
      onTap: () => _onTabSelected(index),
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

// class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
//   int _selectedIndex = 0;

//   // List of custom widgets for each tab
//   final List<String> _tabTitles = [
//     'My Courses',
//     'Services',
//     'Blog',
//     'Community',
//     'Categories',
//   ];

//   // Function to handle tab selection
//   void _onTabSelected(int index) {
//     setState(() {
//       _selectedIndex = index;
//        if(_selectedIndex==0)
//       {
//           Navigator.of(context)
//         .pushNamed(
//       MyCourseScreen.route,
    
//     )
//         .then((value) {
      
//     });
//       }else
//       if(_selectedIndex==2)
//       {
//           Navigator.of(context)
//         .pushNamed(
//       BlogsScreen.route,
    
//     )
//         .then((value) {
      
//     });
//       }else if(_selectedIndex==1)
//       {
//           Navigator.of(context)
//         .pushNamed(
//       AspiringTrainingScreen.route,
    
//     )
//         .then((value) {
      
//     });
//       } 
    
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: SizeConfig.blockSizeVertical * 11.5, // Adjust height based on your design
//       decoration: BoxDecoration(
//         color: CraftColors.neutralBlue800,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),  // Curved top-left corner
//           topRight: Radius.circular(30), // Curved top-right corner
//         ),
//       ),
//       child: BottomAppBar(
//         elevation: 0,
//         color: Colors.transparent, // Transparent to show the custom curve below
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Home Tab
//             _buildTabIcon(Icons.home, _tabTitles[0], 0),
//             // Services Tab
//             _buildTabIcon(Icons.search, _tabTitles[1], 1),
//             const SizedBox(width: 40), // Space for the Floating Action Button (FAB)
//             // Blog Tab
//             _buildTabIcon(Icons.notifications, _tabTitles[2], 2),
//             // Community Tab
//             _buildTabIcon(Icons.settings, _tabTitles[3], 3),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper function to build a tab icon with text
//   Widget _buildTabIcon(IconData icon, String title, int index) {
//     return GestureDetector(
//       onTap: () => _onTabSelected(index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: _selectedIndex == index ? Colors.white : Colors.grey, // Change color based on selection
//           ),
//           Text(
//             title,
//             style: TextStyle(
//               color: _selectedIndex == index ? Colors.white : Colors.grey, // Change text color based on selection
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
