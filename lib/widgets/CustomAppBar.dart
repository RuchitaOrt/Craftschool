import 'dart:async';
import 'dart:io';

import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final bool isContainerVisible;
  final VoidCallback isSearchClickVisible;
  final bool isSearchValueVisible;
  final bool isCategoryVisible;
  final VoidCallback onCategoriesPressed;

  CustomAppBar({
    super.key,
    required this.onMenuPressed,
    required this.isContainerVisible,
    required this.onCategoriesPressed,
    required this.isCategoryVisible,
    required this.isSearchClickVisible,
   required  this.isSearchValueVisible,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void _onSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel(); // Cancel previous timer

    _debounce = Timer(const Duration(milliseconds: 500), () { // Debounce API call
      if (query.isNotEmpty) {
        Provider.of<LandingScreenProvider>(routeGlobalKey.currentContext!, listen: false)
            .getSearchList(query);
      }
    });

    setState(() {
      searchController.text = query; // Ensure text remains in field
      searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: searchController.text.length), // Keeps cursor at the end
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LandingScreenProvider>(context);
  print("toggleSearchIconCategory appbar");
  print(provider.isSearchIconVisible);
  print("toggleSearchIconCategory appbar");
  print(provider.isSearchIconVisible);
    return AppBar(
      backgroundColor: CraftColors.neutralBlue800,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace:
      //  provider.isSearchIconVisible
          // ? Padding(
          //   padding: const EdgeInsets.only(top: 5),
          //   child: _buildSearchBar(),
          // )
          // :
           Padding(
              padding: EdgeInsets.only(top: Platform.isAndroid ? 45 : 60, left: 8),
              child: Row(
                children: [
                  SvgPicture.asset(
                    CraftImagePath.fridauCraftBlue,
                    height: 30,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: widget.onCategoriesPressed,
                    child: Row(
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: widget.isCategoryVisible
                              ? Icon(Icons.keyboard_arrow_up)
                              : Icon(Icons.keyboard_arrow_down),
                          onPressed: widget.onCategoriesPressed,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 0.1),
                  IconButton(
                    icon: const Icon(Icons.search,size: 25,),
                    onPressed: widget.isSearchClickVisible,
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 0.1),
                  IconButton(
                    icon: widget.isContainerVisible ? Icon(Icons.close) : Icon(Icons.menu),
                    onPressed: widget.onMenuPressed,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: widget.isSearchClickVisible,
          ),
        ),
        Expanded(
          child: CustomTextFieldWidget(
            textFieldContainerHeight: 40,
            title: "",
            hintText: CraftStrings.strSearch,
            textEditingController: searchController,
            autovalidateMode: AutovalidateMode.disabled,
            onChange: _onSearch, // Text remains while API is called
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.search, color: CraftColors.neutral100),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
      ],
    );
  }
}

// import 'dart:async';
// import 'dart:io';

// import 'package:craft_school/common_widget/custom_text_field_widget.dart';
// import 'package:craft_school/main.dart';
// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/craft_images.dart';
// import 'package:craft_school/utils/craft_strings.dart';
// import 'package:craft_school/utils/sizeConfig.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class CustomAppBar extends StatelessWidget {
//   final VoidCallback onMenuPressed;
//   final bool isContainerVisible;
//    final VoidCallback? isSearchClickVisible;
//       final bool? isSearchValueVisible;
//    final bool isCategoryVisible;
//   final VoidCallback onCategoriesPressed;

//    CustomAppBar({super.key, required this.onMenuPressed, required this.isContainerVisible, required this.onCategoriesPressed, required this.isCategoryVisible,  this.isSearchClickVisible, this.isSearchValueVisible});
//  bool isSearchActive = false; // Controls search UI visibility
//   final TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: CraftColors.neutralBlue800,
//       elevation: 0,
//       automaticallyImplyLeading: false, 
//       flexibleSpace:isSearchValueVisible!
//           ? Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: _buildSearchBar(),
//           ): Padding(
//         padding:  EdgeInsets.only(top:Platform.isAndroid?45: 60, left: 8),
//         child:  Row(
//           children: [
//             // Image on the left
//             SvgPicture.asset(
//               CraftImagePath.fridauCraftBlue,
//               height: 30,
//             ),
//             // Spacer between the image and the menu
//             Spacer(),

//             // Categories Dropdown Button
//             GestureDetector(
//               onTap: onCategoriesPressed, // Expand or collapse the list when clicked
//               child: Row(
//                 children: [
//                   Text(
//                     "Categories", 
//                     style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//               icon: isCategoryVisible ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down),
//               onPressed: onCategoriesPressed
//               // Trigger the toggle of the sliding menu
//             ),
//                 ],
//               ),
//             ),
//             SizedBox(width: SizeConfig.blockSizeVertical*0.1),


//             // Search Button
//             IconButton(
//               icon: const Icon(Icons.search, color: Colors.white),
//               onPressed:
//               isSearchClickVisible
//               //  () {
//               //   isSearchActive = true;
//               //   // Navigator.push(
//               //   //   context,
//               //   //   MaterialPageRoute(builder: (context) => const SearchScreen()), // Open Search Screen
//               //   // );
//               // },
//             ),
//              const SizedBox(width: 8),
//             // Menu icon on the right
//             IconButton(
//               icon: isContainerVisible ? Icon(Icons.close) : Icon(Icons.menu),
//               onPressed: onMenuPressed, // Trigger the toggle of the sliding menu
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// Timer? _debounce;
//  void _onSearch(String query) {
//     if (_debounce?.isActive ?? false) _debounce!.cancel(); // Cancel previous timer

//     _debounce = Timer(const Duration(milliseconds: 500), () { // Debounce API call
//       if (query.isNotEmpty) {
//         Provider.of<LandingScreenProvider>(routeGlobalKey.currentContext!, listen: false)
//             .getSearchList(query);
//       }
//     });
//   }


//    Widget _buildSearchBar() {
//     return Row(
//       children: [
//         // Back button to close search
//         Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed:  isSearchClickVisible,
//           ),
//         ),
    
//         // Search Input Field
//         Expanded(
//           child: CustomTextFieldWidget(
//             title: "",
//             hintText: CraftStrings.strSearch,
//             onChange:_onSearch,
//             textEditingController: searchController,
//             autovalidateMode: AutovalidateMode.disabled,
//             suffixIcon: Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: const Icon(Icons.search, color: CraftColors.neutral100),
//             ),
//           ),
//         ),
//         SizedBox(width: SizeConfig.blockSizeHorizontal*2,)
//       ],
//     );
//   }
// }
