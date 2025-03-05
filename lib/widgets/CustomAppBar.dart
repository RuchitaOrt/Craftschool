import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onMenuPressed;
  final bool isContainerVisible;
   final bool isCategoryVisible;
  final VoidCallback onCategoriesPressed;

  const CustomAppBar({super.key, required this.onMenuPressed, required this.isContainerVisible, required this.onCategoriesPressed, required this.isCategoryVisible});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CraftColors.neutralBlue800,
      elevation: 0,
      automaticallyImplyLeading: false, 
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 60, left: 8),
        child: Row(
          children: [
            // Image on the left
            SvgPicture.asset(
              CraftImagePath.fridauCraftBlue,
              height: 30,
            ),
            // Spacer between the image and the menu
            Spacer(),

            // Categories Dropdown Button
            GestureDetector(
              onTap: onCategoriesPressed, // Expand or collapse the list when clicked
              child: Row(
                children: [
                  Text(
                    "Categories", 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
              icon: isCategoryVisible ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down),
              onPressed: onCategoriesPressed
              // Trigger the toggle of the sliding menu
            ),
                ],
              ),
            ),
            SizedBox(width: SizeConfig.blockSizeVertical*0.1),

            // Menu icon on the right
            IconButton(
              icon: isContainerVisible ? Icon(Icons.close) : Icon(Icons.menu),
              onPressed: onMenuPressed, // Trigger the toggle of the sliding menu
            ),
          ],
        ),
      ),
    );
  }
}
