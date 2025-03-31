import 'dart:io';

import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CategoryListProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';

class CategoryCourseWidget extends StatefulWidget {
    static const String route = "/allCategroy";
  @override
  _CategoryCourseWidgetState createState() => _CategoryCourseWidgetState();
}

class _CategoryCourseWidgetState extends State<CategoryCourseWidget> {


 @override
  void initState() {
    super.initState();
    getAPI();
    // Ensure data is fetched after the widget is built
  }
 int indexofcategoryselected = 0; // Default to the "All" option (index 0)
  getAPI() async {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only call the API if it's not already loading
      final provider =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!provider.isSubscriptionLoading) {
        provider
            .getcheckSubscriptionIndividualFlowWiseInfoAPI()
            .then((value) async {
          
        
        });
      }
   final categoryprovider =
                  Provider.of<CategoryListProvider>(context, listen: false);
              print("Token getting getCategoryList");
              
              if (!categoryprovider.isLoading) {
                categoryprovider.getCategoryList().then((value)
                {
 if (!categoryprovider.isCategoryWiseLoading) {
                    print("getCategoryList 1");
                if (categoryprovider.categoryList.isNotEmpty) {
                   print("getCategoryList 2");
                  categoryprovider.getCategoryWiseList([categoryprovider.categoryList[0].id]);
                }
              }
                });
              }
    });
  }


  @override
  Widget build(BuildContext context) {
    print("tokenlanding");
    return
Consumer<LandingScreenProvider>(
      builder: (context, provider, _) {
        // Show loading spinner while fetching data
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
    return Scaffold(
  appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              isContainerVisible: provider.isContainerVisible,
              isCategoryVisible: provider.isCategoryVisible,
              onMenuPressed: () {
                provider
                    .toggleSlidingContainer(); // Trigger toggle when menu is pressed
              },
              onCategoriesPressed: () {
                provider.toggleSlidingCategory();
              },
            ),
          ),
          backgroundColor: CraftColors.black18,
      body: Stack(
        children: [
          Consumer<CategoryListProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
          
              return provider.categoryList.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                        children: [
                          Text(
                            CraftStrings.strAllCategory,
                            style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          
                          // Add the chip list for selection
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Wrap(
                                    spacing: 8.0, // Space between chips
                                    runSpacing: 4.0, // Space between lines
                                    children: List.generate(
                                      provider.categoryList.length,
                                      (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            provider.onCategorySingleChipSelected!(
                                                provider.categoryList[index].id.toString());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: CraftColors.neutralBlue800,
                                              border: Border.all(
                                                color: provider.selectedSingleChips == (provider.categoryList[index].id.toString())
                                                    ? CraftColors.secondary550
                                                    : CraftColors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.network(
                                                  provider.categoryList[index].icon,
                                                  height: 15.0,
                                                  width: 15.0,
                                                  color: provider.selectedSingleChips == (provider.categoryList[index].id.toString())
                                                      ? CraftColors.secondary550
                                                      : CraftColors.white,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  provider.categoryList[index].categoryName,
                                                  style: TextStyle(
                                                    color: provider.selectedSingleChips == (provider.categoryList[index].id.toString())
                                                        ? CraftColors.secondary550
                                                        : CraftColors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          
                          // Show content below the selected chip
                          provider.categoryWiseList.isEmpty
                              ?  Center(child: Text("Coming Soon", style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),))
                              : GridView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns
                                  crossAxisSpacing: 8.0, // Horizontal space between items
                                  mainAxisSpacing: 8.0, // Vertical space between items
                                  childAspectRatio: Platform.isAndroid?0.63: 0.65, // Adjust the size ratio of each grid item
                                ),
                                itemCount: provider.categoryWiseList.length,
                                itemBuilder: (context, index) {
                                  var course = provider.categoryWiseList[index];
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(routeGlobalKey.currentContext!)
                                              .pushNamed(Coursedetailscreen.route, arguments: course.slug)
                                              .then((value) {});
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(8),
                                              width: SizeConfig.safeBlockHorizontal * 40,
                                              height: SizeConfig.blockSizeVertical * 23,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                image: DecorationImage(
                                                  image: NetworkImage(course.courseBannerMobile),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 8, top: 8),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: SizeConfig.safeBlockHorizontal * 40,
                                                  child: Text(
                                                    course.name,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 13),
                                                  ),
                                                ),
                                                SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 15.0,
                                                      backgroundImage: NetworkImage(course.masterProfilePhoto),
                                                    ),
                                                    SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                                                    Text(
                                                      course.instructor,
                                                      style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                        GlobalLists.authtoken!=""?    Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  //check here
                  print("categoryWiseList");
                   if (provider.categoryWiseList[index].savedFlag) {
                                  
                           
                                    provider.unSaveCategoryCourse(index);
                                   
                                  } else {
                                    provider.saveCategoryCourse(index);
                                  
                                  }
                 
                },
                child: provider.categoryWiseList[index].savedFlag
                    ? SvgPicture.asset(
                        CraftImagePath.save,
                        width: 22,
                        height: 22,
                      )
                    : SvgPicture.asset(
                        CraftImagePath.saved,
                        width: 22,
                        height: 22,
                      ),
              ),
            ):Container(),
                                    ],
                                  );
                                },
                              ),
                        ],
                      ),
                    );
            },
          ),
           if (provider.isContainerVisible)
                SlidingMenu(isVisible: provider.isContainerVisible),
              if (provider.isCategoryVisible)
                SlidingCategory(
                  isExpanded: provider.isCategoryVisible,
                  onToggleExpansion: provider.toggleSlidingCategory,
                ),
        ],
      ),
    );
      });
  }
}
