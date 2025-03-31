// import 'package:craft_school/providers/CategoryListProvider.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/craft_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class FilterCategory extends StatefulWidget {
//   const FilterCategory({super.key});

//   @override
//   _FilterCategoryState createState() => _FilterCategoryState();
// }

// class _FilterCategoryState extends State<FilterCategory> {
//   // Variable to store the selected FilterCategory ID, initially set to null (no category selected)
//   int? selectedCategoryId;

//   // Show category filter modal
//   void ShowCategoryFilter() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: CraftColors.neutralBlue850,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (BuildContext context) {
//         return Consumer<CategoryListProvider>(
//           builder: (context, provider, child) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   // Title of the BottomSheet
//                   Text(
//                     "Select Categories to see Saved course category wise",
//                     style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
//                   ),
//                   SizedBox(height: 10),

//                   // List of radio buttons for categories
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: provider.categoryList.length, // Use provider's category list
//                       itemBuilder: (context, index) {
//                         return RadioListTile<int>(
//                           dense: true,
//                           activeColor: CraftColors.secondary100,
//                           title: Text(
//                             provider.categoryList[index].categoryName, // Show actual category name
//                             style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 12),
//                           ),
//                           value: provider.categoryList[index].id, // Set value to category ID
//                           groupValue: selectedCategoryId, // Set the selected category ID here
//                           onChanged: (int? value) {
//                             setState(() {
//                               selectedCategoryId = value; // Update selected category ID
//                             });
//                           },
//                         );
//                       },
//                     ),
//                   ),

//                   // Apply Button to handle the filter
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle "Apply" button click (pass the selected category ID)
//                       print("Selected category ID: $selectedCategoryId");
//                       // You can pass these selected category IDs to your provider or any other action
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(double.infinity, 50), // Full-width button
//                       backgroundColor: CraftColors.neutralBlue800,
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: Text(
//                       "Apply",
//                       style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: ShowCategoryFilter, // Call to show bottom sheet
//           child: Text("Open Category Filter"),
//         ),
//       ),
//     );
//   }
// }
