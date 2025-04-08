import 'package:craft_school/main.dart';
import 'package:craft_school/providers/BlogProvider.dart';
import 'package:craft_school/providers/CategoryListProvider.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/screens/BlogDetailScreen.dart';
import 'package:craft_school/screens/MasterScreenDetail.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/TrendingSkill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class BlogsScreen extends StatefulWidget {
  static const String route = "/blogs";
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {


   @override
  void initState() {
    // TODO: implement initState
    super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription
            .getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }

      // Only call the API if it's not already loading
      final provider = Provider.of<BlogProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getBlogsAPI("","",false);
      }


       final providerTreding = Provider.of<MasterAllProvider>(context, listen: false);
      if (!providerTreding.istrendingMasterLoading) {
       
        providerTreding.getTrendingMasterAPI();
  

      }

       final categoryprovider =
          Provider.of<CategoryListProvider>(context, listen: false);

      if (!categoryprovider.isLoading) {
        categoryprovider.getCategoryList();
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
                isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
              ),
            ),
              backgroundColor: CraftColors.black18,
              bottomNavigationBar: BottomAppBarWidget(index: -1,),
              floatingActionButton: FloatingActionButtonWidget(isOnLandingScreen: false,),
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
                        blogsWidget(),
                    Consumer<MasterAllProvider>(
                              builder: (context, provider, child) {
                            return
                                    TrendingSkill(imagePaths: provider.trendingMasterData, title: CraftStrings.strtrendingSkills, onPressed: () {});
                              }),
                   Consumer<MasterAllProvider>(
                              builder: (context, provider, child) {
                            return      trendingMasterWidget(provider);})
                      ],
                    ),
                  ),
                 if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
                if (provider.isCategoryVisible) SlidingCategory(
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

  Widget blogsWidget() {
    
    return 
    Consumer<BlogProvider>(
        builder: (context, provider, _) {
          if(provider.isLoading){
            return Center(child: CircularProgressIndicator());
          }
          return
    Padding(
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
                  style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
GestureDetector(
  onTap: ()
  {
    ShowCategoryFilter();
  },
  child: Padding(
    padding: const EdgeInsets.only(right: 15),
    child: Image.asset(CraftImagePath.filter,color: CraftColors.neutral100,width: 20,height: 20,),
  )),
                         
                ],)
              ],
            ),
          ),
         
  
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:provider.blogList.isEmpty?
            
             Center(child: Text("Coming Soon", style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),)): Column(
              children: List.generate(provider.blogList.length, (index) {
                var blog = provider.blogList[index];


                return Container(
                  margin: EdgeInsets.all(4),
                  width: SizeConfig.safeBlockHorizontal * 100,
                  decoration: BoxDecoration(
                    color: CraftColors.neutralBlue800,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // provider.toggleExpansion(index);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                width:
                                //  isExpanded
                                    // ? 
                                    SizeConfig.safeBlockHorizontal *88,
                                    // : SizeConfig.blockSizeHorizontal * 29,
                                height: 
                                // isExpanded
                                //     ? 
                                    SizeConfig.blockSizeVertical * 24,
                                    // : SizeConfig.blockSizeVertical * 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: NetworkImage(blog.blogImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                           
                         
                          ],
                        ),
                      
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          (blog.tags.isNotEmpty)?  Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: 
                           
                            Wrap(
                              spacing: 6.0, // Horizontal space
                              runSpacing: 6.0, // Vertical space
                              children: blog.tags.map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: CraftStyles.getTagBackgroundColor(tag),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    tag,
                                    style: CraftStyles.getTagTextStyle(tag),
                                  ),
                                );
                              }).toList(),
                            ),
                          ):Container(),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          Text(
                            blog.title,
                            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                           HtmlWidget(
                         blog.description,
                         
                          textStyle: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12)
                        ),
                          // Text(
                          //  blog.description,
                          //   maxLines: 2,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 14),
                          // ),
                          Text(
                            blog.readTime,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 90,
                            child: ElevatedButton(
                              onPressed: () {
                             
 Navigator.of(routeGlobalKey.currentContext!)
                      .pushNamed(
                        BlogDetailScreen.route,arguments: blog.blogsSlug
                      )
                      .then((value) {});
                                
                                
                              },
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
                                    style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      
                    ),
                  ),
                );
              }),
            ),
          ),
           if (provider.blogList.length != provider.totalLength)
              provider.blogList.isEmpty?Container():      Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Call the API to fetch more blogs
                            provider.getBlogsAPI(selectedCategoryId.toString(), currentSortBySection,true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CraftColors.neutralBlue800,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "View More",
                            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
              
        ],
      ),
    );
        });
  }

  Widget trendingMasterWidget(MasterAllProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trending Masters",
                  style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(provider.trendingMasterData.length, (index) {
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
                        Image.network(provider.trendingMasterData[index].photo,
                        width: SizeConfig.safeBlockHorizontal*28,
                        height: SizeConfig.safeBlockVertical*22,
                        fit: BoxFit.cover,),
                        SizedBox(width: SizeConfig.safeBlockHorizontal*2),
                        Container(
                           width: SizeConfig.safeBlockHorizontal*50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.trendingMasterData[index].masterName,
                                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
                              ),
                              SizedBox(height: SizeConfig.safeBlockVertical*1,),
                              Text(
                            provider.trendingMasterData[index].description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                          ),
                           SizedBox(height: SizeConfig.safeBlockVertical*1,),
                    (provider.trendingMasterData[index].tags.isNotEmpty)?  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: 
                     
                      Wrap(
                        spacing: 6.0, // Horizontal space
                        runSpacing: 6.0, // Vertical space
                        children: provider.trendingMasterData[index].tags.map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: CraftStyles.getTagBackgroundColor(tag),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tag,
                              style: CraftStyles.getTagTextStyle(tag),
                            ),
                          );
                        }).toList(),
                      )
                                        ):Container(),
