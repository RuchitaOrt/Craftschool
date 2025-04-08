import 'dart:io';

import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CourseDetailProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/BitlyService.dart';
import 'package:craft_school/screens/VideoScreen.dart';
import 'package:craft_school/screens/service_plan_screen.dart';
import 'package:craft_school/utils/GlobalLists.dart';

import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/BrowseOtherCourse.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/ProgressBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/VideoThumbnail.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/CoursesProvider.dart';
import 'package:share_plus/share_plus.dart';

class Coursedetailscreen extends StatefulWidget {
  final String slug;
  static const String route = "/courseDetail";
  const Coursedetailscreen({Key? key, required this.slug}) : super(key: key);

  @override
  _CoursesDetailState createState() => _CoursesDetailState();
}

class _CoursesDetailState extends State<Coursedetailscreen> {
  final VideoThumbnailCache thumbnailCache = VideoThumbnailCache();
  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
print("courseDetail");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription
            .getcheckSubscriptionIndividualFlowWiseInfoAPI(
                courseslug: widget.slug)
            .then((value) {
          final provider = Provider.of<CoursesProvider>(context, listen: false);
          if (!provider.iscourseDetailLoading) {
            print("courseDetail");
            provider.getCourseDetailAPI(widget.slug).then((onValue)
            {
                if(GlobalLists.authtoken!="")
          {
             if (!provider.isReviewcourseLoading) {
            provider.getCourseReviewAPI(provider.courseDetailList[0].courseData[0].courseId);

           
          }
          }
            });

           
          }
        
          if(!provider.isOtherLoading)
          {
 provider.getOtherCourseAPI();
          }
        });
      }

    });
  }

  Widget imageWithTextColumn(String image, String title) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image, // Replace with your image path
            fit: BoxFit.contain, // Ensures the image fills the space
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Text(
            title,
            style: CraftStyles.tsWhiteNeutral200W500,
          ),
        ],
      ),
    );
  }

  Widget moduleWidget() {
    return Consumer<CoursesProvider>(
      builder: (context, provider, child) {
        return provider.courseDetailList.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: provider.courseDetailList[0].courseModules.isEmpty
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                          color: CraftColors.neutralBlue800,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 12),
                                    child: Text(
                                      "Modules",
                                      style: CraftStyles.tsWhiteNeutral50W700
                                          .copyWith(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              SingleChildScrollView(
                                scrollDirection:
                                    Axis.vertical, // Allow vertical scrolling
                                child: Column(
                                  children: List.generate(
                                      provider.courseDetailList[0].courseModules
                                          .length, (index) {
                                    // bool isExpanded = provider.blogsItem[index]['isExpanded'];
                                    // bool isChecked = provider.blogsItem[index]['isChecked']; // Add checkbox state

                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(4, 4, 4, 6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Row for Checkbox, Image, and Text
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Checkbox block (before image)

                                              // Image block (Click to expand)
                                              GestureDetector(
                                                onTap: (provider
                                                                .courseDetailList[
                                                                    0]
                                                                .courseModules[
                                                                    index]
                                                                .freeVideo ==
                                                            "Yes" ||
                                                        (GlobalLists.courseStatus !="0")
                                                            )
                                                    ? () {
                                                          print("CLICKED");print(GlobalLists
                                                                .courseStatus);
                                                                print(provider
                                                                .courseDetailList[
                                                                    0]
                                                                .courseModules[
                                                                    index]
                                                                .freeVideo);
                                                        // Toggle the expanded state via the provider
                                                        print("SLUG");
                                                        print(provider
                                                            .courseDetailList[0]
                                                            .courseModules[
                                                                index]
                                                            .courseTopicSlug);

                                                        _navigateToVideoScreen(
                                                          provider
                                                              .courseDetailList[
                                                                  0]
                                                              .courseModules[
                                                                  index]
                                                              .topicVideo,
                                                          provider
                                                              .courseDetailList[
                                                                  0]
                                                              .courseModules[
                                                                  index]
                                                              .courseTopicSlug,
                                                          widget.slug,
                                                          provider
                                                              .courseDetailList[
                                                                  0]
                                                              .courseModules[
                                                                  index]
                                                              .watchTime==""?"0:0:0":provider
                                                              .courseDetailList[
                                                                  0]
                                                              .courseModules[
                                                                  index]
                                                              .watchTime,
                                                        );
                                                      }
                                                    : () {
                                                        print("CLICKED ELSE");
                                                    },
                                                child: Stack(
                                                  children: [
                                                    // Thumbnail image

                                                     Consumer<VideoThumbnailCache>(
      builder: (context, thumbnailCacheprovider, child) {
        return 
        AnimatedContainer(
                                                      duration: Duration(
                                                          milliseconds: 100),
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          27,
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          13,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        image: DecorationImage(
                                                          image: thumbnailCacheprovider
                                                              .getThumbnailImage(provider
                                                                  .courseDetailList[
                                                                      0]
                                                                  .courseModules[
                                                                      index]
                                                                  .topicVideo),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
      },
    ),
                                                   

                                                    // Play button (centered)
                                                    Positioned.fill(
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: SvgPicture.asset(
                                                          CraftImagePath.play,
                                                          width:
                                                              20, // Play button size
                                                          height:
                                                              20, // Adjust size as needed
                                                        ),
                                                      ),
                                                    ),

                                                    // Progress bar at the bottom
                                                    provider
                                                                .courseDetailList[
                                                                    0]
                                                                .courseModules[
                                                                    index]
                                                                .completionPercentage !=
                                                            0
                                                        ? Positioned(
                                                            bottom:
                                                                0, // Positioning the progress bar at the bottom
                                                            left: 0,
                                                            right: 0,
                                                            child: ProgressBar(
                                                              currentPosition: double.parse(provider
                                                                  .courseDetailList[
                                                                      0]
                                                                  .courseModules[
                                                                      index]
                                                                  .completionPercentage
                                                                  .toString()),
                                                              duration:
                                                                  100, // Total video duration, assuming it's 100
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1),
                                              // Initially displayed text block (text beside image)

                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Row with "New!" label and Expand Icon
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 2),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              provider
                                                                  .courseDetailList[
                                                                      0]
                                                                  .courseModules[
                                                                      index]
                                                                  .topic,
                                                              style: CraftStyles
                                                                  .tsWhiteNeutral50W60016
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                            SizedBox(
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    1),
                                                            // Subtext (short description)
                                                            Text(
                                                              provider
                                                                  .courseDetailList[
                                                                      0]
                                                                  .courseModules[
                                                                      index]
                                                                  .description,
                                                              maxLines: 4,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: CraftStyles
                                                                  .tsWhiteNeutral300W500
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                provider
                                                                            .courseDetailList[
                                                                                0]
                                                                            .courseModules[
                                                                                index]
                                                                            .freeVideo ==
                                                                        "Yes"
                                                                    ? Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              CraftColors.secondary100,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child: GlobalLists.courseStatus ==
                                                                                "0"
                                                                            ? Padding(
                                                                                padding: const EdgeInsets.all(4.0),
                                                                                child: Text(
                                                                                  "Free !",
                                                                                  style: CraftStyles.tssecondary800W500,
                                                                                ),
                                                                              )
                                                                            : Container(),
                                                                      )
                                                                    : GlobalLists.courseStatus ==
                                                                            "0"
                                                                        ? SvgPicture.asset(
                                                                            CraftImagePath.lock!)
                                                                        : Container(),
                                                                //                                   Checkbox(
                                                                //    value: true,//isChecked,

                                                                //   onChanged: (bool? value) {
                                                                //     // Toggle the checkbox state via the provider
                                                                //     // provider.toggleCheckbox(index, value ?? false);
                                                                //   },
                                                                //   activeColor: Colors.blue, // Customize checkbox color
                                                                //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                // ),
                                                                GlobalLists.courseStatus ==
                                                                        "0"
                                                                    ? SizedBox(
                                                                        width:
                                                                            SizeConfig.blockSizeHorizontal *
                                                                                2)
                                                                    : Container(),
                                                                SvgPicture.asset(
                                                                    CraftImagePath
                                                                        .time),
                                                                SizedBox(
                                                                    width: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        2),
                                                                Text(
                                                                  provider
                                                                      .courseDetailList[
                                                                          0]
                                                                      .courseModules[
                                                                          index]
                                                                      .videoDuration,
                                                                  style: CraftStyles
                                                                      .tsWhiteNeutral50W60016
                                                                      .copyWith(
                                                                          fontSize:
                                                                              12),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              );
      },
    );
  }

  Widget buyNowCourseDetailWidget() {
    return Consumer<CoursesProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Master :",
                      style: CraftStyles.tsWhiteNeutral300W50012
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      provider.courseDetailList[0].courseData[0].masterName,
                      style: CraftStyles.tsWhiteNeutral50W60016
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chapters :",
                      style: CraftStyles.tsWhiteNeutral300W50012
                          .copyWith(fontSize: 14),
                    ),
                    (provider.courseDetailList[0].courseData[0].noOfModules ==
                                null ||
                            provider.courseDetailList[0].courseData[0]
                                    .noOfModules ==
                                "")
                        ? Text("-")
                        : Text(
                            "${provider.courseDetailList[0].courseData[0].noOfModules} Modules",
                            style: CraftStyles.tsWhiteNeutral50W60016
                                .copyWith(fontSize: 12),
                          ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration :",
                      style: CraftStyles.tsWhiteNeutral300W50012
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      provider.courseDetailList[0].courseData[0].duration,
                      style: CraftStyles.tsWhiteNeutral50W60016
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Text(
                  "Topics Covered :",
                  style: CraftStyles.tsWhiteNeutral300W50012
                      .copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical, // Allow vertical scrolling
                  child: Column(
                    children: List.generate(
                        provider.courseDetailList[0].courseData[0].topicCovered
                            .length, (index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CraftColors.neutralBlue750,
                                borderRadius: BorderRadius.circular(
                                    8), // Border radius for the checkbox
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 3, 12, 3),
                                child: Text(
                                  provider.courseDetailList[0].courseData[0]
                                      .topicCovered[index],
                                  style: CraftStyles.tsWhiteNeutral50W60016
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                learnNewWidget()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget learnNewWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.center,
            CraftStrings.strCourseDetailText,
            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Consumer<CoursesProvider>(builder: (context, provider, child) {
            return provider.courseDetailList.isEmpty
                ? Container()
                : SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: provider
                          .courseDetailList[0]
                          .courseData[0]
                          .learnings
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
                                                      .courseDetailList[0]
                                                      .courseData[0]
                                                      .learnings[index],
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
          Text(
            textAlign: TextAlign.center,
            CraftStrings.strCourseCertificateText,
            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
          ),
          // SizedBox(
          //   height: SizeConfig.blockSizeVertical * 1,
          // ),
          Center(
            child: SvgPicture.asset(
              CraftImagePath.courseCertificate,
            ),
          ),
        ],
      ),
    );
  }

  Widget learnSubscriptionNewWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Access All Courses !",
            style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Text(
            "Starting at ₹ 799/month(billed annually) for all classes and sessions",
            style: CraftStyles.tsWhiteNeutral300W500,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Center(
            child: SizedBox(
              width: SizeConfig.blockSizeHorizontal * 90,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    routeGlobalKey.currentContext!,
                  ).pushNamed(
                    PlanPriceCardScreen.route,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(SizeConfig.blockSizeHorizontal * 25,
                      SizeConfig.blockSizeVertical * 5),
                  backgroundColor: CraftColors.primaryBlue550,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  CraftStrings.strSubscribeNow,
                  style: CraftStyles.tsWhiteNeutral50W60016,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Text(
            "What's in every craftschool Membership?",
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
    );
  }

  Widget browseOtherCourse() {
    return Consumer<CoursesProvider>(
      builder: (context, provider, child) {
        // if (provider.isOtherLoading) {
        //     return Center(child: CircularProgressIndicator());
        //   }
        return provider.othercourseList.isNotEmpty? BrowseOtherCourse(
          imagePaths: provider.othercourseList,
          title: "Other courses you might enjoy",
          totalLength: provider.totalLengthothercourses.toString(),
          onPressed: () {
            provider.getOtherCourseAPI();
          },
          onArrowPressed: () {
            print("object");
            provider.getOtherCourseAPI();
          }, onsavePressed: (index)
          {
 provider.savedCourseAPI(
                             provider.othercourseList[index].courseId);
                              setState(() {
            provider.saveOtherCourse(index); 
          });
          },
          onPunsavedressed: (index)
          {
  

            provider.unSavedCourseAPI(
                             provider.othercourseList[index].courseId);
                              setState(() {
             provider.unSaveOtherCourse(index); 
          });
          },
        ):Container();
      },
    );
  }

  Widget meetInstructorWidget() {
    return Consumer<CoursesProvider>(
      builder: (context, provider, child) {
        return provider.courseDetailList[0].meetYourInstructor.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: CraftColors.neutralBlue800,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 12),
                              child: Text(
                                "Meet Instructor",
                                style: CraftStyles.tsWhiteNeutral50W700
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        SingleChildScrollView(
                          scrollDirection:
                              Axis.vertical, // Allow vertical scrolling
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row for Checkbox, Image, and Text
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Toggle the expanded state via the provider
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 100),
                                          width: SizeConfig
                                                  .blockSizeHorizontal *
                                              29, // Original width when collapsed
                                          height: SizeConfig.blockSizeVertical *
                                              18, // Original height when collapsed
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              image: NetworkImage(provider
                                                  .courseDetailList[0]
                                                  .meetYourInstructor[0]
                                                  .masterPhoto),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Row with "New!" label and Expand Icon
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .courseDetailList[0]
                                                          .meetYourInstructor[0]
                                                          .masterName,
                                                      style: CraftStyles
                                                          .tsWhiteNeutral50W60016
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            1),
                                                    // Subtext (short description)
                                                    Text(
                                                      provider
                                                          .courseDetailList[0]
                                                          .meetYourInstructor[0]
                                                          .description,
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: CraftStyles
                                                          .tsWhiteNeutral300W500
                                                          .copyWith(
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            1),
                                                    SizedBox(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          35,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          minimumSize: Size(
                                                              SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  35,
                                                              SizeConfig
                                                                      .blockSizeVertical *
                                                                  4),
                                                          backgroundColor:
                                                              CraftColors
                                                                  .neutralBlue750,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 4),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          elevation: 5,
                                                        ),
                                                        child: Text(
                                                          "${provider.courseDetailList[0].meetYourInstructor[0].masterName} Courses",
                                                          style: CraftStyles
                                                              .tsWhiteNeutral50W60016
                                                              .copyWith(
                                                                  fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget bannerImages(LandingScreenProvider landingProvider) {
    
    return Consumer<CoursesProvider>(builder: (context, provider, _) {
       if (provider.iscourseDetailLoading) {
            return Center(child: CircularProgressIndicator());
          }
      return provider.courseDetailList.isEmpty
          ? Container()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 40,
                  child: Container(
                    // margin: EdgeInsets.all(8),
                    width: SizeConfig.safeBlockHorizontal * 100,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                            image: NetworkImage(provider.courseDetailList[0]
                                    .courseData[0].courseBannerMobile

                                // Get image from the provider list
                                ),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Text(
                            provider.courseDetailList[0].courseData[0].name,
                            style: CraftStyles.tsWhiteNeutral50W700
                                .copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Text(
                            provider.courseDetailList[0].courseData[0]
                                .shortDescription,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: CraftStyles.tsWhiteNeutral200W500.copyWith(fontSize: 12),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: GlobalLists.courseStatus == "0"
                                    ? SizeConfig.blockSizeHorizontal * 25
                                    : SizeConfig.blockSizeHorizontal * 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print("buy now click");
                                    if (GlobalLists.courseStatus == "0") {
                                      print("buy now click 1");
                                      landingProvider.subscribeNowAPI(
                                          "",
                                          provider.courseDetailList[0]
                                              .courseData[0].courseId,
                                          "");
                                    } else 
                                    // if (provider
                                    //         .courseDetailList[0]
                                    //         .startCourse[0]
                                    //         .completionPercentage !=
                                    //     0) 
                                        {
                                      _navigateToVideoScreen(
                                        provider.courseDetailList[0]
                                            .startCourse[0].topicVideo,
                                        provider.courseDetailList[0]
                                            .startCourse[0].courseTopicSlug,
                                        widget.slug,
                                        provider.courseDetailList[0]
                                            .startCourse[0].watchTime==""?"0:0:0":provider.courseDetailList[0]
                                            .startCourse[0].watchTime,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        SizeConfig.blockSizeHorizontal * 25,
                                        SizeConfig.blockSizeVertical * 2),
                                    backgroundColor: CraftColors.primaryBlue550,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    GlobalLists.courseStatus == "0"
                                        ? CraftStrings.strBuyNow
                                        : provider.courseDetailList[0]
                                                .startCourse.isEmpty
                                            ? CraftStrings.strStartCourse
                                            : provider.courseDetailList[0]
                                                    .startCourse.isEmpty
                                                ? CraftStrings.strStartCourse
                                                : provider
                                                            .courseDetailList[0]
                                                            .startCourse[0]
                                                            .completionPercentage !=
                                                        0
                                                    ? CraftStrings.strContinue
                                                    : CraftStrings
                                                        .strStartCourse,
                                    style: CraftStyles.tsWhiteNeutral50W60016,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              GlobalLists.courseStatus == "0"
                                  ? SizedBox(
                                      width: Platform.isAndroid
                                          ? SizeConfig.blockSizeHorizontal * 38
                                          : SizeConfig.blockSizeHorizontal * 35,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _navigateToVideoScreen(
                                              provider.courseDetailList[0]
                                                  .courseData[0].trailorVideo,
                                              "",
                                              widget.slug,
                                              "0:0:0");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                              Platform.isAndroid
                                                  ? SizeConfig
                                                          .blockSizeHorizontal *
                                                      38
                                                  : SizeConfig
                                                          .blockSizeVertical *
                                                      35,
                                              SizeConfig.blockSizeVertical * 2),
                                          backgroundColor: CraftColors
                                              .transparent
                                              .withOpacity(0.1),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            side: BorderSide(
                                              color: CraftColors
                                                  .neutralBlue750, // Set the border color
                                              width: 2, // Set the border width
                                            ),
                                          ),
                                          elevation: 5,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              CraftImagePath.play,
                                              height: 12.0,
                                              width: 12.0,
                                            ),
                                            SizedBox(
                                                width:
                                                    8), // Add some spacing between icon and text
                                            Text(
                                              CraftStrings.strWatchTrailer,
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W60016
                                                  .copyWith(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          provider.courseDetailList[0].startCourse.isNotEmpty
                              ? provider.courseDetailList[0].startCourse[0]
                                          .completionPercentage !=
                                      0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              getStatusLabel(provider
                                                  .courseDetailList[0]
                                                  .startCourse[0]
                                                  .completionPercentage), // Display the dynamic status label
                                              style: CraftStyles
                                                  .tsWhiteNeutral300W400,
                                            ),
                                            Text(
                                              '${provider.courseDetailList[0].startCourse[0].completionPercentage.toStringAsFixed(1)}%',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        ProgressBar(
                                          currentPosition: double.parse(provider
                                              .courseDetailList[0]
                                              .startCourse[0]
                                              .completionPercentage
                                              .toString()),
                                          duration: double.parse(
                                              "100"), // Total video duration
                                        ),
                                      ],
                                    )
                                  : Container()
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centers the images horizontally
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Centers the images vertically
                  children: <Widget>[
                    // imageWithTextColumn(CraftImagePath.sampleVideo,CraftStrings.strSampleVideo),
                    GestureDetector(
                        onTap: () {
                          _navigateToVideoScreen(
                              provider.courseDetailList[0].courseData[0].bts,
                              provider.courseDetailList[0].courseData[0].slug,
                              widget.slug,
                              "0:0:0");
                        },
                        child: imageWithTextColumn(
                            CraftImagePath.bts, CraftStrings.strBts)),
                    GestureDetector(
                      onTap: ()
                      async {
                        print("share click");
                        final String productUrl = 'https://uat-craftschool.onerooftechnologiesllp.com/product/${widget.slug}';
                        String? shortUrl = await BitlyService.shortenUrl(productUrl);
                        print("shortUrl");
            if (shortUrl != null) {
                    print("shortUrl");
              print(shortUrl);
              Share.share('Check out this product: $shortUrl');
            }
                      },
                      child: imageWithTextColumn(
                          CraftImagePath.share, CraftStrings.strShare),
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CraftStrings.strAboutCourse,
                        style: CraftStyles.tsWhiteNeutral50W700
                            .copyWith(fontSize: 14),
                      ),
                      Text(
                        provider
                            .courseDetailList[0].courseData[0].contextOfCourse,
                        style: CraftStyles
                            .tsWhiteNeutral200W500.copyWith(fontSize: 12), // Customize your text style
                        maxLines: provider.isExpanded
                            ? null
                            : 3, // Limit text to 3 lines if not expanded
                        overflow: provider.isExpanded
                            ? TextOverflow.visible
                            : TextOverflow
                                .ellipsis, // Show ellipsis when collapsed
                      ),
                      GestureDetector(
                        onTap: () {
                          provider
                              .toggleExpansion(); // Toggle the expansion state via provider
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            provider.isExpanded ? "Show Less" : "Show More",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                buyNowWidget(landingProvider),
                moduleWidget(),
                meetInstructorWidget(),
              ],
            );
    });
  }

  Widget buyNowWidget(LandingScreenProvider landingProvider) {
    return Consumer<CoursesProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: CraftColors.neutralBlue800,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalLists.courseStatus == "0"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CraftColors.neutralBlue800,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: provider.chipPlanData.map((chip) {
                                return FilterChip(
                                  label: SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 30,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          chip['label']!,
                                          style: TextStyle(
                                            color: provider.selectedChip ==
                                                    chip['label']
                                                ? CraftColors.secondary550
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  selected:
                                      provider.selectedChip == chip['label'],
                                  onSelected: (isSelected) {
                                    provider
                                        .onSingleChipSelected(chip['label']);
                                    print(provider.selectedChip);
                                  },
                                  selectedColor: CraftColors.neutralBlue800,
                                  backgroundColor: CraftColors.neutralBlue800,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    side: BorderSide(
                                      color:
                                          provider.selectedChip == chip['label']
                                              ? CraftColors.secondary550
                                              : CraftColors.transparent,
                                      width:
                                          provider.selectedChip == chip['label']
                                              ? 1.0
                                              : 0.1,
                                    ),
                                  ),
                                  elevation: 0,
                                  showCheckmark: false,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                if (GlobalLists.courseStatus == "0")
                  provider.selectedChip == "Individual"
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(
                                "₹ ${provider.courseDetailList[0].courseData[0].courseCost}/-",
                                style: CraftStyles.tswhiteW600.copyWith(
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: CraftColors.neutral100,
                                    decorationThickness: 0.5),
                              ),
                              SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 4),
                              Expanded(
                                child: Text(
                                  "₹  ${provider.courseDetailList[0].courseData[0].amountWithDiscount}/-",
                                  style: CraftStyles.tswhiteW600
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                " ${provider.courseDetailList[0].courseData[0].discountPercentage} % off",
                                style: CraftStyles.tssecondary550W700
                                    .copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [learnSubscriptionNewWidget()],
                        ),
                provider.selectedChip == "Individual"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // if (GlobalLists.courseStatus != "0")

                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          // provider
                          //                                 .courseDetailList[0]
                          //                                 .startCourse.isEmpty?Container():     provider
                          //                                 .courseDetailList[0]
                          //                                 .startCourse[0].completionPercentage!=0? Container():
                          Center(
                            child: SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 90,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (GlobalLists.courseStatus == "0") {
                                    landingProvider.subscribeNowAPI(
                                        "",
                                        provider.courseDetailList[0]
                                            .courseData[0].courseId,
                                        "");
                                  } else {
                                
                                    _navigateToVideoScreen(
                                        provider.courseDetailList[0]
                                            .courseModules[0].topicVideo,
                                        provider.courseDetailList[0]
                                            .courseModules[0].courseTopicSlug,
                                        widget.slug,
                                        provider.courseDetailList[0]
                                            .courseModules[0].watchTime==""?"0:0:0": provider.courseDetailList[0]
                                            .courseModules[0].watchTime);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      SizeConfig.blockSizeHorizontal * 25,
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
                                  GlobalLists.courseStatus == "0"
                                      ? CraftStrings.strBuyNow
                                      : provider.courseDetailList[0].startCourse
                                              .isEmpty
                                          ? CraftStrings.strStartCourse
                                          : provider.courseDetailList[0]
                                                  .startCourse.isEmpty
                                              ? CraftStrings.strStartCourse
                                              : provider
                                                          .courseDetailList[0]
                                                          .startCourse[0]
                                                          .completionPercentage !=
                                                      0
                                                  ? CraftStrings.strContinue
                                                  : CraftStrings.strStartCourse,
                                  style: CraftStyles.tsWhiteNeutral50W60016,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          if (GlobalLists.courseStatus != "0")
                           provider.courseDetailList[0].courseData[0].savedFlag?Container(): Center(
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 90,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print("savetolater");
                                    provider.saveParticularCourse();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        SizeConfig.blockSizeHorizontal * 25,
                                        SizeConfig.blockSizeVertical * 5),
                                    backgroundColor: CraftColors.transparent,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: CraftColors.neutralBlue750,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    CraftStrings.strSaveToLater,
                                    style: CraftStyles.tsWhiteNeutral50W60016,
                                  ),
                                ),
                              ),
                            ),
                          GlobalLists.courseStatus == "0"
                              ? Center(
                                  child: IconButton(
                                    icon: Icon(
                                      provider.isBuyNowExpanded
                                          ? Icons.arrow_drop_up
                                          : Icons.arrow_drop_down,
                                      color: CraftColors.white,
                                    ),
                                    onPressed: () {
                                      provider.toggleBuyNowExpansion();
                                    },
                                  ),
                                )
                              : Container(),
                          GlobalLists.courseStatus == "0"
                              ? (provider.isBuyNowExpanded)
                                  ? buyNowCourseDetailWidget()
                                  : Container()
                              : buyNowCourseDetailWidget(), // This is the widget you want to expand/collapse
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          if (provider.isSubscriptionLoading) {
            return Center(child: CircularProgressIndicator());
          }
         
          return WillPopScope(
             onWillPop: ()async
      {
        provider.onCourseDetailBackPressed();
        return false;
      },
            child: Scaffold(
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
              body: ChangeNotifierProvider(
                create: (_) => CourseDetailProvider(),
                child: Stack(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                        bannerImages(provider),
                        browseOtherCourse(),
                     GlobalLists.authtoken!=""?   ratingView():
                     Container(child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                          "Customer Review",
                          style: CraftStyles.tsWhiteNeutral300W500,
                        ),
                     ),),
                     reviewList()
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
            ),
          );
        }));
  }

  Widget ratingView() {
    return Consumer<CoursesProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          // Wrap ListView in SingleChildScrollView
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Your Review",
              //   style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 25),
              // ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              GestureDetector(
                onTap: () {
                  provider.reviewExpansion();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Write Your Review",
                      style: CraftStyles.tsWhiteNeutral300W500,
                    ),
                    Icon(
                provider.isReviewViewed? Icons.minimize_outlined:      Icons.add,
                      color: CraftColors.neutral100,
                    )
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              provider.isReviewViewed
                  ? Card(
                      elevation: 1.0,
                      color: CraftColors.neutralBlue750,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: [
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 60,
                              child: RatingBar.builder(
                                
                                glowColor: CraftColors.white,
                                unratedColor: CraftColors.neutral100,
                                initialRating: provider.rating, // set initial rating
                                minRating: 0, // minimum rating
                                direction:
                                    Axis.horizontal, // horizontal or vertical
                                allowHalfRating:
                                    false, // allow half star ratings
                                itemCount: 5, // number of stars
                                itemSize: 25, // size of each star
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  provider.rating=rating;
                                },
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            TextField(
                              controller: reviewController,
                              style: CraftStyles.tsWhiteNeutral300W400,
                              maxLines: 8,
                              decoration: InputDecoration(
                                hintText: "Write Your Review",
                                filled: true,
                                fillColor: CraftColors.neutralBlue800,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                             SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
             
                  provider.submitReviewAPI(provider.courseDetailList[0].courseData[0].courseId,reviewController.text,provider.rating.toInt().toString()).then((value)
                  {
reviewController.text='';
provider.rating=0.0;
provider.reviewExpansion();


                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(SizeConfig.blockSizeVertical * 100,
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
                  CraftStrings.strSubmit,
                  style: CraftStyles.tsWhiteNeutral50W60016,
                ),
              ),
            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
Widget reviewList()
{
 return Consumer<CoursesProvider>(builder: (context, provider, child) {

   return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
       separatorBuilder: (context, index) => Divider(color: Colors.grey.shade800),
      itemCount: provider.courseReviewList.length,
      itemBuilder: (context, index) {
        final review = provider.courseReviewList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: review.userProfilePic.isNotEmpty
                    ? NetworkImage(review.userProfilePic)
                    : AssetImage(CraftImagePath.cinematography) as ImageProvider,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
               (review.usersName.isNotEmpty)?     Text(
                      review.usersName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ):Container(),
                    (review.usersName.isNotEmpty)?  SizedBox(height: 4):Container(),
                    Text(
                      review.comments,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    RatingBarIndicator(
                      rating: review.rating.toDouble(),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      unratedColor: CraftColors.neutral100,
                      itemCount: 5,
                      itemSize: 16.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(height: 4),
                    Text(
                      review.createdAt != null
                          ? "${review.createdAt!.day}/${review.createdAt!.month}/${review.createdAt!.year}"
                          : "",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
 });
}
  void _navigateToVideoScreen(String video, String videoTopicSlug,
      String videoCourseSlug, String videoWatchTime) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VideoScreen(
                video: video,
                videoCourseSlug: videoCourseSlug,
                videoTopicSlug: videoTopicSlug,
                videoWatchTime: videoWatchTime,
              )),
    );

    // If the result is true, trigger the refresh logic for the previous page
    if (result == true) {
      Navigator.of(routeGlobalKey.currentContext!)
          .pushNamed(Coursedetailscreen.route, arguments: widget.slug)
          .then((value) {});
      // Call your refresh method here, e.g., setState, fetch new data, etc.
//       setState(() {
//         // Trigger refresh actions or state update here
//         print("trigger");
//  print(GlobalLists.courseStatus);
//          WidgetsBinding.instance.addPostFrameCallback((_) {
//       final providerSubscription =
//           Provider.of<LandingScreenProvider>(context, listen: false);

//       if (!providerSubscription.isSubscriptionLoading) {
//        Provider.of<LandingScreenProvider>(context, listen: false)
//     .getcheckSubscriptionIndividualFlowWiseInfoAPI(courseslug: widget.slug)
//     .then((response) {
//       // Handle successful response here
//       print("trigger ");

//       // You can now proceed with further logic, like triggering the refresh
//       final provider = Provider.of<CoursesProvider>(context, listen: false);
//       if (!provider.isLoading) {
//         provider.getCourseDetailAPI(widget.slug);
//         provider.getOtherCourseAPI();
//       }
//     }).catchError((error) {
//       // Handle error if something went wrong with the API request
//       print("Error: $error");
//     });

//       }
//     });

//       });
    }
  }

  String getStatusLabel(int percentage) {
    if (percentage == 0) {
      return 'Not Started';
    } else if (percentage == 100) {
      return 'Completed';
    } else {
      return 'In Progress';
    }
  }
}
class ThumbnailWidget extends StatefulWidget {
  final String videoUrl;
  const ThumbnailWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _ThumbnailWidgetState createState() => _ThumbnailWidgetState();
}

class _ThumbnailWidgetState extends State<ThumbnailWidget> {
  ImageProvider? thumbnailImage;
  final VideoThumbnailCache thumbnailCache = VideoThumbnailCache();
  @override
  void initState() {
    super.initState();
    fetchThumbnail();
  }

  void fetchThumbnail() {
    Future.delayed(Duration.zero, () {
      setState(() {
        thumbnailImage = thumbnailCache.getThumbnailImage(widget.videoUrl);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: SizeConfig.blockSizeHorizontal * 27,
      height: SizeConfig.blockSizeVertical * 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: thumbnailImage != null
            ? DecorationImage(
                image: thumbnailImage!,
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }
}
