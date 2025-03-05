import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/TrendingSkill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BlogsScreen extends StatefulWidget {
  static const String route = "/blogs";
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
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
                  provider.toggleSlidingContainer(); // Trigger toggle when menu is pressed
                },
                onCategoriesPressed: () {},
                isContainerVisible: provider.isContainerVisible,
              ),
            ),
            backgroundColor: CraftColors.black18,
            bottomNavigationBar: BottomAppBarWidget(index: 2),
            floatingActionButton: FloatingActionButtonWidget(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: Stack(
              children: [
                // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 0.0, maxHeight: double.infinity),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      blogsWidget(provider),
                      TrendingSkill(imagePaths: provider.imagePaths, title: CraftStrings.strtrendingSkills, onPressed: () {}),
                      trendingMasterWidget(provider),
                    ],
                  ),
                ),
                if (provider.isContainerVisible)
                  SlidingMenu(isVisible: provider.isContainerVisible),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget blogsWidget(LandingScreenProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Blogs",
                  style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(provider.blogsItem.length, (index) {
                var blog = provider.blogsItem[index];

                // Null checks for blog data
                if (blog == null || blog['image'] == null || blog['title'] == null || blog['subtext'] == null) {
                  return Container(); // Skip this item if it's invalid
                }

                bool isExpanded = blog['isExpanded'] ?? false;

                return Container(
                  margin: EdgeInsets.all(8),
                  width: SizeConfig.safeBlockHorizontal * 90,
                  decoration: BoxDecoration(
                    color: CraftColors.neutralBlue800,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.toggleExpansion(index);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                width: isExpanded
                                    ? SizeConfig.safeBlockHorizontal * 80
                                    : SizeConfig.blockSizeHorizontal * 29,
                                height: isExpanded
                                    ? SizeConfig.blockSizeVertical * 24
                                    : SizeConfig.blockSizeVertical * 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: AssetImage(blog['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                            if (!isExpanded) ...[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: CraftColors.secondary100,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                "New !",
                                                style: CraftStyles.tssecondary800W500,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              provider.toggleExpansion(index);
                                            },
                                            child: SvgPicture.asset(
                                              CraftImagePath.expand,
                                              color: Colors.white,
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                      Text(
                                        blog['title'],
                                        style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
                                      ),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                      Text(
                                        blog['subtext'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 14),
                                      ),
                                      Text(
                                        "Oct 29,2024 | 5 min read",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (isExpanded) ...[
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          Container(
                            decoration: BoxDecoration(
                              color: CraftColors.secondary100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "New !",
                                style: CraftStyles.tssecondary800W500,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          Text(
                            blog['title'],
                            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          Text(
                            blog['subtext'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 14),
                          ),
                          Text(
                            "Oct 29,2024 | 5 min read",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 90,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(SizeConfig.blockSizeVertical * 90, SizeConfig.blockSizeVertical * 5),
                                backgroundColor: CraftColors.neutralBlue800,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: CraftColors.neutralBlue750, width: 2),
                                ),
                                elevation: 5,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    CraftStrings.strReadMore,
                                    style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget trendingMasterWidget(LandingScreenProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trending Masters",
                  style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(provider.trendingMasters.length, (index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  width: SizeConfig.safeBlockHorizontal * 85,
                  decoration: BoxDecoration(
                    color: CraftColors.neutralBlue800,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(provider.trendingMasters[index]['image']!,
                        width: SizeConfig.safeBlockHorizontal*28,
                        height: SizeConfig.safeBlockVertical*22,
                        fit: BoxFit.cover,),
                        SizedBox(width: SizeConfig.safeBlockHorizontal*2),
                        Container(
                           width: SizeConfig.safeBlockHorizontal*45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.trendingMasters[index]['name']!,
                                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
                              ),
                              SizedBox(height: SizeConfig.safeBlockVertical*1,),
                              Text(
                            provider.trendingMasters[index]['subtitle']!,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                          ),
                           SizedBox(height: SizeConfig.safeBlockVertical*1,),
                          Row(children: [
                              Container(
                                            decoration: BoxDecoration(
                                              color: CraftColors.secondary100,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                "Direction",
                                                style: CraftStyles.tssecondary800W500.copyWith(fontSize: 10),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: SizeConfig.blockSizeHorizontal*1,),
                                            Container(
                                            decoration: BoxDecoration(
                                              color: CraftColors.secondary100,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                "Script Writing",
                                                style: CraftStyles.tssecondary800W500.copyWith(fontSize: 10),
                                              ),
                                            ),
                                          ),
                          ],),
SizedBox(height: SizeConfig.blockSizeVertical*1,),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(SizeConfig.blockSizeVertical * 60, SizeConfig.blockSizeVertical * 4),
                                backgroundColor: CraftColors.neutralBlue750,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: CraftColors.neutralBlue750, width: 2),
                                ),
                                elevation: 5,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    CraftStrings.strSeeAllCourses,
                                    style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
