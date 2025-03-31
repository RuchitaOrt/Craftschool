import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CategoryListProvider.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlidingCategory extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpansion;

  const SlidingCategory({
    Key? key,
    required this.isExpanded,
    required this.onToggleExpansion,
  }) : super(key: key);

  @override
  _SlidingCategoryState createState() => _SlidingCategoryState();
}

class _SlidingCategoryState extends State<SlidingCategory> {
  String? expandedCategory;

  void toggleCategoryExpansion(String category) {
    setState(() {
      if (expandedCategory == category) {
        expandedCategory = null;
      } else {
        expandedCategory = category;
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch category data from the provider
    final categoryProvider = Provider.of<CategoryListProvider>(context);
    
    if (categoryProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: 0,
      right: 0,
      top: 0,
      height: widget.isExpanded ? SizeConfig.blockSizeVertical * 60 : 0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: widget.isExpanded ? SizeConfig.blockSizeVertical * 60 : 0,
        color: CraftColors.neutralBlue800,
        child: Column(
          children: [
            if (widget.isExpanded)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: [
                    for (var category in categoryProvider.categoryList) // Dynamically generate categories
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              categoryProvider.getCategoryWiseList([category.id]);
                               toggleCategoryExpansion(category.categoryName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: expandedCategory == category.categoryName
                                    ? CraftColors.neutralBlue750
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                dense: true,
                                leading: SvgPicture.asset(CraftImagePath.acting),
                                title: Text(
                                  category.categoryName,
                                  style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                ),
                                trailing: Icon(
                                  expandedCategory == category.categoryName
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: CraftColors.neutral100,
                                ),
                              ),
                            ),
                          ),
                          if (expandedCategory == category.categoryName)
                            Container(
                              color: CraftColors.neutralBlue750,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemCount: categoryProvider.categoryWiseList.length,
                                itemBuilder: (context, index) {
                                  // return Text("kk");
                                  var subCategory = categoryProvider.categoryWiseList[index];
                                  return GestureDetector(
                                    onTap: ()
                                    {
                                         Navigator.of(routeGlobalKey.currentContext!)
                                      .pushNamed(Coursedetailscreen.route,
                                          arguments:
                                              subCategory.slug)
                                      .then((value) {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: SizeConfig.blockSizeHorizontal * 100,
                                        decoration: BoxDecoration(
                                          color: CraftColors.neutralBlue750,
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: SizeConfig.blockSizeHorizontal * 15,
                                                height: SizeConfig.safeBlockVertical * 5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                    image: NetworkImage(subCategory.courseBannerMobile),
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
                                                      subCategory.name,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: CraftStyles.tsWhiteNeutral50W700.copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: SizeConfig.blockSizeHorizontal * 50,
                                                    child: Text(
                                                      subCategory.masterName,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: CraftStyles.tsWhiteNeutral50W700.copyWith(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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

