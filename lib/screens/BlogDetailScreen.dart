import 'package:craft_school/providers/BlogProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/BrowseOtherCourse.dart';
import 'package:craft_school/widgets/BrowseRelatedBlog.dart';
import 'package:craft_school/widgets/BrowseTrendingCourse.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/TrendingSkill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class BlogDetailScreen extends StatefulWidget {
  final String slug;
  static const String route = "/blogDetailScreen";
  const BlogDetailScreen({Key? key, required this.slug}) : super(key: key);

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
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
      // Only call the API if it's not already loading
      final provider = Provider.of<BlogProvider>(context, listen: false);
      if (!provider.isLoading) {
        print("getBlogsDetailAPI");

        provider.getBlogsDetailAPI(widget.slug);
      }
      final providermaster =
          Provider.of<MasterAllProvider>(context, listen: false);
      if (!providermaster.isLoading) {
        providermaster.getTrendingClassAPI();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingScreenProvider(),
      child: Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
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
                isContainerVisible: provider.isCategoryVisible,
              ),
            ),
            backgroundColor: CraftColors.black18,
            bottomNavigationBar: BottomAppBarWidget(
              index: 2,
            ),
            floatingActionButton: FloatingActionButtonWidget(isOnLandingScreen: false,),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: Stack(
              children: [
                // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
                Consumer<BlogProvider>(builder: (context, provider, child) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: 0.0, maxHeight: double.infinity),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                        provider.blogDetailList.isEmpty
                            ? Container()
                            : bannerImages(
                                tag: provider.blogDetailList[0].tags,
                                title: provider.blogDetailList[0].title,
                                subTitle: provider.blogDetailList[0].readTime,
                                textStyle: CraftStyles.tssecondary800W500,
                                textBackground: CraftColors.secondary100,
                                description:
                                    provider.blogDetailList[0].description,
                                image: provider.blogDetailList[0].blogImage),
                        browseLatestBlog(),
                        browseRelatedBlog(),
                        browseOtherCourse(),
                        Consumer<MasterAllProvider>(
                            builder: (context, provider, child) {
                          return provider.trendingMasterData.isEmpty
                              ? Container()
                              : TrendingSkill(
                                  imagePaths: provider.trendingMasterData,
                                  title: CraftStrings.strtrendingSkills,
                                  onPressed: () {});
                        }),
                      ],
                    ),
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
          );
        },
      ),
    );
  }

  Widget browseOtherCourse() {
    return Consumer<MasterAllProvider>(
      builder: (context, provider, child) {
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

  Widget browseRelatedBlog() {
    return Consumer<BlogProvider>(
      builder: (context, provider, child) {
        return provider.relatedBlog.isEmpty
            ? Container()
            : BrowseRelatedBlog(
                imagePaths: provider.relatedBlog,
                title: "Related Blog's",
                onPressed: () {},
              );
      },
    );
  }

  Widget browseLatestBlog() {
    return Consumer<BlogProvider>(
      builder: (context, provider, child) {
        return provider.latestBlog.isEmpty
            ? Container()
            : BrowseRelatedBlog(
                imagePaths: provider.latestBlog,
                title: "Latest Blog's",
                onPressed: () {},
              );
      },
    );
  }

  Widget bannerImages(
      {List<String>? tag,
      String? title,
      String? subTitle,
      TextStyle? textStyle,
      Color? textBackground,
      String? description,
      String? image}) {
    return SizedBox(
      // height: SizeConfig.blockSizeVertical * 40,
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.all(8),
            width: SizeConfig.safeBlockHorizontal * 80,
            height: SizeConfig.blockSizeVertical * 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                    image: NetworkImage(
                      image!,

                      // Get image from the provider list
                    ),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tag != ""
                      ? 
                      GridView.builder(
      padding: const EdgeInsets.all(12),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // so it doesn't scroll inside scrollable parent
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // You can change this as needed
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.9, // Adjust height/width ratio
      ),
      itemCount: tag!.length,
      itemBuilder: (context, index) {
        return Container(
          
          decoration: BoxDecoration(
            color: textBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child:
           Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Text(
                tag[index],
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    )
                      // Container(
                      //     decoration: BoxDecoration(
                      //       color: textBackground,
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text(
                      //         tag!,
                      //         style: textStyle,
                      //       ),
                      //     ),
                      //   )
                      : Container(),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Text(
                    title!,
                    style: CraftStyles.tsWhiteNeutral50W700,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Text(
                    subTitle!,
                    style: CraftStyles.tsWhiteNeutral200W500,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              description!,
              textStyle: CraftStyles.tsWhiteNeutral200W500,
            ),
          )
        ],
      ),
    );
  }
}
