import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/utils/GlobalLists.dart';
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
import 'package:provider/provider.dart';

class MasterScreenDetail extends StatefulWidget {
  final String slug;
  static const String route = "/masterDetailScreen";
  const MasterScreenDetail({Key? key, required this.slug}) : super(key: key);

  @override
  _MasterScreenDetailState createState() => _MasterScreenDetailState();
}

class _MasterScreenDetailState extends State<MasterScreenDetail> {

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
      final provider = Provider.of<MasterAllProvider>(context, listen: false);
      if (!provider.istrendingMasterLoading) {
       
         provider.getTrendingMasterAPI();
  
      }
      if(!provider.isMasterDetailLoading)
      {
        provider.getMasterDetailBySlugAPI(widget.slug);
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
                  provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                },
                   onCategoriesPressed: () {  provider.toggleSlidingCategory();}, isContainerVisible: provider.isCategoryVisible,
              ),
            ),
            backgroundColor: CraftColors.black18,
            // bottomNavigationBar: BottomAppBarWidget(index: -1,),
            // floatingActionButton: FloatingActionButtonWidget(),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: Stack(
              children: [
                // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
               Consumer<MasterAllProvider>(
                builder: (context, provider, child) {
              return
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 0.0, maxHeight: double.infinity),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                 provider.masterDataDetail.isEmpty?Container():      SingleChildScrollView(
                  scrollDirection: Axis.vertical, // Allow vertical scrolling
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row for Checkbox, Image, and Text
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              GestureDetector(
                                  onTap: () {
                                    // Toggle the expanded state via the provider
                                   
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    width:  SizeConfig.blockSizeHorizontal * 29, // Original width when collapsed
                                    height: SizeConfig.blockSizeVertical * 20, // Original height when collapsed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(provider.masterDataDetail[0].masterImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Row with "New!" label and Expand Icon
                                          Padding(
                                                                                     padding: const EdgeInsets.only(left: 2),
                                                                                     child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                      
                                                                                      Text(
                                                                                       provider.masterDataDetail[0].name,
                                                                                        style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 16),
                                                                                      ),
                                                                                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                                                                       Text(
                                                                                       provider.masterDataDetail[0].profession,
                                                                                        style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                                                                                      ),
                                                                                      
                                                                                      Text(
                                                                                       provider.masterDataDetail[0].bio,
                                                                                        maxLines: 4,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
                                                                                      ),
                                                                                       SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                                                                 SizedBox(
                width: SizeConfig.blockSizeHorizontal * 35,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(SizeConfig.blockSizeHorizontal * 35,
                        SizeConfig.blockSizeVertical * 4),
                    backgroundColor: CraftColors.primaryBlue500,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                   "${provider.masterDataDetail[0].name} Courses",
                    style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                  ),
                ),
              ),
                                                                                    
                                                                                  
                                                                                     ],),
                                                                                   ),
                                       
                                        ],
                                      ),
                                    ),
                                  ),
                                
                              ],
                            ),
                           
                          ],
                        ),
                      )
                    ]
                  ),
                ),
                   award(provider) ,
                   browseCourse(),
                   TrendingSkill(imagePaths: provider.trendingMasterData, title: CraftStrings.strtrendingSkills, onPressed: ()
                   {
                    
                   })
                    ],
                  ),
                );}),
                if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
              if (provider.isCategoryVisible) SlidingCategory(
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
Widget award(MasterAllProvider provider)
{
  return provider.masterDataDetail.isNotEmpty? provider.masterDataDetail[0].awards.isEmpty?Container(): Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CraftColors.neutralBlue800,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             
                              Text(
                              "Awards",
                                style: CraftStyles.tsWhiteNeutral50W60016
                                    .copyWith(fontSize: 18),
                              ),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1),
                              ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,  // Change scroll direction to horizontal
    physics: ScrollPhysics(),
    itemCount: 2,  // Use the length of the list from provider
    itemBuilder: (context, index) {
      return  Text(
                               provider.masterDataDetail[0].awards[index]
,                                style: CraftStyles.tsWhiteNeutral100W500
                                    ,
                              );})
                            ],
                          ),
                        ),
                      ),
                    ):Container();
}
  //browse course
  Widget browseCourse() {
    return Consumer<MasterAllProvider>(
      builder: (context, provider, child) {
        return  provider.masterCourses.isEmpty?Container(): Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${provider.masterCourses[0].masterName} Courses",
                style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  itemCount: provider.masterCourses
                      .length, // Use the length of the list from provider
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              width: SizeConfig.safeBlockHorizontal * 40,
                              height: SizeConfig.blockSizeVertical * 22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                // image: DecorationImage(
                                //   image: NetworkImage(
                                //     provider.courses[index].courseBannerMobile,
                                //   ),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8, top: 8,),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network( provider.masterCourses[index].courseBannerMobile,width: SizeConfig.safeBlockHorizontal * 40,
                                  height: SizeConfig.blockSizeVertical * 20, fit: BoxFit.cover,),
                                     
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal * 40,
                                  child: Text(
                                    provider.masterCourses[index].shortDescription,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: CraftStyles.tsWhiteNeutral50W60016
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                               
                              ],
                            ),
                          ],
                        ),
                          GlobalLists.authtoken!=""?      Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  if (provider.masterCourses[index].savedFlag!) {
                                  
                    
               provider.unsaveMasterCourse!(index); // Pass the index to the callback
                       
                                   
                                  } else {
                                     
               provider.savemasterCourse!(index); // Pass the index to the callback
             
                                  
                                  }
                                  // provider.notifyListeners(); // Ensure UI updates
                                },
                                child: provider.masterCourses[index].savedFlag!
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
              ),
              // Center(
              //   child: SizedBox(
              //     width: SizeConfig.blockSizeHorizontal * 44,
              //     child: ElevatedButton(
              //       onPressed: () {},
              //       style: ElevatedButton.styleFrom(
              //         minimumSize: Size(SizeConfig.blockSizeVertical * 44,
              //             SizeConfig.blockSizeVertical * 5),
              //         backgroundColor: CraftColors.neutralBlue800,
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         elevation: 5,
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           // Add some spacing between icon and text
              //           Text(
              //             CraftStrings.strBrowseCourse,
              //             style: CraftStyles.tsWhiteNeutral50W60016,
              //           ),
              //           SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
              //           SvgPicture.asset(
              //             CraftImagePath.arrowRight,
              //             height: 24.0,
              //             width: 24.0,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }
}
