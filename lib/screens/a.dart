
// class Coursedetailscreen extends StatefulWidget {
//   final String slug;
//   static const String route = "/courseDetail";
//   const Coursedetailscreen({Key? key, required this.slug}) : super(key: key);

//   @override
//   _CoursesDetailState createState() => _CoursesDetailState();
// }

// class _CoursesDetailState extends State<Coursedetailscreen> {
//   final VideoThumbnailCache thumbnailCache = VideoThumbnailCache();
//   TextEditingController reviewController = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
// print("courseDetail");
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final providerSubscription =
//           Provider.of<LandingScreenProvider>(context, listen: false);

//       if (!providerSubscription.isSubscriptionLoading) {
//         providerSubscription
//             .getcheckSubscriptionIndividualFlowWiseInfoAPI(
//                 courseslug: widget.slug)
//             .then((value) {
//           final provider = Provider.of<CoursesProvider>(context, listen: false);
//           if (!provider.iscourseDetailLoading) {
//             provider.getCourseDetailAPI(widget.slug);

           
//           }
//           if(!provider.isOtherLoading)
//           {
//  provider.getOtherCourseAPI();
//           }
//         });
//       }
//     });
//   }
//   Widget bannerImages(LandingScreenProvider landingProvider) {
    
//     return Consumer<CoursesProvider>(builder: (context, provider, _) {
//        if (provider.iscourseDetailLoading) {
//             return Center(child: CircularProgressIndicator());
//           }
//       return provider.courseDetailList.isEmpty
//           ? Container()
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: SizeConfig.blockSizeVertical * 40,
//                   child: Container(
//                     margin: EdgeInsets.all(8),
//                     width: SizeConfig.safeBlockHorizontal * 100,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24),
//                         image: DecorationImage(
//                             image: NetworkImage(provider.courseDetailList[0]
//                                     .courseData[0].courseBannerMobile

