import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CategoryListProvider.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/screens/AllCourses.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/BrowseTrendingCourse.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/VideoThumbnail.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class Video {
  final String url;
  final String thumbnail;
  final String title;
  final String subtitle;
  final String description;

  Video({
    required this.url,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class SavedCourseScreen extends StatefulWidget {
  static const String route = "/savedVideoListscreen";

  @override
  _SavedCourseScreenState createState() => _SavedCourseScreenState();
}

class _SavedCourseScreenState extends State<SavedCourseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }

      if (GlobalLists.authtoken != "") {
        final provider = Provider.of<CoursesProvider>(context, listen: false);

        if (!provider.isSavedLoading) {
          provider.getSavedCourseAPI("");
        }
      }

      final providermaster =
          Provider.of<MasterAllProvider>(context, listen: false);
      if (!providermaster.isLoading) {
        providermaster.getTrendingClassAPI();
      }
      final categoryprovider =
          Provider.of<CategoryListProvider>(context, listen: false);

      if (!categoryprovider.isLoading) {
        categoryprovider.getCategoryList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget browseOtherCourse() {
    return Consumer<MasterAllProvider>(
      builder: (context, provider, child) {
         if(provider.isLoading)
      {
        return Center(child: CircularProgressIndicator());
      }
        return provider.trendingClassData.isEmpty
            ? Container()
            : BrowseTrendingCourse(
                imagePaths: provider.trendingClassData,
                title: CraftStrings.strTrendingClass,
                onPressed: () {},
                 onSaveButtonOnTap: (index) {
                  provider.saveTrendingCourse(index);
                },
                onunSaveButtonOnTap: (index) {
                  provider.unsaveTrendingCourse(index);
                },
              );
      },
    );
  }

  Widget bannerImages() {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 40,
      child: Container(
        margin: EdgeInsets.all(8),
        width: SizeConfig.safeBlockHorizontal * 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
                image: AssetImage(
                  CraftImagePath.backgroundCourses,

                  // Get image from the provider list
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Image.asset(
                CraftImagePath.cards,
                width: SizeConfig.blockSizeHorizontal * 30,
                height: SizeConfig.blockSizeVertical * 10,
              ),
              Text(
                "Your saved list is waiting for its first star!",
                style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Text(
                "Looks like you haven’t saved any courses yet. Start exploring!",
                style: CraftStyles.tsWhiteNeutral200W500.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Center(
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(routeGlobalKey.currentContext!)
                          .pushNamed(
                            AllCourses.route,
                          )
                          .then((value) {});
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(SizeConfig.blockSizeVertical * 40,
                          SizeConfig.blockSizeVertical * 4),
                      backgroundColor: CraftColors.primaryBlue500,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add some spacing between icon and text
                        Text(
                          CraftStrings.strBrowseCourse,
                          style: CraftStyles.tsWhiteNeutral50W60016,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return Scaffold(
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
                isContainerVisible: provider.isContainerVisible,
                 isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
              ),
            ),
            backgroundColor: CraftColors.black18,
            // bottomNavigationBar: BottomAppBarWidget(
            // index: -1,
            // ),
            // floatingActionButton: FloatingActionButtonWidget(),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked,
            body: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(height: SizeConfig.blockSizeVertical * 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                CraftStrings.strSavedCourses,
                                style: CraftStyles.tsWhiteNeutral50W700
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 38,
                              child: ElevatedButton(
                                onPressed: () {
                                  ShowCategoryFilter();
                                }, // Trigger the action when pressed
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      SizeConfig.blockSizeVertical * 38,
                                      SizeConfig.blockSizeVertical * 4),
                                  backgroundColor: CraftColors.neutralBlue800,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      CraftStrings.strCategory,
                                      style: CraftStyles.tsWhiteNeutral50W60016
                                          .copyWith(fontSize: 12),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: CraftColors.neutral100,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 0.30),
                        GlobalLists.authtoken != ""
                            ? Consumer<CoursesProvider>(
                                builder: (context, provider, child) {
                                   if(provider.isSavedLoading)
      {
        return Center(child: CircularProgressIndicator());
      }
                                return Container(
                                  height: SizeConfig.blockSizeVertical * 40,
                                  child: provider.savedcourseList.isEmpty
                                      ? bannerImages()
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              provider.savedcourseList.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(routeGlobalKey
                                                        .currentContext!)
                                                    .pushNamed(
                                                        Coursedetailscreen
                                                            .route,
                                                        arguments: provider
                                                            .savedcourseList[
                                                                index]
                                                            .slug)
                                                    .then((value) {});
                                              },
                                              child: Stack(
                                                children: [
                                                  Card(
                                                    color: CraftColors
                                                        .neutralBlue850,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 8),
                                                    child: Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          50,
                                                      child: Column(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: CraftColors
                                                                      .neutralBlue800,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              16)),
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(provider
                                                                          .savedcourseList[
                                                                              index]
                                                                          .courseBannerMobile),
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    28,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: CraftStyles.getTagBackgroundColor(provider
                                                                      .savedcourseList[
                                                                          index].tagName),
                                                                        borderRadius: BorderRadius.circular(8),
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(4.0),
                                                                        child: Text(
                                                                         provider
                                                                      .savedcourseList[
                                                                          index].tagName,
                                                                          style: CraftStyles.getTagTextStyle(provider
                                                                      .savedcourseList[
                                                                          index].tagName),
                                                                        ),
                                                                      ),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: SizeConfig
                                                                          .blockSizeVertical *
                                                                      1,
                                                                ),
                                                                Text(
                                                                  provider
                                                                      .savedcourseList[
                                                                          index]
                                                                      .shortDescription,
                                                                  style: CraftStyles
                                                                      .tsWhiteNeutral50W600,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        SizeConfig.blockSizeVertical *
                                                                            2),
                                                                Row(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius:
                                                                          16.0,
                                                                      backgroundImage: NetworkImage(provider
                                                                          .savedcourseList[
                                                                              index]
                                                                          .masterProfilePhoto),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              2,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              32,
                                                                      child:
                                                                          Text(
                                                                        provider
                                                                            .savedcourseList[index]
                                                                            .instructor,
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: CraftStyles
                                                                            .tsWhiteNeutral50W700
                                                                            .copyWith(fontSize: 12),
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
                                                  ),
                                                  Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () {
          provider.unSavedCourseAPI(provider.savedcourseList[index].courseId);
          if (!provider.isSavedLoading) {
            provider.getSavedCourseAPI("");
          }
        },
        child: Icon(
          Icons.close,
          color: CraftColors.neutral100,
        ),
      ),
    ),
                                                  // GestureDetector(
                                                  //     onTap: () {
                                                  //       provider.unSavedCourseAPI(
                                                  //           provider
                                                  //               .savedcourseList[
                                                  //                   index]
                                                  //               .courseId);
                                                  //       if (!provider
                                                  //           .isSavedLoading) {
                                                  //         provider
                                                  //             .getSavedCourseAPI(
                                                  //                 "");
                                                  //       }
                                                  //     },
                                                  //     child: Align(
                                                  //       alignment:
                                                  //           Alignment.topRight,
                                                  //       child: Padding(
                                                  //         padding:
                                                  //             const EdgeInsets
                                                  //                 .all(8.0),
                                                  //         child: Icon(
                                                  //           Icons.close,
                                                  //           color: CraftColors
                                                  //               .neutral100,
                                                  //         ),
                                                  //       ),
                                                  //     ))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                );
                              })
                            : bannerImages(),
                        browseOtherCourse()
                      ],
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
        }));
  }

  int? selectedCategoryId;

  ShowCategoryFilter() {
    // Variable to store the selected category ID, set it to null initially (no category selected)

    return showModalBottomSheet(
      context: context,
      backgroundColor: CraftColors.neutralBlue850,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Consumer<CategoryListProvider>(
          builder: (context, provider, child) {
            return StatefulBuilder(
              // Use StatefulBuilder to manage state inside the BottomSheet
              builder: (BuildContext context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Title of the BottomSheet
                      Text(
                        "Select Categories to see Saved course category wise",
                        style: CraftStyles.tsWhiteNeutral50W700
                            .copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 10),

                      // List of radio buttons for categories
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.categoryList
                              .length, // Use provider's category list
                          itemBuilder: (context, index) {
                            return RadioListTile<int>(
                              dense: true,
                              activeColor: CraftColors.secondary100,
                              title: Text(
                                provider.categoryList[index]
                                    .categoryName, // Show actual category name
                                style: CraftStyles.tsWhiteNeutral50W700
                                    .copyWith(fontSize: 12),
                              ),
                              value: provider.categoryList[index]
                                  .id, // Set value to category ID
                              groupValue:
                                  selectedCategoryId, // Set the selected category ID here
                              onChanged: (int? value) {
                                setState(() {
                                  selectedCategoryId =
                                      value; // Update selected category ID locally
                                });
                              },
                            );
                          },
                        ),
                      ),

                      // Apply Button to handle the filter
                      ElevatedButton(
                        onPressed: () {
                          // Handle "Apply" button click (pass the selected category ID)
                          print("Selected category ID: $selectedCategoryId");
                          final provider = Provider.of<CoursesProvider>(context,
                              listen: false);

                          if (!provider.isSavedLoading) {
                            provider.getSavedCourseAPI(
                                selectedCategoryId.toString());
                          }
                          
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(double.infinity, 50), // Full-width button
                          backgroundColor: CraftColors.neutralBlue800,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          "Apply",
                          style: CraftStyles.tsWhiteNeutral50W60016
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
