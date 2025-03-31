import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CategoryListProvider.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/AllCourses.dart';
import 'package:craft_school/screens/CategoryCourseWidget.dart';
import 'package:craft_school/screens/JoinFlimFest.dart';
import 'package:craft_school/screens/MasterScreen.dart';
import 'package:craft_school/screens/MasterScreenDetail.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/screens/VideoScreen.dart';
import 'package:craft_school/screens/autoscroll.dart';
import 'package:craft_school/screens/blog_screen.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/screens/myCourse.dart';
import 'package:craft_school/screens/service.dart';
import 'package:craft_school/screens/service_plan_screen.dart';
import 'package:craft_school/screens/settings.dart';
import 'package:craft_school/screens/signup_screen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/SPManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/MasterImagesCarousel.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  final bool isSignUp;
  static const String route = "/landingScreen";
  const LandingScreen({super.key,  this.isSignUp=false});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
    int _currentIndex = -1;

  final List<Widget> _screens =  [
    MyCourseScreen(),
    AspiringTrainingScreen(),
    BlogsScreen(),
    Settings(),
  ];
  String? token = "";
  String? customerID = "";
  String? customerName = "";
  @override
  void initState() {
    super.initState();
    gettoken();
    // Ensure data is fetched after the widget is built
  }
 int indexofcategoryselected = 0; // Default to the "All" option (index 0)
  gettoken() async {
    token = await SPManager().getAuthToken();
    customerID = await SPManager().getcustomerID();
    customerName = await SPManager().getcustomerName();
    GlobalLists.authtoken = token;
    GlobalLists.customerID = customerID;
    GlobalLists.customerName = customerName;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only call the API if it's not already loading
      final provider =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!provider.isSubscriptionLoading) {
        provider
            .getcheckSubscriptionIndividualFlowWiseInfoAPI()
            .then((value) async {
          token = await SPManager().getAuthToken();
          customerID = await SPManager().getcustomerID();
          customerName = await SPManager().getcustomerName();
            GlobalLists.authtoken = token;
    GlobalLists.customerID = customerID;
    GlobalLists.customerName = customerName;
          print("TOKEN VSLUE Now check");
          print(token);
          if (!provider.isCategoryLoading) {
            print("TOKEN VSLUE");
            print(token);
            print("#ruchita ${GlobalLists.clearCookies}");
            // if (token != "") {
            if(widget.isSignUp){
              print("TOKEN VSLUE");
              print(token);
              print("Token getting");
              if (!provider.isCategoryLoading) {
                provider.getCustomerCategoryList();
                print("Token getting getCustomerCategoryList");
                
                if (provider.categoryList.isNotEmpty) {
                  
                  provider.selectedSingleChips =
                      provider.categoryList[0].id.toString();
                }
                
              }
            } else {
              final provider =
                  Provider.of<CategoryListProvider>(context, listen: false);
              print("Token getting getCategoryList");
              
              if (!provider.isLoading) {
                provider.getCategoryList().then((value)
                {
 if (!provider.isCategoryWiseLoading) {
                    print("getCategoryList 1");
                if (provider.categoryList.isNotEmpty) {
                   print("getCategoryList 2");
                  provider.getCategoryWiseList([provider.categoryList[0].id]);
                }
              }
                });
              }

             
            }
          }
        });
      }
      if (!provider.isLoading) {
        provider.homeScreenAPI();
      }

      if (!provider.isjoinFestiveLoading) {
        provider.getJoinFestivalAPI();
      }
    });
  }

  Widget masterClassBlock() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            //color: Color(0x1ED76040),
            // image: DecorationImage(
            //   image: AssetImage(CraftImagePath.landingBackground),
            // ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20), // Border radius for the checkbox
                border: Border.all(
                  color: Colors.white, // White border when unselected
                  width: 0.5, // Border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  CraftStrings.strLandingScreenSubText1,
                  style: CraftStyles.tsNeutral500W500,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Text(
              CraftStrings.strLandingScreenSubText2,
              textAlign: TextAlign.center,
              style: CraftStyles.tsWhiteNeutral50W700,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              CraftStrings.strLandingScreenSubText3,
              style: CraftStyles.tsNeutral500W500,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            SizedBox(
              width: SizeConfig.blockSizeVertical * 22,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(routeGlobalKey.currentContext!)
                      .pushNamed(
                        MasterScreen.route,
                      )
                      .then((value) {});
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(SizeConfig.blockSizeVertical * 0.5,
                      SizeConfig.blockSizeVertical * 6),
                  backgroundColor: CraftColors.primaryBlue550,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      CraftImagePath.play,
                      height: 24.0,
                      width: 24.0,
                    ),
                    SizedBox(
                        width: 8), // Add some spacing between icon and text
                    Text(
                      CraftStrings.strMasterClass,
                      style: CraftStyles.tsWhiteNeutral50W60016
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//
  Widget everyMonthBlock() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            //color: Color(0x1ED76040),

            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Text(
              CraftStrings.strLandingScreenSubText4,
              style: CraftStyles.tsWhiteNeutral50W700,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 43,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "95%",
                        style: CraftStyles.tssecondary550W700,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Text(
                        CraftStrings.strLandingScreenSubText5,
                        style: CraftStyles.tsWhiteNeutral300W500,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 43,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "100%",
                        style: CraftStyles.tssecondary550W700,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Text(
                        CraftStrings.strLandingScreenSubText6,
                        style: CraftStyles.tsWhiteNeutral300W500,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bannerWatchVideo(
      {String? tag,
      String? title,
      String? subTitle,
      TextStyle? textStyle,
      Color? textBackground,
      String? image,
       String? slug,
        String? courseId,
      String? trailorVideo}) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 50,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style:
                      CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                GestureDetector(
                  onTap: trailorVideo != ""
                      ? () {
                          // Navigator.of(context)
                          //     .pushNamed(VideoScreen.route,
                          //         arguments: trailorVideo)
                          //     .then((value) {});
                          Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VideoScreen(
                video: trailorVideo!,
                videoCourseSlug: slug!,
                videoTopicSlug: "",
                videoWatchTime: "0:0:0",
              )),
                          );
                        }
                      : () {},
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: subTitle,
                          style: CraftStyles.tsWhiteNeutral300W500,
                        ),
                        trailorVideo != ""
                            ? TextSpan(
                                text: "watch the first module for free!",
                                style: CraftStyles.tsWhiteNeutral300W500
                                    .copyWith(color: CraftColors.secondary550),
                              )
                            : TextSpan(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            width: SizeConfig.safeBlockHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 38,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                    image: NetworkImage(
                      image!,

                      // Get image from the provider list
                    ),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }

  Widget joinCommunity(
      {String? tag,
      String? title,
      String? subTitle,
      TextStyle? textStyle,
      Color? textBackground,
      String? titleText,
      String? subTitleText,
      String? image}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(CraftImagePath.community_join),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
        ),
        // height: SizeConfig.blockSizeVertical * 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: CraftStyles.tsWhiteNeutral50W60016
                        .copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: subTitle,
                          style: CraftStyles.tsWhiteNeutral300W500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: CraftColors.neutralBlue850,
              margin: EdgeInsets.all(16),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 30,
              child: SlantedImageReel(),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(24),
              //     image: DecorationImage(
              //         image: AssetImage(
              //           image!,

              //           // Get image from the provider list
              //         ),
              //         fit: BoxFit.cover
              //         )
              //         ),
            ),
            SizedBox(
              height: 50,
              child: Image.asset(
                CraftImagePath.star,
                height: 100,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              titleText!,
              style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: subTitleText,
                    style: CraftStyles.tsWhiteNeutral300W500,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Consumer<LandingScreenProvider>(
                builder: (context, provider, child) {
              return SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: provider.joinCommunityList
                      .length, // Use the length of the list from provider
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          child: Row(
                            children: [
                              Image.asset(CraftImagePath.check),
                              SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: provider
                                                      .joinCommunityList[index]
                                                  ['title']!,
                                              style: CraftStyles
                                                  .tsWhiteNeutral300W500,
                                            ),
                                            TextSpan(
                                              text: provider
                                                      .joinCommunityList[index]
                                                  ['subtext']!,
                                              style: CraftStyles
                                                  .tsWhiteNeutral300W500
                                                  .copyWith(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
         SizedBox(
              width: SizeConfig.blockSizeHorizontal * 55,
              child: ElevatedButton(
                onPressed: () {
                  if( GlobalLists.communityPlan=="Yes")
                  {

                  
 Navigator.of(context).pushNamed(PostScreen.route).then((value) {});
                  }
                  else{
                     Navigator.of(context).pushNamed(PlanPriceCardScreen.route).then((value) {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(SizeConfig.blockSizeHorizontal * 45,
                      SizeConfig.blockSizeVertical * 5),
                  backgroundColor:   CraftColors.primaryBlue550,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  CraftStrings.strJoinCommunity,
                  style: CraftStyles.tsWhiteNeutral50W60016,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget joinFlimFestival() {
    return Consumer<LandingScreenProvider>(builder: (context, provider, child) {
      return provider.joinFestivalList.isEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        CraftImagePath.festival,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                ),
                // height: SizeConfig.blockSizeVertical * 90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              CraftImagePath.fridauCraftWhite,
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 3,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Join CraftSchool ",
                                    style: CraftStyles.tsWhiteNeutral50W700,
                                  ),
                                  TextSpan(
                                    text:
                                        "${provider.joinFestivalList[0].title}",
                                    style: CraftStyles.tsWhiteNeutral50W700
                                        .copyWith(
                                            color: CraftColors.primaryBlue500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 3,
                            ),
                            Text(
                              provider.joinFestivalList[0].shortDesc,
                              style: CraftStyles.tsWhiteNeutral50W60016
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 55,
                          decoration: BoxDecoration(
                            color: CraftColors.white,
                            borderRadius: BorderRadius.circular(
                                24), // Border radius for the checkbox
                            border: Border.all(
                              color:
                                  Colors.white, // White border when unselected
                              width: 0.5, // Border width
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              provider.joinFestivalList[0].flimFestivalDate,
                              style: CraftStyles.tsWhiteNeutral50W60016
                                  .copyWith(color: CraftColors.secondary550),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Guildlines & Details",
                          style: CraftStyles.tsWhiteNeutral500W400
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HtmlWidget(
                          provider.joinFestivalList[0].longDesc,
                          textStyle: CraftStyles.tsWhiteNeutral200W500,
                        ),
                      ),
                      // Consumer<LandingScreenProvider>(
                      //     builder: (context, provider, child) {
                      //   return SizedBox(
                      //     child: ListView.builder(
                      //       shrinkWrap: true,
                      //       scrollDirection: Axis.vertical,
                      //       physics: ScrollPhysics(),
                      //       itemCount: provider.joinGuildlineList
                      //           .length, // Use the length of the list from provider
                      //       itemBuilder: (context, index) {
                      //         return Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             SizedBox(
                      //               width: SizeConfig.blockSizeHorizontal * 90,
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 children: [
                      //                   SizedBox(
                      //                     width: SizeConfig.blockSizeHorizontal * 90,
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: RichText(
                      //                         overflow: TextOverflow.ellipsis,
                      //                         maxLines: 4,
                      //                         text: TextSpan(
                      //                           children: [
                      //                             TextSpan(
                      //                               text: provider
                      //                                       .joinGuildlineList[index]
                      //                                   ['title']!,
                      //                               style: CraftStyles
                      //                                   .tsWhiteNeutral300W500
                      //                                   .copyWith(
                      //                                       color: CraftColors.yellow),
                      //                             ),
                      //                             TextSpan(
                      //                               text: provider
                      //                                       .joinGuildlineList[index]
                      //                                   ['subtext']!,
                      //                               style: CraftStyles
                      //                                   .tsWhiteNeutral300W500
                      //                                   .copyWith(),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         );
                      //       },
                      //     ),
                      //   );
                      // }),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: ElevatedButton(
                              onPressed: () {
                                  Navigator.of(context)
                              .pushNamed(JoinFlimFest.route,
                                 )
                              .then((value) {});
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    SizeConfig.blockSizeHorizontal * 45,
                                    SizeConfig.blockSizeVertical * 5),
                                backgroundColor: CraftColors.primaryBlue550,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                CraftStrings.strJoinFirmFestival,
                                style: CraftStyles.tsWhiteNeutral50W60016,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 42,
                            child: ElevatedButton(
                              onPressed: () {
                              
                                
                              }
                              ,
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    SizeConfig.blockSizeVertical * 42,
                                    SizeConfig.blockSizeVertical * 5),
                                backgroundColor:
                                    CraftColors.transparent.withOpacity(0.1),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: CraftColors
                                        .neutralBlue750, // Set the border color
                                    width: 2, // Set the border width
                                  ),
                                ),
                                elevation: 5,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    CraftStrings.strLearnMore,
                                    style: CraftStyles.tsWhiteNeutral50W60016
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      //      Marquee(
                      //       baseMilliseconds: 500,
                      //   str: CraftStrings.strLearnText, containerWidth: SizeConfig.blockSizeHorizontal*100, // Pause after each loop
                      // ),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  Widget bannerImages(
    LandingScreenProvider provider,
      {String? tag,
      String? title,
      String? subTitle,
      TextStyle? textStyle,
      Color? textBackground,
      String? courseId,
      String? image,
      String? slug,
      int? coursestatus,
      String? trailorVideo}) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 60,
      child: Container(
        margin: EdgeInsets.all(8),
        width: SizeConfig.safeBlockHorizontal * 80,
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
              Container(
                decoration: BoxDecoration(
                  color: textBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tag!,
                    style: textStyle,
                  ),
                ),
              ),
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
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 43,
                    child: ElevatedButton(
                      onPressed: () {
if(coursestatus == 0)
{
   provider.subscribeNowAPI("",courseId!,"");
}else{
  Navigator.of(routeGlobalKey.currentContext!)
                                      .pushNamed(Coursedetailscreen.route,
                                          arguments:
                                              
                                              slug)
                                      .then((value) {});
}
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(SizeConfig.blockSizeHorizontal * 43,
                            SizeConfig.blockSizeVertical * 5),
                        backgroundColor: CraftColors.primaryBlue550,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                       coursestatus == 0
                                        ? CraftStrings.strBuyNow
                                        :  CraftStrings.strWatchNow,
                        style: CraftStyles.tsWhiteNeutral50W60016,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  trailorVideo != ""
                      ? SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 43,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context)
                              //     .pushNamed(VideoScreen.route,
                              //         arguments: trailorVideo)
                              //     .then((value) {});
                               Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VideoScreen(
                video: trailorVideo!,
                videoCourseSlug: slug!,
                videoTopicSlug: "",
                videoWatchTime: "0:0:0",
              )),
                          );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  SizeConfig.blockSizeVertical * 43,
                                  SizeConfig.blockSizeVertical * 5),
                              backgroundColor:
                                  CraftColors.transparent.withOpacity(0.1),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: CraftColors
                                      .neutralBlue750, // Set the border color
                                  width: 2, // Set the border width
                                ),
                              ),
                              elevation: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  CraftImagePath.play,
                                  height: 24.0,
                                  width: 24.0,
                                ),
                                SizedBox(
                                    width:
                                        8), // Add some spacing between icon and text
                                Text(
                                  CraftStrings.strWatchTrailer,
                                  style: CraftStyles.tsWhiteNeutral50W60016
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget annualPlanSignUp(String title) {
    return Container(
      color: CraftColors.neutralBlue800,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
                width: SizeConfig.blockSizeHorizontal * 61,
                child: Text(
                  CraftStrings.strAnnualPlan,
                  style: CraftStyles.tsNeutral500W500.copyWith(fontSize: 11),
                )),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 1,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 32,
              child: ElevatedButton(
                onPressed: () {
                  if(title==CraftStrings.strSubscribeNow)
                  {
Navigator.of(
                    routeGlobalKey.currentContext!,
                  ).pushNamed(
                    PlanPriceCardScreen.route,
                  );
                  }else{
                  Navigator.of(
                    routeGlobalKey.currentContext!,
                  ).pushNamed(
                    SignUpScreen.route,
                  );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(SizeConfig.blockSizeVertical * 32,
                      SizeConfig.blockSizeVertical * 5),
                  backgroundColor: CraftColors.primaryBlue550,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  title,
                  style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//
  Widget masterOfCraftSchool() {
    return Consumer<LandingScreenProvider>(
      builder: (context, provider, child) {
        return provider.masters.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Master’s of the Craft school",
                      style: CraftStyles.tsWhiteNeutral50W700
                          .copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 25,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        itemCount: provider.masters
                            .length, // Use the length of the list from provider
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(routeGlobalKey.currentContext!)
                                  .pushNamed(MasterScreenDetail.route,
                                      arguments: provider.masters[index].slug)
                                  .then((value) {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              width: SizeConfig.safeBlockHorizontal * 40,
                              height: SizeConfig.safeBlockVertical * 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    provider.masters[index].masterImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      provider.masters[index].name,
                                      style: CraftStyles.tsWhiteNeutral50W60016
                                          .copyWith(fontSize: 15),
                                    ),
                                    Text(
                                      provider.masters[index].profession,
                                      style: CraftStyles.tsWhiteNeutral300W500
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                                  MasterScreen.route,
                                )
                                .then((value) {});
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(SizeConfig.blockSizeVertical * 35,
                                SizeConfig.blockSizeVertical * 5),
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
                              // Add some spacing between icon and text
                              Text(
                                CraftStrings.strViewAll,
                                style: CraftStyles.tsWhiteNeutral50W60016,
                              ),
                              SizedBox(width: 8),
                              SvgPicture.asset(
                                CraftImagePath.arrowRight,
                                height: 24.0,
                                width: 24.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container();
      },
    );
  }

  storyTellingWidget() {
    return Consumer<LandingScreenProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.all(8),
        width: SizeConfig.safeBlockHorizontal * 85,
        decoration: BoxDecoration(
          color: CraftColors.neutralBlue800,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                provider.banner3[0].courseTitle,
                style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 25),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              provider.banner3[0].topics!.isNotEmpty
                  ? SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        itemCount: provider.banner3[0].topics!
                            .length, // Use the length of the list from provider
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            width: SizeConfig.safeBlockHorizontal * 85,
                            decoration: BoxDecoration(
                              color: CraftColors.neutralBlue800,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 85,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${index + 1}",
                                        style: CraftStyles
                                            .tsWhiteNeutral50W60016
                                            .copyWith(fontSize: 18),
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    75,
                                            child: Text(
                                              provider.banner3[0].topics![index]
                                                  .title,
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W60016
                                                  .copyWith(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2),
                                          SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    75,
                                            child: Text(
                                              provider.banner3[0].topics![index]
                                                  .description,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: CraftStyles
                                                  .tsWhiteNeutral300W500
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      1),
                                          Row(
                                            children: [
                                              provider.banner3[0].topics![index]
                                                          .freeVideo ==
                                                      "Yes"
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: CraftColors
                                                            .secondary100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          "Free !",
                                                          style: CraftStyles
                                                              .tssecondary800W500,
                                                        ),
                                                      ),
                                                    )
                                                  : SvgPicture.asset(
                                                      CraftImagePath.lock!),
                                              SizedBox(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              Text(
                                                provider
                                                    .banner3[0]
                                                    .topics![index]
                                                    .videoDuration,
                                                style: CraftStyles
                                                    .tsWhiteNeutral50W60016
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              ElevatedButton(
                onPressed: () {
                 if(provider.banner3[0].courseStatus == 0)
{
   provider.subscribeNowAPI("",provider.banner3[0].courseId,"");
}else{
  Navigator.of(routeGlobalKey.currentContext!)
                                      .pushNamed(Coursedetailscreen.route,
                                          arguments:
                                              
                                              provider.banner3[0].courseSlug)
                                      .then((value) {});
}
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(SizeConfig.blockSizeHorizontal * 30,
                      SizeConfig.blockSizeVertical * 5),
                  backgroundColor: CraftColors.primaryBlue550,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                 provider.banner3[0].courseStatus == 0
                                        ? CraftStrings.strBuyNow
                                        :  CraftStrings.strWatchNow,
                  style: CraftStyles.tsWhiteNeutral50W60016,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget flimMakingJourney() {
    return Consumer<LandingScreenProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Start Your Filmmaking Journey Today",
                textAlign: TextAlign.center,
                style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Text(
                "Access exclusive content, connect with the \ncommunity, and elevate your skills with \nflexible plans and benefits.",
                style: CraftStyles.tsWhiteNeutral300W500,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: provider.flimJourneyList
                      .length, // Use the length of the list from provider
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CraftColors.neutralBlue800,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  provider.flimJourneyList[index]['icon']!),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1),
                              Text(
                                provider.flimJourneyList[index]['title']!,
                                style: CraftStyles.tsWhiteNeutral50W60016
                                    .copyWith(fontSize: 18),
                              ),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1),
                              Text(
                                provider.flimJourneyList[index]['subtext']!,
                                textAlign: TextAlign.center,
                                style: CraftStyles.tsWhiteNeutral300W500
                                    .copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //browse course
  Widget browseCourse() {
  return Consumer<LandingScreenProvider>(
    builder: (context, provider, child) {
      return provider.courses.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Every skill you need, every course you want",
                    style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: ScrollPhysics(),
                      itemCount: provider.courses.length, 
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(routeGlobalKey.currentContext!)
                                        .pushNamed(Coursedetailscreen.route,
                                            arguments: provider.courses[index].slug)
                                        .then((value) {});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    width: SizeConfig.safeBlockHorizontal * 40,
                                    height: SizeConfig.blockSizeVertical * 22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          provider.courses[index].courseBannerMobile,
                                          width: SizeConfig.safeBlockHorizontal * 40,
                                          height: SizeConfig.blockSizeVertical * 20,
                                          fit: BoxFit.cover,
                                        ),
                                        if (provider.courses[index].tagName != null)
                                          Positioned(
                                            left: 10,
                                            top: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: CraftColors.secondary100,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  provider.courses[index].tagName!,
                                                  style: CraftStyles.tssecondary800W500,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.safeBlockHorizontal * 40,
                                      child: Text(
                                        provider.courses[index].shortDescription,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 15.0,
                                          backgroundImage: NetworkImage(provider.courses[index].courseBannerMobile),
                                        ),
                                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                                        Text(
                                          provider.courses[index].masterName,
                                          style: CraftStyles.tsWhiteNeutral300W500.copyWith(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Positioned Save Icon on Top-Right
                      GlobalLists.authtoken!=""?      Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  if (provider.courses[index].savedFlag) {
                                  
                           
                                    provider.unSaveEverySkillCourse(index);
                                   
                                  } else {
                                    provider.saveEverySkillCourse(index);
                                  
                                  }
                                  // provider.notifyListeners(); // Ensure UI updates
                                },
                                child: provider.courses[index].savedFlag
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
                  Center(
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 44,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(routeGlobalKey.currentContext!)
                              .pushNamed(AllCourses.route)
                              .then((value) {});
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(SizeConfig.blockSizeVertical * 44, SizeConfig.blockSizeVertical * 5),
                          backgroundColor: CraftColors.neutralBlue800,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(CraftStrings.strBrowseCourse, style: CraftStyles.tsWhiteNeutral50W60016),
                            SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                            SvgPicture.asset(CraftImagePath.arrowRight, height: 24.0, width: 24.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container();
    },
  );
}

  // Widget browseCourse() {
  //   return Consumer<LandingScreenProvider>(
  //     builder: (context, provider, child) {
  //       return provider.courses.isNotEmpty
  //           ? Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Every skill you need, every course you want",
  //                     style: CraftStyles.tsWhiteNeutral50W700
  //                         .copyWith(fontSize: 18),
  //                   ),
  //                   SizedBox(
  //                     height: SizeConfig.blockSizeVertical * 2,
  //                   ),
  //                   SizedBox(
  //                     height: SizeConfig.blockSizeVertical * 35,
  //                     child: ListView.builder(
  //                       shrinkWrap: true,
  //                       scrollDirection: Axis.horizontal,
  //                       physics: ScrollPhysics(),
  //                       itemCount: provider.courses
  //                           .length, // Use the length of the list from provider
  //                       itemBuilder: (context, index) {
  //                         return Column(
  //                           children: [
  //                             GestureDetector(
  //                               onTap: () {
  //                                 Navigator.of(routeGlobalKey.currentContext!)
  //                                     .pushNamed(Coursedetailscreen.route,
  //                                         arguments:
  //                                             provider.courses[index].slug)
  //                                     .then((value) {});
  //                               },
  //                               child: Container(
  //                                 margin: EdgeInsets.all(8),
  //                                 width: SizeConfig.safeBlockHorizontal * 40,
  //                                 height: SizeConfig.blockSizeVertical * 22,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(16),
  //                                   // image: DecorationImage(
  //                                   //   image: NetworkImage(
  //                                   //     provider.courses[index].courseBannerMobile,
  //                                   //   ),
  //                                   //   fit: BoxFit.cover,
  //                                   // ),
  //                                 ),
  //                                 child: Stack(
  //                                   children: [
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(
  //                                         left: 8,
  //                                         top: 8,
  //                                       ),
  //                                       child: Column(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.start,
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           Image.network(
  //                                             provider.courses[index]
  //                                                 .courseBannerMobile,
  //                                             width: SizeConfig
  //                                                     .safeBlockHorizontal *
  //                                                 40,
  //                                             height:
  //                                                 SizeConfig.blockSizeVertical *
  //                                                     20,
  //                                             fit: BoxFit.cover,
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     provider.courses[index].tagName != null
  //                                         ? Padding(
  //                                             padding: const EdgeInsets.only(
  //                                                 left: 16, top: 16),
  //                                             child: Container(
  //                                               decoration: BoxDecoration(
  //                                                 color:
  //                                                     CraftColors.secondary100,
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(8),
  //                                               ),
  //                                               child: Padding(
  //                                                 padding:
  //                                                     const EdgeInsets.all(8.0),
  //                                                 child: Text(
  //                                                   provider.courses[index]
  //                                                       .tagName!,
  //                                                   style: CraftStyles
  //                                                       .tssecondary800W500,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           )
  //                                         : Container(),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                             Column(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 SizedBox(
  //                                   width: SizeConfig.safeBlockHorizontal * 40,
  //                                   child: Text(
  //                                     provider.courses[index].shortDescription,
  //                                     overflow: TextOverflow.ellipsis,
  //                                     maxLines: 2,
  //                                     style: CraftStyles.tsWhiteNeutral50W60016
  //                                         .copyWith(fontSize: 14),
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: SizeConfig.blockSizeVertical * 0.5,
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   children: [
  //                                     CircleAvatar(
  //                                       radius:
  //                                           15.0, // Circle radius (size of the circle)
  //                                       backgroundImage: NetworkImage(provider
  //                                           .courses[index]
  //                                           .courseBannerMobile), // Image from local assets
  //                                     ),
  //                                     SizedBox(
  //                                       width:
  //                                           SizeConfig.blockSizeHorizontal * 2,
  //                                     ),
  //                                     Text(
  //                                       provider.courses[index].masterName,
  //                                       style: CraftStyles.tsWhiteNeutral300W500
  //                                           .copyWith(fontSize: 12),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   Center(
  //                     child: SizedBox(
  //                       width: SizeConfig.blockSizeHorizontal * 44,
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           Navigator.of(routeGlobalKey.currentContext!)
  //                               .pushNamed(
  //                                 AllCourses.route,
  //                               )
  //                               .then((value) {});
  //                         },
  //                         style: ElevatedButton.styleFrom(
  //                           minimumSize: Size(SizeConfig.blockSizeVertical * 44,
  //                               SizeConfig.blockSizeVertical * 5),
  //                           backgroundColor: CraftColors.neutralBlue800,
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: 10, vertical: 5),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(12),
  //                           ),
  //                           elevation: 5,
  //                         ),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             // Add some spacing between icon and text
  //                             Text(
  //                               CraftStrings.strBrowseCourse,
  //                               style: CraftStyles.tsWhiteNeutral50W60016,
  //                             ),
  //                             SizedBox(
  //                                 width: SizeConfig.blockSizeHorizontal * 1),
  //                             SvgPicture.asset(
  //                               CraftImagePath.arrowRight,
  //                               height: 24.0,
  //                               width: 24.0,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           : Container();
  //     },
  //   );
  // }

  Widget categoryCourse() {
    print("tokenlanding");
    print(token);
    return 
        Consumer<CategoryListProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return provider.categoryList.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "A dose of inspiration, whenever you need it.",
                            style: CraftStyles.tsWhiteNeutral50W700
                                .copyWith(fontSize: 18),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),

                          // Add the chip list for selection
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children:
                                    //  List.generate(provider.categoryList.length, (index) {
                                    //   return
                                    [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Wrap(
                                  spacing: 8.0, // Space between chips
                                  runSpacing: 4.0, // Space between lines
                                  children: List.generate(
                                      provider.categoryList.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        provider.onCategorySingleChipSelected!(
                                            provider.categoryList[index].id
                                                .toString()); // Update the selected chip
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: CraftColors.neutralBlue800,
                                          border: Border.all(
                                            color: provider
                                                        .selectedSingleChips ==
                                                    (provider
                                                        .categoryList[index].id
                                                        .toString())
                                                ? CraftColors.secondary550
                                                : CraftColors
                                                    .transparent, // Border only visible when selected
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.network(
                                              provider.categoryList[index].icon,
                                              height: 15.0,
                                              width: 15.0,
                                              color: provider
                                                          .selectedSingleChips ==
                                                      (provider
                                                          .categoryList[index]
                                                          .id
                                                          .toString())
                                                  ? CraftColors.secondary550
                                                  : CraftColors.white,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              provider.categoryList[index]
                                                  .categoryName,
                                              style: TextStyle(
                                                color: provider
                                                            .selectedSingleChips ==
                                                        (provider
                                                            .categoryList[index]
                                                            .id
                                                            .toString())
                                                    ? CraftColors.secondary550
                                                    : CraftColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              )
                            ]
                                // }),
                                ),
                          ),

                          SizedBox(height: SizeConfig.blockSizeVertical * 2),

                          //  // Show content below the selected chip
                          
                          provider.categoryWiseList.isEmpty
                              ? Container()
                              : SizedBox(
  height: SizeConfig.blockSizeVertical * 38,
  child: ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    physics: ScrollPhysics(),
    itemCount: provider.categoryWiseList.length,
    itemBuilder: (context, index) {
      var course = provider.categoryWiseList[index];

      return GestureDetector(
        onTap: () {
          Navigator.of(routeGlobalKey.currentContext!)
              .pushNamed(Coursedetailscreen.route, arguments: course.slug)
              .then((value) {});
        },
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  width: SizeConfig.safeBlockHorizontal * 40,
                  height: SizeConfig.blockSizeVertical * 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(course.courseBannerMobile),
                      fit: BoxFit.cover,
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
                          radius: 15.0, // Circle radius (size of the circle)
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
            // Positioned Save Icon on Top-Right
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
        ),
      );
    },
  ),
),

                          //   Center(
                          //     child: SizedBox(
                          //       width: SizeConfig.blockSizeHorizontal * 44,
                          //       child: ElevatedButton(
                          //         onPressed: () {},
                          //         style: ElevatedButton.styleFrom(
                          //           minimumSize: Size(SizeConfig.blockSizeVertical * 44,
                          //               SizeConfig.blockSizeVertical * 5),
                          //           backgroundColor: CraftColors.neutralBlue800,
                          //           padding:
                          //               EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12),
                          //           ),
                          //           elevation: 5,
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             // Add some spacing between icon and text
                          //             Text(
                          //               CraftStrings.strBrowseCourse,
                          //               style: CraftStyles.tsWhiteNeutral50W60016,
                          //             ),
                          //             SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                          //             SvgPicture.asset(
                          //               CraftImagePath.arrowRight,
                          //               height: 24.0,
                          //               width: 24.0,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   )
                        ],
                      ),
                    );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<LandingScreenProvider>(
      builder: (context, provider, _) {
        // Show loading spinner while fetching data
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return WillPopScope(
      //      onWillPop: () async {
      //   SystemNavigator.pop(); // directly closes the app
      //   return false;
      // },
       onWillPop: () async {
       
        ShowDialogs.exitDialog();
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
              ),
            ),
            backgroundColor: CraftColors.black18,
            bottomNavigationBar: BottomAppBarWidget(index: -1,),
            
            floatingActionButton: FloatingActionButtonWidget(isOnLandingScreen: true,),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: Stack(
              children: [
            widget.isSignUp?signupFLowWidget(provider):    ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    masterClassBlock(),
                    MasterImagesCarousel(carousalImages: provider.carousalImages),
                  GlobalLists.authtoken != ""
                        ? GlobalLists.planStatus=="0"? annualPlanSignUp(CraftStrings.strSubscribeNow):Container(): 
                         annualPlanSignUp(CraftStrings.strSignUp),
                    everyMonthBlock(),
                    //banner 1
                    GestureDetector(
                      onTap: () {
                        Navigator.of(routeGlobalKey.currentContext!)
                            .pushNamed(Coursedetailscreen.route,
                                arguments: provider.banner1[0].courseSlug)
                            .then((value) {});
                      },
                      child: provider.banner1.isNotEmpty
                          ? bannerImages(
                            provider,
                              tag: provider.banner1[0].tag,
                              title: provider.banner1[0].courseTitle,
                              subTitle: provider.banner1[0].courseShortDesc,
                              textStyle: CraftStyles.tssecondary800W500,
                              textBackground: CraftColors.secondary100,
                              image: provider.banner1[0].desktopImage,
                              coursestatus: provider.banner1[0].courseStatus,
                              slug:  provider.banner1[0].courseSlug,
                              courseId: provider.banner1[0].courseId,
                              trailorVideo: provider.banner1[0].trailerVideo)
                          : Container(),
                    ),
                    masterOfCraftSchool(),
                    browseCourse(),
                    provider.banner2.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(routeGlobalKey.currentContext!)
                                  .pushNamed(Coursedetailscreen.route,
                                      arguments: provider.banner2[0].courseSlug)
                                  .then((value) {});
                            },
                            child: bannerImages(
                              provider,
                                tag: provider.banner2[0].tag,
                                title: provider.banner2[0].courseTitle,
                                subTitle: provider.banner2[0].courseShortDesc,
                                textStyle: CraftStyles.tsdarkBrownW500,
                                textBackground: CraftColors.lightOrange,
                                image: provider.banner2[0].desktopImage,
                                 slug:  provider.banner2[0].courseSlug,
                                  coursestatus: provider.banner2[0].courseStatus,
                                  courseId: provider.banner2[0].courseId,
                                trailorVideo: provider.banner2[0].trailerVideo),
                          )
                        : Container(),
                    categoryCourse(),
                    //  categoryListing(),
                    provider.banner3.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(routeGlobalKey.currentContext!)
                                  .pushNamed(Coursedetailscreen.route,
                                      arguments: provider.banner3[0].courseSlug)
                                  .then((value) {});
                            },
                            child: bannerWatchVideo(
                                tag: provider.banner3[0].tag,
                                title: provider.banner3[0].courseTitle,
                                subTitle: provider.banner3[0].courseShortDesc,
                                textStyle: CraftStyles.tsdarkBrownW500,
                                textBackground: CraftColors.lightOrange,
                                image: provider.banner3[0].desktopImage,
                                  slug:  provider.banner3[0].courseSlug,
                                 
                                  courseId: provider.banner3[0].courseId,
                                trailorVideo: provider.banner3[0].trailerVideo),
                          )
                        : Container(),
                    provider.banner3.isNotEmpty
                        ? storyTellingWidget()
                        : Container(),
                    joinCommunity(
                        tag: "",
                        title: "Join the CraftSchool \nCommunity",
                        subTitle:
                            "Connect with filmmakers and industry \nexperts, wherever you are.",
                        textStyle: CraftStyles.tsdarkBrownW500,
                        textBackground: CraftColors.lightOrange,
                        image: CraftImagePath.bannerImage2,
                        titleText: "Exclusive Community",
                        subTitleText:
                            "Unlock the ultimate experience with our \nExclusive Community! With a CraftSchool \nsubscription or course purchase, you’ll gain \naccess to:"),
                    joinFlimFestival(),
                    flimMakingJourney(),
                  ],
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
          ),
        );
      },
    );
  }
  Widget signupFLowWidget(LandingScreenProvider provider)
  {
    return  ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  signUpSuccess(),
                  bannerImageVideo(),
               learnSubscriptionNewWidget(),
                  MasterImagesCarousel(carousalImages: provider.carousalImages),
            annualPlanSignUp(CraftStrings.strSubscribeNow),
                 
                  categorySignuPCourse(),
                 
                  
                ],
              );
  }
    Widget learnSubscriptionNewWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
         decoration: BoxDecoration(
              color: CraftColors.neutralBlue800,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Text(
                "What You’ll Get",
                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Consumer<CoursesProvider>(builder: (context, provider, child) {
                return provider.courseCoveredTopics.isEmpty
                    ? Container()
                    : SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          itemCount: provider.courseCoveredTopics
                              .length, // Use the length of the list from provider
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Row(
                                    children: [
                                      Image.asset(CraftImagePath.check),
                                      SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal * 2),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal * 70,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: provider
                                                              .courseCoveredTopics[
                                                          index]['title'],
                                                      style: CraftStyles
                                                          .tsWhiteNeutral300W500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
              }),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget bannerImageVideo()
  {
    return  Container(
        decoration: BoxDecoration(
              color: CraftColors.neutralBlue800,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
      child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 28.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          CraftImagePath.frame2,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
    );
  }

  Widget categorySignuPCourse() {
  print("tokenlanding");
  print(token);
  return Consumer<LandingScreenProvider>(
    builder: (context, provider, child) {
     

      if (provider.isLoading) {
        return Center(child: CircularProgressIndicator());
      }

      return provider.categoryList.isEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                           width: SizeConfig.blockSizeHorizontal * 50,
                        child: Text(
                          "Below are your custom results",
                          style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                       SizedBox(
     width: SizeConfig.blockSizeHorizontal * 38,
     child: ElevatedButton(
       onPressed: () {
        print("clicl");
             Navigator.of(routeGlobalKey.currentContext!)
                                .pushNamed(
                                  CategoryCourseWidget.route,
                                )
                                .then((value) {});
       }, // Trigger the action when pressed
       style: ElevatedButton.styleFrom(
         minimumSize: Size(SizeConfig.blockSizeVertical * 38, SizeConfig.blockSizeVertical * 4),
         backgroundColor: CraftColors.neutralBlue800,
         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         elevation: 5,
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(
             CraftStrings.strAllCategory,
             style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 12),
           ),
           SizedBox(width: 8),
           SvgPicture.asset(
             CraftImagePath.arrowRight,
             height: 14.0,
             width: 14.0,
           ),
         ],
       ),
     ),
   )
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),

                  // Chip list for selection
                  provider.categoryList.isEmpty
                      ? Container()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // "All" category chip at index 0
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0, bottom: 4, left: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    indexofcategoryselected = 0; // Set to "All"
                                    provider.onCategorySingleChipSelected(''); // "All" category
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: CraftColors.neutralBlue800,
                                      border: Border.all(
                                        color: indexofcategoryselected == 0
                                            ? CraftColors.secondary550
                                            : CraftColors.white,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                         CraftImagePath.popular, // Icon for "All"
                                          height: 15.0,
                                          width: 15.0,
                                          color: indexofcategoryselected == 0
                                              ? CraftColors.secondary550
                                              : CraftColors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "All", // Label for "All"
                                          style: TextStyle(
                                            color: indexofcategoryselected == 0
                                                ? CraftColors.secondary550
                                                : CraftColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Loop over other categories from the list
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0, bottom: 4, left: 8),
                                child: Wrap(
                                  spacing: 8.0, // Space between chips
                                  runSpacing: 4.0, // Space between lines
                                  children: List.generate(
                                    provider.categoryList.length,
                                    (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          indexofcategoryselected = index + 1; // Update index for other categories
                                          provider.onCategorySingleChipSelected(
                                              provider.categoryList[index].id.toString());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: CraftColors.neutralBlue800,
                                            border: Border.all(
                                              color:indexofcategoryselected==0?CraftColors.white: provider.selectedSingleChips ==
                                                      provider.categoryList[index].id.toString()
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
                                                provider.categoryList[index].catIcon,
                                                height: 15.0,
                                                width: 15.0,
                                                color:indexofcategoryselected==0?CraftColors.white: provider.selectedSingleChips ==
                                                        provider.categoryList[index].id.toString()
                                                    ? CraftColors.secondary550
                                                    : CraftColors.white,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                provider.categoryList[index].catName,
                                                style: TextStyle(
                                                  color:indexofcategoryselected==0?CraftColors.white: provider.selectedSingleChips ==
                                                          provider.categoryList[index].id.toString()
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

                  // Conditional rendering of the category-wise course list
                  // provider.categoryWiseList.isEmpty
                  //     ? Container()
                  //     : provider.categoryWiseList[indexofcategoryselected].courses.isEmpty
                  //         ? Container()
                  //         :
                           SizedBox(
                                  height: SizeConfig.blockSizeVertical * 38,
                                  child:
                                   ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical, // Vertical scroll for courses
                                    itemCount: provider.categoryWiseList.length,
                                    itemBuilder: (context, categoryIndex) {
                                      var category = provider.categoryWiseList[categoryIndex];
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                                                             category.courses.isEmpty?Container(): 
                                                                             indexofcategoryselected==0?     Padding(
                                                                               padding: const EdgeInsets.all(8.0),
                                                                               child: Column(
                                                                                 children: [
                                                                                   Text(category.categoryName, style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),),
                                                                                 ],
                                                                               ),
                                                                             ):Container(),
                                         category.courses.isEmpty?Container():   SizedBox(
                                              height: SizeConfig.blockSizeVertical * 38,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal, // Horizontal list of courses
                                                itemCount: category.courses.length,
                                                itemBuilder: (context, courseIndex) {
                                                  var course = category.courses[courseIndex];
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
                                                              height: SizeConfig.blockSizeVertical * 25,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(16),
                                                                image: DecorationImage(
                                                                  image: NetworkImage(course.courseBannerMobile),
                                                                  fit: BoxFit.cover,
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
                  print("customercategoryWiseList");
                   if (course.savedFlag) {
                                  
                           
                                    provider.unSaveCustomerCategoryCourse(categoryIndex,courseIndex);
                                   
                                  } else {
                                    provider.saveCustomerCategoryCourse(categoryIndex,courseIndex);
                                  
                                  }
                 
                },
                child: course.savedFlag
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
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                             
                ],
              ),
            );
    },
  );
}


      Widget signUpSuccess() {
        
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
         decoration: BoxDecoration(
              color: CraftColors.neutralBlue800,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
                Center(
                  child: SvgPicture.asset(
                        CraftImagePath.success,
                        height: 54.0,
                        width: 54.0,
                      ),
                ),
              Text(
                "Woohoo! You’re In!",
                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Text(
                textAlign: TextAlign.center,
                '"Your account is set, and we’ve handpicked courses just for you. Time to jump in and explore what you’re passionate about!"',
                style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 10,fontWeight: FontWeight.w400),
              ),
          
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
