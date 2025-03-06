import 'dart:async';

import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/onboarding_screen.dart';
import 'package:craft_school/utils/SPManager.dart';
import 'package:craft_school/utils/UtilityFile.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    Utility().loadAPIConfig(context);
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    navigationFun();
  }

  navigationFun() async {
    String? token = await SPManager().getAuthToken();
    if (token != "") {
      Timer(
          Duration(seconds: 5),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LandingScreen())));
    } else {
      Timer(
          Duration(seconds: 5),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OnboardingScreen())));
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the AnimationController first!
    super.dispose(); // Call super.dispose() after disposing of the controller.
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: CraftColors.black18,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              CraftImagePath.splashLogo,
              height: height / 6,
              width: height / 6,
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      CraftImagePath.loadingStripsimage,
                    ), // Your loading strip image
                  ),
                ),
                width: 200,
                height: 5,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Transform.translate(
                          offset: Offset(
                            _animation.value *
                                    MediaQuery.of(context).size.width +
                                (index * 300), // Horizontal movement
                            0,
                          ),
                          child: Image.asset(
                            CraftImagePath.loadingStripsimage,
                            width: 300,
                            height: 50,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
