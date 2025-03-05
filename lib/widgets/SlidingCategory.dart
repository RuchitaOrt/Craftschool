import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlidingCategory extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpansion; // Callback to handle expansion toggle

  const SlidingCategory({
    Key? key,
    required this.isExpanded,
    required this.onToggleExpansion,
  }) : super(key: key);

  @override
  _SlidingCategoryState createState() => _SlidingCategoryState();
}

class _SlidingCategoryState extends State<SlidingCategory> {
  // Store the index of the expanded category (null means no category is expanded)
  String? expandedCategory;

  // Toggle expansion state for a given category
  void toggleCategoryExpansion(String category) {
    setState(() {
      if (expandedCategory == category) {
        expandedCategory = null; // Collapse the category if it's already expanded
      } else {
        expandedCategory = category; // Expand the clicked category
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: 0,
      right: 0,
      top: 0, // Position just below the AppBar
      height: widget.isExpanded ? SizeConfig.blockSizeVertical*60 : 0, // Expand or collapse height
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: widget.isExpanded ? SizeConfig.blockSizeVertical*60 : 0,
        color: CraftColors.neutralBlue800,
        child: Column(
          children: [
            if (widget.isExpanded)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: [
                    // Dynamically generate categories with expansion behavior
                    for (var category in [
                      'Popular',
                      'Cinematography',
                      'Script writing',
                      'Models Casting'
                    ])
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => toggleCategoryExpansion(category),
                            child: Container(
                              decoration: BoxDecoration(
                                color: expandedCategory == category
                                    ? CraftColors.neutralBlue750 // Green background for expanded category and subcategories
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                dense: true,
                                leading: SvgPicture.asset(CraftImagePath.acting),
                                title: Text(
                                  category,
                                  style: CraftStyles.tsWhiteNeutral50W60016.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: Icon(
                                  expandedCategory == category
                                      ? Icons.arrow_drop_up // Arrow up when expanded
                                      : Icons.arrow_drop_down, // Arrow down when collapsed
                                  color: CraftColors.neutral100,
                                ),
                              ),
                            ),
                          ),
                          // If the category is expanded, show the subcategories
                          if (expandedCategory == category)
                            Container(
                              color: CraftColors.neutralBlue750 , // Green background for the subcategories block
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemCount: 4, // Use the length of the list
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: SizeConfig.blockSizeHorizontal * 100,
                                      decoration: BoxDecoration(
                                        color: CraftColors.neutralBlue750 , // Green background for each subcategory
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal * 20,
                                              height: SizeConfig.safeBlockVertical * 5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                image: DecorationImage(
                                                  image: AssetImage(CraftImagePath.image9),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeConfig.blockSizeHorizontal * 2,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: SizeConfig.blockSizeHorizontal * 70,
                                                  child: Text(
                                                    "Embrace Eco-Friendly Living & Gardening",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: CraftStyles.tsWhiteNeutral50W700.copyWith(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig.blockSizeHorizontal * 50,
                                                  child: Text(
                                                    "Vikram Ghokhale",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: CraftStyles.tsWhiteNeutral50W700.copyWith(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
