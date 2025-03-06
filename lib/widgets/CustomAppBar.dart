import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/sizeConfig.dart';

class CustomAppBar extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final bool isContainerVisible;
  final bool isCategoryVisible;
  final VoidCallback onCategoriesPressed;

  const CustomAppBar({
    super.key,
    required this.onMenuPressed,
    required this.isContainerVisible,
    required this.onCategoriesPressed,
    required this.isCategoryVisible,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  late Animation<double> _menuRotationAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for the menu icon
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Rotation animation for the menu icon
    _menuRotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5, // Rotate 180 degrees (0.5 turns)
    ).animate(CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger animation when the menu visibility changes
    if (widget.isContainerVisible != oldWidget.isContainerVisible) {
      if (widget.isContainerVisible) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CraftColors.neutralBlue800,
      elevation: 2, // Add a subtle shadow
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CraftColors.neutralBlue800,
              CraftColors.neutralBlue850,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
          child: Row(
            children: [
              // Logo on the left
              SvgPicture.asset(
                CraftImagePath.fridauCraftBlue,
                height: 30,
              ),
              const Spacer(),

              // Categories Dropdown Button
              GestureDetector(
                onTap: widget.onCategoriesPressed,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Icon(
                          widget.isCategoryVisible
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          key: ValueKey<bool>(widget.isCategoryVisible),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Menu icon with rotation animation
              RotationTransition(
                turns: _menuRotationAnimation,
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: widget.onMenuPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
