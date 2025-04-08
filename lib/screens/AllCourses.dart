import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';

import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/ImageGridViewCourses.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCourses extends StatefulWidget {
  static const String route = "/allCoursesScreen";
  const AllCourses({Key? key}) : super(key: key);

  @override
  _AllCoursesState createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
print("MYBOttom");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only call the API if it's not already loading
final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription
            .getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }

      final provider = Provider.of<CoursesProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getCourseAPI();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingScreenProvider(),
      child: Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
          return WillPopScope(
              onWillPop: ()async
      {
        provider.onBackPressed();
        return false;
      },

            child: Scaffold(
               bottomNavigationBar: BottomAppBarWidget(index: 1,),
                  floatingActionButton: FloatingActionButtonWidget(isOnLandingScreen: false,),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(
                  isCategoryVisible: provider.isCategoryVisible,
                  onMenuPressed: () {
                    provider
                        .toggleSlidingContainer(); // Trigger toggle when menu is pressed
                  },
                  onCategoriesPressed: () {
                    provider.toggleSlidingCategory();
                  },
                  isContainerVisible: provider.isCategoryVisible,
                isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
                ),
              ),
              backgroundColor: CraftColors.black18,
              // bottomNavigationBar: BottomAppBarWidget(
              // index: 0,
              // ),
              // floatingActionButton: FloatingActionButtonWidget(),
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerDocked,
              body: Stack(
                children: [
                  // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
                  Consumer<CoursesProvider>(builder: (context, provider, child) {
                    return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Courses",
                            style: CraftStyles.tsWhiteNeutral50W700
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        ImageGridViewCourses(
                         imagePaths: provider.courseList,
                         onSaveButtonOnTap: (index) {
                           provider.savedCourseAPI(
                               provider.courseList[index].courseId);
                              provider.saveAllCourse(index);
                         },
                          onunSaveButtonOnTap: (index) {
                           provider.unSavedCourseAPI(
                               provider.courseList[index].courseId);
                              provider.unSaveAllCourse(index);
                         },
            
                                                ),
                        if (provider.courseList.length != provider.totalLength)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Call the API to fetch more blogs
                                  provider.getCourseAPI();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CraftColors.neutralBlue800,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "View More",
                                  style: CraftStyles.tsWhiteNeutral50W60016
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                  if (provider.isContainerVisible)
                    SlidingMenu(isVisible: provider.isContainerVisible),
                  if (provider.isCategoryVisible)
                    SlidingCategory(
                      isExpanded: provider.isCategoryVisible,
                      onToggleExpansion: provider.toggleSlidingCategory,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