//                                 // Get image from the provider list
//                                 ),
//                             fit: BoxFit.cover)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: SizeConfig.blockSizeVertical * 1,
//                           ),
//                           Text(
//                             provider.courseDetailList[0].courseData[0].name,
//                             style: CraftStyles.tsWhiteNeutral50W700
//                                 .copyWith(fontSize: 16),
//                           ),
//                           SizedBox(
//                             height: SizeConfig.blockSizeVertical * 1,
//                           ),
//                           Text(
//                             provider.courseDetailList[0].courseData[0]
//                                 .shortDescription,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 4,
//                             style: CraftStyles.tsWhiteNeutral200W500,
//                           ),
//                           SizedBox(
//                             height: SizeConfig.blockSizeVertical * 1,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: GlobalLists.courseStatus == "0"
//                                     ? SizeConfig.blockSizeHorizontal * 25
//                                     : SizeConfig.blockSizeHorizontal * 30,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     print("buy now click");
//                                     if (GlobalLists.courseStatus == "0") {
//                                       print("buy now click 1");
//                                       landingProvider.subscribeNowAPI(
//                                           "",
//                                           provider.courseDetailList[0]
//                                               .courseData[0].courseId,
//                                           "");
//                                     } else 
//                                     // if (provider
//                                     //         .courseDetailList[0]
//                                     //         .startCourse[0]
//                                     //         .completionPercentage !=
//                                     //     0) 
//                                         {
//                                       _navigateToVideoScreen(
//                                         provider.courseDetailList[0]
//                                             .startCourse[0].topicVideo,
//                                         provider.courseDetailList[0]
//                                             .startCourse[0].courseTopicSlug,
//                                         widget.slug,
//                                         provider.courseDetailList[0]
//                                             .startCourse[0].watchTime==""?"0:0:0":provider.courseDetailList[0]
//                                             .startCourse[0].watchTime,
//                                       );
//                                     }
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     minimumSize: Size(
//                                         SizeConfig.blockSizeHorizontal * 25,
//                                         SizeConfig.blockSizeVertical * 2),
//                                     backgroundColor: CraftColors.primaryBlue550,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 5),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     elevation: 5,
//                                   ),
//                                   child: Text(
//                                     GlobalLists.courseStatus == "0"
//                                         ? CraftStrings.strBuyNow
//                                         : provider.courseDetailList[0]
//                                                 .startCourse.isEmpty
//                                             ? CraftStrings.strStartCourse
//                                             : provider.courseDetailList[0]
//                                                     .startCourse.isEmpty
//                                                 ? CraftStrings.strStartCourse
//                                                 : provider
//                                                             .courseDetailList[0]
//                                                             .startCourse[0]
//                                                             .completionPercentage !=
//                                                         0
//                                                     ? CraftStrings.strContinue
//                                                     : CraftStrings
//                                                         .strStartCourse,
//                                     style: CraftStyles.tsWhiteNeutral50W60016,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal * 2,
//                               ),
//                               GlobalLists.courseStatus == "0"
//                                   ? SizedBox(
//                                       width: Platform.isAndroid
//                                           ? SizeConfig.blockSizeHorizontal * 38
//                                           : SizeConfig.blockSizeHorizontal * 35,
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           _navigateToVideoScreen(
//                                               provider.courseDetailList[0]
//                                                   .courseData[0].trailorVideo,
//                                               "",
//                                               widget.slug,
//                                               "0:0:0");
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           minimumSize: Size(
//                                               Platform.isAndroid
//                                                   ? SizeConfig
//                                                           .blockSizeHorizontal *
//                                                       38
//                                                   : SizeConfig
//                                                           .blockSizeVertical *
//                                                       35,
//                                               SizeConfig.blockSizeVertical * 2),
//                                           backgroundColor: CraftColors
//                                               .transparent
//                                               .withOpacity(0.1),
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 10, vertical: 5),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             side: BorderSide(
//                                               color: CraftColors
//                                                   .neutralBlue750, // Set the border color
//                                               width: 2, // Set the border width
//                                             ),
//                                           ),
//                                           elevation: 5,
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             SvgPicture.asset(
//                                               CraftImagePath.play,
//                                               height: 12.0,
//                                               width: 12.0,
//                                             ),
//                                             SizedBox(
//                                                 width:
//                                                     8), // Add some spacing between icon and text
//                                             Text(
//                                               CraftStrings.strWatchTrailer,
//                                               style: CraftStyles
//                                                   .tsWhiteNeutral50W60016
//                                                   .copyWith(fontSize: 14),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   : Container()
//                             ],
//                           ),
//                           provider.courseDetailList[0].startCourse.isNotEmpty
//                               ? provider.courseDetailList[0].startCourse[0]
//                                           .completionPercentage !=
//                                       0
//                                   ? Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               getStatusLabel(provider
//                                                   .courseDetailList[0]
//                                                   .startCourse[0]
//                                                   .completionPercentage), // Display the dynamic status label
//                                               style: CraftStyles
//                                                   .tsWhiteNeutral300W400,
//                                             ),
//                                             Text(
//                                               '${provider.courseDetailList[0].startCourse[0].completionPercentage.toStringAsFixed(1)}%',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 14),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: 5),
//                                         ProgressBar(
//                                           currentPosition: double.parse(provider
//                                               .courseDetailList[0]
//                                               .startCourse[0]
//                                               .completionPercentage
//                                               .toString()),
//                                           duration: double.parse(
//                                               "100"), // Total video duration
//                                         ),
//                                       ],
//                                     )
//                                   : Container()
//                               : Container()
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment
//                       .center, // Centers the images horizontally
//                   crossAxisAlignment: CrossAxisAlignment
//                       .center, // Centers the images vertically
//                   children: <Widget>[
//                     // imageWithTextColumn(CraftImagePath.sampleVideo,CraftStrings.strSampleVideo),
//                     GestureDetector(
//                         onTap: () {
//                           _navigateToVideoScreen(
//                               provider.courseDetailList[0].courseData[0].bts,
//                               provider.courseDetailList[0].courseData[0].slug,
//                               widget.slug,
//                               "0:0:0");
//                         },
//                         child: imageWithTextColumn(
//                             CraftImagePath.bts, CraftStrings.strBts)),
//                     GestureDetector(
//                       onTap: ()
//                       async {
//                         print("share click");
//                         final String productUrl = 'https://uat-craftschool.onerooftechnologiesllp.com/product/123';
//                         String? shortUrl = await BitlyService.shortenUrl(productUrl);
//                         print("shortUrl");
//             if (shortUrl != null) {
//                     print("shortUrl");
//               print(shortUrl);
//               Share.share('Check out this product: $shortUrl');
//             }
//                       },
//                       child: imageWithTextColumn(
//                           CraftImagePath.share, CraftStrings.strShare),
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   thickness: 0.2,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         CraftStrings.strAboutCourse,
//                         style: CraftStyles.tsWhiteNeutral50W700
//                             .copyWith(fontSize: 16),
//                       ),
//                       Text(
//                         provider
//                             .courseDetailList[0].courseData[0].contextOfCourse,
//                         style: CraftStyles
//                             .tsWhiteNeutral200W500, // Customize your text style
//                         maxLines: provider.isExpanded
//                             ? null
//                             : 3, // Limit text to 3 lines if not expanded
//                         overflow: provider.isExpanded
//                             ? TextOverflow.visible
//                             : TextOverflow
//                                 .ellipsis, // Show ellipsis when collapsed
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           provider
//                               .toggleExpansion(); // Toggle the expansion state via provider
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: Text(
//                             provider.isExpanded ? "Show Less" : "Show More",
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 buyNowWidget(landingProvider),
//                 moduleWidget(),
//                 meetInstructorWidget(),
//               ],
//             );
//     });
//   }
  
 
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);

//     return ChangeNotifierProvider(
//         create: (_) => LandingScreenProvider(),
//         child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
//           if (provider.isSubscriptionLoading) {
//             return Center(child: CircularProgressIndicator());
//           }
         
//           return Scaffold(
//             appBar: PreferredSize(
//               preferredSize: const Size.fromHeight(kToolbarHeight),
//               child: CustomAppBar(
//                 isCategoryVisible: provider.isCategoryVisible,
//                 onMenuPressed: () {
//                   provider
//                       .toggleSlidingContainer(); // Trigger toggle when menu is pressed
//                 },
//                 onCategoriesPressed: () {
//                   provider.toggleSlidingCategory();
//                 },
//                 isContainerVisible: provider.isCategoryVisible,
//               ),
//             ),
//             backgroundColor: CraftColors.black18,
//             body: ChangeNotifierProvider(
//               create: (_) => CourseDetailProvider(),
//               child: Stack(
//                 children: [
//                   ListView(
//                     shrinkWrap: true,
//                     physics: ScrollPhysics(),
//                     children: [
//                       bannerImages(provider),
                     
//                     ],
//                   ),
//                   if (provider.isContainerVisible)
//                     SlidingMenu(isVisible: provider.isContainerVisible),
//                   if (provider.isCategoryVisible)
//                     SlidingCategory(
//                       isExpanded: provider.isCategoryVisible,
//                       onToggleExpansion: provider.toggleSlidingCategory,
//                     ),
//                 ],
//               ),
//             ),
//           );
//         }));
//   }


// }