SizedBox(height: SizeConfig.blockSizeVertical*1,),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(routeGlobalKey.currentContext!)
                      .pushNamed(
                        MasterScreenDetail.route,arguments: provider.trendingMasterData[index].slug
                      )
                      .then((value) {});
                              },
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
int? selectedCategoryId;
String selectedSortBy = 'Latest'; // Default selection for Sort By
String currentSection = 'Category'; // Default section is Category
String currentSortBySection = 'DESC';
ShowCategoryFilter() {
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
            builder: (BuildContext context, setState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(  // Wrap everything inside a scroll view
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display selected filters text
                      Text(
                        "Filter by",
                        style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      // Display selected category and sort by
                      // Text(
                      //   "Category: ${selectedCategoryId != null ? provider.categoryList.firstWhere((category) => category.id == selectedCategoryId)?.categoryName : 'None'}",
                      //   style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 14),
                      // ),
                      // Text(
                      //   "Sort By: $selectedSortBy",
                      //   style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 14),
                      // ),
                      SizedBox(height: 10),

                      // Row to divide the left section (Category, SortBy) and right section (Options)
                      Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Left Section: Category and Sort By options
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Category Option
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentSection = 'Category'; // Change to Category
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: currentSection == 'Category' ? CraftColors.neutralBlue750 : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Category",
                                      style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Sort By Option
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentSection = 'SortBy'; // Change to SortBy
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: currentSection == 'SortBy' ? CraftColors.neutralBlue750 : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Sort By",
                                      style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                         
                           Container(
      width: 1, 
      color: Colors.white,
      height: SizeConfig.blockSizeVertical*35, 
    ),
                       
                          Expanded(
                            flex: 3,
                            child: currentSection == 'Category'
                                ? SizedBox(
                                  height: SizeConfig.blockSizeVertical*35,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: provider.categoryList.length, 
                                      itemBuilder: (context, index) {
                                        return RadioListTile<int>(
                                          dense: true,
                                          activeColor: CraftColors.secondary100,
                                          title: Text(
                                            provider.categoryList[index].categoryName, 
                                            style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 12),
                                          ),
                                          value: provider.categoryList[index].id,
                                          groupValue: selectedCategoryId,
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedCategoryId = value;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                )
                                : SizedBox(
                                   height: SizeConfig.blockSizeVertical*35,
                                  child: Column(
                                      children: [
                                        // Sort By List
                                        ListTile(
                                          title: Text(
                                            "Latest",
                                            style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 12),
                                          ),
                                          leading: Radio<String>(
                                            value: 'Latest',
                                            groupValue: selectedSortBy,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedSortBy = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Oldest",
                                            style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 12),
                                          ),
                                          leading: Radio<String>(
                                            value: 'Oldest',
                                            groupValue: selectedSortBy,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedSortBy = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                ),
                          ),
                        ],
                      ),
                      // Spacer to push the button to the bottom
                      SizedBox(height: 20),  // Space between content and button
                      // Apply Button at the bottom
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle "Apply" button click (pass the selected category ID and sort by option)
                            print("Selected Category ID: $selectedCategoryId");
                            print("Selected Sort By: $selectedSortBy");
                        if(selectedSortBy=="Oldest")
                        {currentSortBySection="ASC";

                        }else{
currentSortBySection="DESC";
                        }
  

  
                           Navigator.pop(context); // Close the bottom sheet
                            // Example of using the selected values to filter blogs
                            final provider = Provider.of<BlogProvider>(context, listen: false);
                           
                            if (!provider.isLoading) {
                              provider.getBlogsAPI(selectedCategoryId.toString(), currentSortBySection,false);
                            }
                        
                         
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50), // Full-width button
                            backgroundColor: CraftColors.neutralBlue800,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            "Apply",
                            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
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
