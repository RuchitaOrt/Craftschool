import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/a.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
        .pushNamed(
      LandingScreen.route,
    
    )
        .then((value) {
      
    });
      },
      backgroundColor: CraftColors.neutralBlue750, // Icon inside the FAB
      elevation: 5, // Adds shadow to the button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50), // Ensures the button remains circular
      ), // Custom background color
      child:  Icon(Icons.home,color: CraftColors.white,),
    );
  }
}
