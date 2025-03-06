// import 'package:craft_school/main.dart';
// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/screens/MasterScreen.dart';
// import 'package:craft_school/screens/courseDetailScreen.dart';
// import 'package:craft_school/utils/craft_images.dart';
// import 'package:craft_school/utils/craft_strings.dart';
// import 'package:craft_school/utils/craft_styles.dart';
// import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';
// import 'package:craft_school/widgets/FloatingActionButton.dart';
// import 'package:craft_school/widgets/MasterImagesCarousel.dart';
// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:flutter/material.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/sizeConfig.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class LandingScreen extends StatefulWidget {
//   static const String route = "/landingScreen";
//   const LandingScreen({super.key});

//   @override
//   State<LandingScreen> createState() => _LandingScreenState();
// }

// class _LandingScreenState extends State<LandingScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
    
//     Provider.of<LandingScreenProvider>(context, listen: false).homeScreenAPI();
//   }

//   Widget masterClassBlock() {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//         decoration: BoxDecoration(
//             //color: Color(0x1ED76040),
//             // image: DecorationImage(
//             //   image: AssetImage(CraftImagePath.landingBackground),
//             // ),
//             ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.circular(20), // Border radius for the checkbox
//                 border: Border.all(
//                   color: Colors.white, // White border when unselected
//                   width: 0.5, // Border width
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(
//                   CraftStrings.strLandingScreenSubText1,
//                   style: CraftStyles.tsNeutral500W500,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 3,
//             ),
//             Text(
//               CraftStrings.strLandingScreenSubText2,
//               textAlign: TextAlign.center,
//               style: CraftStyles.tsWhiteNeutral50W700,
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 2,
//             ),
//             Text(
//               CraftStrings.strLandingScreenSubText3,
//               style: CraftStyles.tsNeutral500W500,
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 2,
//             ),
//             SizedBox(
//               width: SizeConfig.blockSizeVertical * 22,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(routeGlobalKey.currentContext!)
//                       .pushNamed(
//                         MasterScreen.route,
//                       )
//                       .then((value) {});
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(SizeConfig.blockSizeVertical * 0.5,
//                       SizeConfig.blockSizeVertical * 6),
//                   backgroundColor: CraftColors.primaryBlue550,
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 5,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       CraftImagePath.play,
//                       height: 24.0,
//                       width: 24.0,
//                     ),
//                     SizedBox(
//                         width: 8), // Add some spacing between icon and text
//                     Text(
//                       CraftStrings.strMasterClass,
//                       style: CraftStyles.tsWhiteNeutral50W60016
//                           .copyWith(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// //
//   Widget everyMonthBlock() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         decoration: BoxDecoration(
//             //color: Color(0x1ED76040),

//             ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 3,
//             ),
//             Text(
//               CraftStrings.strLandingScreenSubText4,
//               style: CraftStyles.tsWhiteNeutral50W700,
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 3,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: SizeConfig.blockSizeHorizontal * 43,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "95%",
//                         style: CraftStyles.tssecondary550W700,
//                       ),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                       Text(
//                         CraftStrings.strLandingScreenSubText5,
//                         style: CraftStyles.tsWhiteNeutral300W500,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: SizeConfig.blockSizeHorizontal * 3,
//                 ),
//                 SizedBox(
//                   width: SizeConfig.blockSizeHorizontal * 43,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "100%",
//                         style: CraftStyles.tssecondary550W700,
//                       ),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                       Text(
//                         CraftStrings.strLandingScreenSubText6,
//                         style: CraftStyles.tsWhiteNeutral300W500,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget bannerWatchVideo(
//       {String? tag,
//       String? title,
//       String? subTitle,
//       TextStyle? textStyle,
//       Color? textBackground,
//       String? image}) {
//     return SizedBox(
//       height: SizeConfig.blockSizeVertical * 55,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   title!,
//                   style:
//                       CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
//                 ),
//                 SizedBox(
//                   height: SizeConfig.blockSizeVertical * 1,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: subTitle,
//                         style: CraftStyles.tsWhiteNeutral300W500,
//                       ),
//                       TextSpan(
//                         text: "watch the first module for free!",
//                         style: CraftStyles.tsWhiteNeutral300W500
//                             .copyWith(color: CraftColors.secondary550),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(16),
//             width: SizeConfig.safeBlockHorizontal * 100,
//             height: SizeConfig.blockSizeVertical * 38,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(24),
//                 image: DecorationImage(
//                     image: AssetImage(
//                       image!,

//                       // Get image from the provider list
//                     ),
//                     fit: BoxFit.cover)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget joinCommunity(
//       {String? tag,
//       String? title,
//       String? subTitle,
//       TextStyle? textStyle,
//       Color? textBackground,
//       String? titleText,
//       String? subTitleText,
//       String? image}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft, // Starting point of the gradient
//             end: Alignment.bottomRight, // Ending point of the gradient
//             colors: [
//               const Color.fromARGB(255, 37, 45, 40),
//               const Color.fromARGB(255, 3, 14, 10),
//               const Color.fromARGB(255, 3, 29, 20)
//             ], // Gradient colors
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         // height: SizeConfig.blockSizeVertical * 90,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     title!,
//                     textAlign: TextAlign.center,
//                     style: CraftStyles.tsWhiteNeutral50W60016
//                         .copyWith(fontSize: 18),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.blockSizeVertical * 1,
//                   ),
//                   RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: subTitle,
//                           style: CraftStyles.tsWhiteNeutral300W500,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(16),
//               width: SizeConfig.safeBlockHorizontal * 100,
//               height: SizeConfig.blockSizeVertical * 30,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(24),
//                   image: DecorationImage(
//                       image: AssetImage(
//                         image!,

//                         // Get image from the provider list
//                       ),
//                       fit: BoxFit.cover)),
//             ),
//             SizedBox(
//               height: 50,
//               child: Image.asset(
//                 CraftImagePath.star,
//                 height: 100,
//               ),
//             ),
//             Text(
//               textAlign: TextAlign.center,
//               titleText!,
//               style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 18),
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 1,
//             ),
//             RichText(
//               textAlign: TextAlign.center,
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: subTitleText,
//                     style: CraftStyles.tsWhiteNeutral300W500,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 1,
//             ),
//             Consumer<LandingScreenProvider>(
//                 builder: (context, provider, child) {
//               return SizedBox(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   physics: ScrollPhysics(),
//                   itemCount: provider.joinCommunityList
//                       .length, // Use the length of the list from provider
//                   itemBuilder: (context, index) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: SizeConfig.blockSizeHorizontal * 90,
//                           child: Row(
//                             children: [
//                               Image.asset(CraftImagePath.check),
//                               SizedBox(
//                                   width: SizeConfig.blockSizeHorizontal * 5),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     width: SizeConfig.blockSizeHorizontal * 70,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: RichText(
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 4,
//                                         text: TextSpan(
//                                           children: [
//                                             TextSpan(
//                                               text: provider
//                                                       .joinCommunityList[index]
//                                                   ['title']!,
//                                               style: CraftStyles
//                                                   .tsWhiteNeutral300W500,
//                                             ),
//                                             TextSpan(
//                                               text: provider
//                                                       .joinCommunityList[index]
//                                                   ['subtext']!,
//                                               style: CraftStyles
//                                                   .tsWhiteNeutral300W500
//                                                   .copyWith(),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             }),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 1,
//             ),
//             SizedBox(
//               width: SizeConfig.blockSizeHorizontal * 55,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(SizeConfig.blockSizeHorizontal * 45,
//                       SizeConfig.blockSizeVertical * 5),
//                   backgroundColor: CraftColors.primaryBlue550,
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 5,
//                 ),
//                 child: Text(
//                   CraftStrings.strJoinCommunity,
//                   style: CraftStyles.tsWhiteNeutral50W60016,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 1,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget joinFlimFestival() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft, // Starting point of the gradient
//             end: Alignment.bottomRight, // Ending point of the gradient
//             colors: [
//               const Color.fromARGB(255, 37, 45, 40),
//               const Color.fromARGB(255, 3, 14, 10),
//               const Color.fromARGB(255, 3, 29, 20)
//             ], // Gradient colors
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         // height: SizeConfig.blockSizeVertical * 90,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(
//                       CraftImagePath.fridauCraftWhite,
//                       width: 50,
//                       height: 50,
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeVertical * 3,
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: "Join CraftSchool",
//                             style: CraftStyles.tsWhiteNeutral50W700,
//                           ),
//                           TextSpan(
//                             text: " Film Festival!",
//                             style: CraftStyles.tsWhiteNeutral50W700
//                                 .copyWith(color: CraftColors.primaryBlue500),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeVertical * 3,
//                     ),
//                     Text(
//                       "Showcase your skills,gain recognotion, and win exclusive reward judged by renowned industry experts.",
//                       style: CraftStyles.tsWhiteNeutral50W60016
//                           .copyWith(fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Container(
//                   width: SizeConfig.blockSizeHorizontal * 50,
//                   decoration: BoxDecoration(
//                     color: CraftColors.white,
//                     borderRadius: BorderRadius.circular(
//                         24), // Border radius for the checkbox
//                     border: Border.all(
//                       color: Colors.white, // White border when unselected
//                       width: 0.5, // Border width
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       textAlign: TextAlign.center,
//                       "25th -29th Oct,2025",
//                       style: CraftStyles.tsWhiteNeutral50W60016
//                           .copyWith(color: CraftColors.secondary550),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 3,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   "Guildlines & Details",
//                   style: CraftStyles.tsWhiteNeutral500W400,
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 1,
//               ),

//               Consumer<LandingScreenProvider>(
//                   builder: (context, provider, child) {
//                 return SizedBox(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     physics: ScrollPhysics(),
//                     itemCount: provider.joinGuildlineList
//                         .length, // Use the length of the list from provider
//                     itemBuilder: (context, index) {
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             width: SizeConfig.blockSizeHorizontal * 90,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: SizeConfig.blockSizeHorizontal * 90,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: RichText(
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 4,
//                                       text: TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             text: provider
//                                                     .joinGuildlineList[index]
//                                                 ['title']!,
//                                             style: CraftStyles
//                                                 .tsWhiteNeutral300W500
//                                                 .copyWith(
//                                                     color: CraftColors.yellow),
//                                           ),
//                                           TextSpan(
//                                             text: provider
//                                                     .joinGuildlineList[index]
//                                                 ['subtext']!,
//                                             style: CraftStyles
//                                                 .tsWhiteNeutral300W500
//                                                 .copyWith(),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 );
//               }),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 1,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: SizeConfig.blockSizeHorizontal * 45,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(SizeConfig.blockSizeHorizontal * 45,
//                             SizeConfig.blockSizeVertical * 5),
//                         backgroundColor: CraftColors.primaryBlue550,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 5,
//                       ),
//                       child: Text(
//                         CraftStrings.strJoinFirmFestival,
//                         style: CraftStyles.tsWhiteNeutral50W60016,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: SizeConfig.blockSizeHorizontal * 2,
//                   ),
//                   SizedBox(
//                     width: SizeConfig.blockSizeHorizontal * 42,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(SizeConfig.blockSizeVertical * 42,
//                             SizeConfig.blockSizeVertical * 5),
//                         backgroundColor:
//                             CraftColors.transparent.withOpacity(0.1),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(
//                             color: CraftColors
//                                 .neutralBlue750, // Set the border color
//                             width: 2, // Set the border width
//                           ),
//                         ),
//                         elevation: 5,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             CraftStrings.strLearnMore,
//                             style: CraftStyles.tsWhiteNeutral50W60016
//                                 .copyWith(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               //      Marquee(
//               //       baseMilliseconds: 500,
//               //   str: CraftStrings.strLearnText, containerWidth: SizeConfig.blockSizeHorizontal*100, // Pause after each loop
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget bannerImages(
//       {String? tag,
//       String? title,
//       String? subTitle,
//       TextStyle? textStyle,
//       Color? textBackground,
//       String? image}) {
//     return SizedBox(
//       height: SizeConfig.blockSizeVertical * 60,
//       child: Container(
//         margin: EdgeInsets.all(8),
//         width: SizeConfig.safeBlockHorizontal * 80,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             image: DecorationImage(
//                 image: AssetImage(
//                   image!,

//                   // Get image from the provider list
//                 ),
//                 fit: BoxFit.cover)),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: textBackground,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     tag!,
//                     style: textStyle,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 1,
//               ),
//               Text(
//                 title!,
//                 style: CraftStyles.tsWhiteNeutral50W700,
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 1,
//               ),
//               Text(
//                 subTitle!,
//                 style: CraftStyles.tsWhiteNeutral200W500,
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 1,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: SizeConfig.blockSizeHorizontal * 43,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(SizeConfig.blockSizeHorizontal * 43,
//                             SizeConfig.blockSizeVertical * 5),
//                         backgroundColor: CraftColors.primaryBlue550,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 5,
//                       ),
//                       child: Text(
//                         CraftStrings.strBuyNow,
//                         style: CraftStyles.tsWhiteNeutral50W60016,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: SizeConfig.blockSizeHorizontal * 2,
//                   ),
//                   SizedBox(
//                     width: SizeConfig.blockSizeHorizontal * 43,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(SizeConfig.blockSizeVertical * 43,
//                             SizeConfig.blockSizeVertical * 5),
//                         backgroundColor:
//                             CraftColors.transparent.withOpacity(0.1),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(
//                             color: CraftColors
//                                 .neutralBlue750, // Set the border color
//                             width: 2, // Set the border width
//                           ),
//                         ),
//                         elevation: 5,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             CraftImagePath.play,
//                             height: 24.0,
//                             width: 24.0,
//                           ),
//                           SizedBox(
//                               width:
//                                   8), // Add some spacing between icon and text
//                           Text(
//                             CraftStrings.strWatchTrailer,
//                             style: CraftStyles.tsWhiteNeutral50W60016
//                                 .copyWith(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget annualPlanSignUp() {
//     return Container(
//       color: CraftColors.neutralBlue800,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           children: [
//             SizedBox(
//                 width: SizeConfig.blockSizeHorizontal * 68,
//                 child: Text(
//                   CraftStrings.strAnnualPlan,
//                   style: CraftStyles.tsNeutral500W500,
//                 )),
//             SizedBox(
//               width: SizeConfig.blockSizeHorizontal * 3,
//             ),
//             SizedBox(
//               width: SizeConfig.blockSizeHorizontal * 22,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(SizeConfig.blockSizeVertical * 22,
//                       SizeConfig.blockSizeVertical * 5),
//                   backgroundColor: CraftColors.primaryBlue550,
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 5,
//                 ),
//                 child: Text(
//                   CraftStrings.strSignUp,
//                   style: CraftStyles.tsWhiteNeutral50W60016,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// //
//   Widget masterOfCraftSchool() {
//     return Consumer<LandingScreenProvider>(
//       builder: (context, provider, child) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Master’s of the Craft school",
//                 style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 25,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   physics: ScrollPhysics(),
//                   itemCount: provider.imagePaths
//                       .length, // Use the length of the list from provider
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.all(8),
//                       width: SizeConfig.safeBlockHorizontal * 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         image: DecorationImage(
//                           image: AssetImage(
//                             provider.imagePaths[index],
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               "Salim Khan",
//                               style: CraftStyles.tsWhiteNeutral50W60016
//                                   .copyWith(fontSize: 15),
//                             ),
//                             Text(
//                               "Script Writer",
//                               style: CraftStyles.tsWhiteNeutral300W500
//                                   .copyWith(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Center(
//                 child: SizedBox(
//                   width: SizeConfig.blockSizeHorizontal * 35,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(SizeConfig.blockSizeVertical * 35,
//                           SizeConfig.blockSizeVertical * 5),
//                       backgroundColor: CraftColors.neutralBlue800,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Add some spacing between icon and text
//                         Text(
//                           CraftStrings.strViewAll,
//                           style: CraftStyles.tsWhiteNeutral50W60016,
//                         ),
//                         SizedBox(width: 8),
//                         SvgPicture.asset(
//                           CraftImagePath.arrowRight,
//                           height: 24.0,
//                           width: 24.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   storyTellingWidget() {
//     return Consumer<LandingScreenProvider>(builder: (context, provider, child) {
//       return Container(
//         margin: EdgeInsets.all(8),
//         width: SizeConfig.safeBlockHorizontal * 85,
//         decoration: BoxDecoration(
//           color: CraftColors.neutralBlue800,
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               Text(
//                 textAlign: TextAlign.center,
//                 "The Art of Storytelling with \nR. Balki",
//                 style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 25),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               SizedBox(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   physics: ScrollPhysics(),
//                   itemCount: provider.storyTellingListItems
//                       .length, // Use the length of the list from provider
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.all(8),
//                       width: SizeConfig.safeBlockHorizontal * 85,
//                       decoration: BoxDecoration(
//                         color: CraftColors.neutralBlue800,
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: SizeConfig.blockSizeHorizontal * 85,
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "${index + 1}",
//                                   style: CraftStyles.tsWhiteNeutral50W60016
//                                       .copyWith(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                     width: SizeConfig.blockSizeHorizontal * 5),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       width:
//                                           SizeConfig.blockSizeHorizontal * 75,
//                                       child: Text(
//                                         provider.storyTellingListItems[index]
//                                             ['title']!,
//                                         style: CraftStyles
//                                             .tsWhiteNeutral50W60016
//                                             .copyWith(fontSize: 16),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             SizeConfig.blockSizeVertical * 2),
//                                     SizedBox(
//                                       width:
//                                           SizeConfig.blockSizeHorizontal * 75,
//                                       child: Text(
//                                         provider.storyTellingListItems[index]
//                                             ['subtext']!,
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: CraftStyles.tsWhiteNeutral300W500
//                                             .copyWith(fontSize: 14),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             SizeConfig.blockSizeVertical * 1),
//                                     Row(
//                                       children: [
//                                         provider.storyTellingListItems[index]
//                                                     ['icon'] ==
//                                                 ""
//                                             ? Container(
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                       CraftColors.secondary100,
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(4.0),
//                                                   child: Text(
//                                                     "Free !",
//                                                     style: CraftStyles
//                                                         .tssecondary800W500,
//                                                   ),
//                                                 ),
//                                               )
//                                             : SvgPicture.asset(
//                                                 provider.storyTellingListItems[
//                                                     index]['icon']!),
//                                         SizedBox(
//                                             width:
//                                                 SizeConfig.blockSizeHorizontal *
//                                                     2),
//                                         Text(
//                                           "04:36",
//                                           style: CraftStyles
//                                               .tsWhiteNeutral50W60016
//                                               .copyWith(fontSize: 18),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(SizeConfig.blockSizeHorizontal * 30,
//                       SizeConfig.blockSizeVertical * 5),
//                   backgroundColor: CraftColors.primaryBlue550,
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 5,
//                 ),
//                 child: Text(
//                   CraftStrings.strBuyNow,
//                   style: CraftStyles.tsWhiteNeutral50W60016,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Widget flimMakingJourney() {
//     return Consumer<LandingScreenProvider>(
//       builder: (context, provider, child) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 "Start Your Filmmaking Journey Today",
//                 textAlign: TextAlign.center,
//                 style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               Text(
//                 "Access exclusive content, connect with the \ncommunity, and elevate your skills with \nflexible plans and benefits.",
//                 style: CraftStyles.tsWhiteNeutral300W500,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               SizedBox(
//                 width: SizeConfig.blockSizeHorizontal * 80,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   physics: ScrollPhysics(),
//                   itemCount: provider.flimJourneyList
//                       .length, // Use the length of the list from provider
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: CraftColors.neutralBlue800,
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(25.0),
//                         child: SizedBox(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                   provider.flimJourneyList[index]['icon']!),
//                               SizedBox(
//                                   height: SizeConfig.blockSizeVertical * 1),
//                               Text(
//                                 provider.flimJourneyList[index]['title']!,
//                                 style: CraftStyles.tsWhiteNeutral50W60016
//                                     .copyWith(fontSize: 18),
//                               ),
//                               SizedBox(
//                                   height: SizeConfig.blockSizeVertical * 1),
//                               Text(
//                                 provider.flimJourneyList[index]['subtext']!,
//                                 textAlign: TextAlign.center,
//                                 style: CraftStyles.tsWhiteNeutral300W500
//                                     .copyWith(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   //browse course
//   Widget browseCourse() {
//     return Consumer<LandingScreenProvider>(
//       builder: (context, provider, child) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Every skill you need, every course you want",
//                 style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 35,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   physics: ScrollPhysics(),
//                   itemCount: provider.imagePaths
//                       .length, // Use the length of the list from provider
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.all(8),
//                           width: SizeConfig.safeBlockHorizontal * 40,
//                           height: SizeConfig.blockSizeVertical * 22,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 provider.imagePaths[index],
//                               ),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 8, top: 8),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: CraftColors.secondary100,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(4.0),
//                                     child: Text(
//                                       "New !",
//                                       style: CraftStyles.tssecondary800W500,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: SizeConfig.safeBlockHorizontal * 40,
//                               child: Text(
//                                 "Odit laborum sed optio sit dolore",
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: CraftStyles.tsWhiteNeutral50W60016
//                                     .copyWith(fontSize: 14),
//                               ),
//                             ),
//                             SizedBox(
//                               height: SizeConfig.blockSizeVertical * 0.5,
//                             ),
//                             Text(
//                               "Aashif Shaikh",
//                               style: CraftStyles.tsWhiteNeutral300W500
//                                   .copyWith(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               Center(
//                 child: SizedBox(
//                   width: SizeConfig.blockSizeHorizontal * 44,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(SizeConfig.blockSizeVertical * 44,
//                           SizeConfig.blockSizeVertical * 5),
//                       backgroundColor: CraftColors.neutralBlue800,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Add some spacing between icon and text
//                         Text(
//                           CraftStrings.strBrowseCourse,
//                           style: CraftStyles.tsWhiteNeutral50W60016,
//                         ),
//                         SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
//                         SvgPicture.asset(
//                           CraftImagePath.arrowRight,
//                           height: 24.0,
//                           width: 24.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget categoryCourse() {
//     return Consumer<LandingScreenProvider>(
//       builder: (context, provider, child) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Every skill you need, every course you want",
//                 style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
//               ),
//               SizedBox(height: SizeConfig.blockSizeVertical * 2),

//               // Add the chip list for selection
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: List.generate(provider.chipItems.length, (index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: Wrap(
//                         spacing: 8.0, // Space between chips
//                         runSpacing: 4.0, // Space between lines
//                         children:
//                             List.generate(provider.chipItems.length, (index) {
//                           return GestureDetector(
//                             onTap: () {
//                               provider.selectChip(
//                                   index); // Update the selected chip
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: CraftColors.neutralBlue800,
//                                 border: Border.all(
//                                   color: provider.selectedChipIndex == index
//                                       ? CraftColors.secondary550
//                                       : CraftColors
//                                           .transparent, // Border only visible when selected
//                                   width: 1.0,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SvgPicture.asset(
//                                     provider.chipItems[index]['image']!,
//                                     height: 15.0,
//                                     width: 15.0,
//                                     color: provider.selectedChipIndex == index
//                                         ? CraftColors.secondary550
//                                         : CraftColors.white,
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     provider.chipItems[index]["label"]!,
//                                     style: TextStyle(
//                                       color: provider.selectedChipIndex == index
//                                           ? CraftColors.secondary550
//                                           : CraftColors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     );
//                   }),
//                 ),
//               ),

//               SizedBox(height: SizeConfig.blockSizeVertical * 2),

//               // Show content below the selected chip
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 35,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   physics: ScrollPhysics(),
//                   itemCount: provider.selectedChipIndex != -1
//                       ? provider
//                           .filteredCourses[provider.selectedChipIndex].length
//                       : 0,
//                   itemBuilder: (context, index) {
//                     var course = provider
//                         .filteredCourses[provider.selectedChipIndex][index];
//                     return Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.all(8),
//                           width: SizeConfig.safeBlockHorizontal * 40,
//                           height: SizeConfig.blockSizeVertical * 25,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             image: DecorationImage(
//                               image: AssetImage(course.imagePath),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 8, top: 8),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 course.tagVisible
//                                     ? Container(
//                                         decoration: BoxDecoration(
//                                           color: CraftColors.secondary100,
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(4.0),
//                                           child: Text(
//                                             "New !",
//                                             style:
//                                                 CraftStyles.tssecondary800W500,
//                                           ),
//                                         ),
//                                       )
//                                     : Container(),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: SizeConfig.safeBlockHorizontal * 40,
//                               child: Text(
//                                 course.title,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: CraftStyles.tsWhiteNeutral50W60016
//                                     .copyWith(fontSize: 15),
//                               ),
//                             ),
//                             SizedBox(
//                                 height: SizeConfig.blockSizeVertical * 0.5),
//                             Text(
//                               course.author,
//                               style: CraftStyles.tsWhiteNeutral300W500
//                                   .copyWith(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),

//               Center(
//                 child: SizedBox(
//                   width: SizeConfig.blockSizeHorizontal * 44,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(SizeConfig.blockSizeVertical * 44,
//                           SizeConfig.blockSizeVertical * 5),
//                       backgroundColor: CraftColors.neutralBlue800,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Add some spacing between icon and text
//                         Text(
//                           CraftStrings.strBrowseCourse,
//                           style: CraftStyles.tsWhiteNeutral50W60016,
//                         ),
//                         SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
//                         SvgPicture.asset(
//                           CraftImagePath.arrowRight,
//                           height: 24.0,
//                           width: 24.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget blogsWidget() {
//     return Consumer<LandingScreenProvider>(
//       builder: (context, provider, child) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Blogs",
//                       style: CraftStyles.tsWhiteNeutral50W700
//                           .copyWith(fontSize: 18),
//                     ),
//                     Center(
//                       child: SizedBox(
//                         width: SizeConfig.blockSizeHorizontal * 30,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(SizeConfig.blockSizeVertical * 30,
//                                 SizeConfig.blockSizeVertical * 5),
//                             backgroundColor: CraftColors.neutralBlue800,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: 5,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // Add some spacing between icon and text
//                               Text(
//                                 CraftStrings.strViewAll,
//                                 style: CraftStyles.tsWhiteNeutral50W60016,
//                               ),
//                               SizedBox(width: 8),
//                               SvgPicture.asset(
//                                 CraftImagePath.arrowRight,
//                                 height: 20.0,
//                                 width: 20.0,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.vertical, // Allow vertical scrolling
//                 child: Column(
//                   children: List.generate(provider.blogsItem.length, (index) {
//                     bool isExpanded = provider.blogsItem[index]['isExpanded'];

//                     return Container(
//                       margin: EdgeInsets.all(8),
//                       width: SizeConfig.safeBlockHorizontal * 90,
//                       decoration: BoxDecoration(
//                         color: CraftColors.neutralBlue800,
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Row for Image and Text initially (Side by Side)
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Image block (Click to expand)
//                                 GestureDetector(
//                                   onTap: () {
//                                     // Toggle the expanded state via the provider
//                                     provider.toggleExpansion(index);
//                                   },
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 100),
//                                     width: isExpanded
//                                         ? SizeConfig.safeBlockHorizontal *
//                                             80 // Expand width when expanded
//                                         : SizeConfig.blockSizeHorizontal *
//                                             29, // Original width when collapsed
//                                     height: isExpanded
//                                         ? SizeConfig.blockSizeVertical *
//                                             24 // Larger height when expanded
//                                         : SizeConfig.blockSizeVertical *
//                                             16, // Original height when collapsed
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20.0),
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                             provider.blogsItem[index]['image']),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                     width: SizeConfig.blockSizeHorizontal * 1),
//                                 // Initially displayed text block (text beside image)
//                                 if (!isExpanded) ...[
//                                   Flexible(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           // Row with "New!" label and Expand Icon
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                       CraftColors.secondary100,
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(4.0),
//                                                   child: Text(
//                                                     "New !",
//                                                     style: CraftStyles
//                                                         .tssecondary800W500,
//                                                   ),
//                                                 ),
//                                               ),
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   // Toggle the expanded state via the provider
//                                                   provider
//                                                       .toggleExpansion(index);
//                                                 },
//                                                 child: SvgPicture.asset(
//                                                   CraftImagePath.expand,
//                                                   color: Colors.white,
//                                                   width: 24,
//                                                   height: 24,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                               height:
//                                                   SizeConfig.blockSizeVertical *
//                                                       1),
//                                           // Title
//                                           Text(
//                                             provider.blogsItem[index]['title'],
//                                             style: CraftStyles
//                                                 .tsWhiteNeutral50W60016
//                                                 .copyWith(fontSize: 16),
//                                           ),
//                                           SizedBox(
//                                               height:
//                                                   SizeConfig.blockSizeVertical *
//                                                       1),
//                                           // Subtext (short description)
//                                           Text(
//                                             provider.blogsItem[index]
//                                                 ['subtext'],
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: CraftStyles
//                                                 .tsWhiteNeutral300W500
//                                                 .copyWith(fontSize: 14),
//                                           ),
//                                           // Date and Read Time
//                                           Text(
//                                             "Oct 29,2024 | 5 min read",
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: CraftStyles
//                                                 .tsWhiteNeutral300W500
//                                                 .copyWith(fontSize: 12),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ],
//                             ),
//                             // Display expanded content only when isExpanded is true
//                             if (isExpanded) ...[
//                               SizedBox(
//                                   height: SizeConfig.blockSizeVertical * 2),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: CraftColors.secondary100,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: Text(
//                                     "New !",
//                                     style: CraftStyles.tssecondary800W500,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                   height: SizeConfig.blockSizeVertical * 1),
//                               Text(
//                                 provider.blogsItem[index]['title'],
//                                 style: CraftStyles.tsWhiteNeutral50W60016
//                                     .copyWith(fontSize: 16),
//                               ),
//                               SizedBox(
//                                   height: SizeConfig.blockSizeVertical * 1),
//                               // Subtext (short description)
//                               Text(
//                                 provider.blogsItem[index]['subtext'],
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: CraftStyles.tsWhiteNeutral300W500
//                                     .copyWith(fontSize: 14),
//                               ),
//                               // Date and Read Time
//                               Text(
//                                 "Oct 29,2024 | 5 min read",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: CraftStyles.tsWhiteNeutral300W500
//                                     .copyWith(fontSize: 12),
//                               ),
//                               // Read More Button
//                               SizedBox(
//                                   height: SizeConfig.blockSizeVertical * 1),
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal * 90,
//                                 child: ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                     minimumSize: Size(
//                                         SizeConfig.blockSizeVertical * 90,
//                                         SizeConfig.blockSizeVertical * 5),
//                                     backgroundColor: CraftColors.neutralBlue800,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 5),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       side: BorderSide(
//                                         color: CraftColors
//                                             .neutralBlue750, // Set the border color
//                                         width: 2, // Set the border width
//                                       ),
//                                     ),
//                                     elevation: 5,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         CraftStrings.strReadMore,
//                                         style: CraftStyles
//                                             .tsWhiteNeutral50W60016
//                                             .copyWith(fontSize: 17),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget realWidget() {
//     return Consumer<LandingScreenProvider>(builder: (context, provider, child) {
//       return Container(
//         margin: EdgeInsets.all(8),
//         width: SizeConfig.safeBlockHorizontal * 85,
//         decoration: BoxDecoration(
//           color: CraftColors.neutralBlue850,
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               // Title
//               Text(
//                 textAlign: TextAlign.center,
//                 "What our learners say about us",
//                 style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 25),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               // Subtitle
//               Text(
//                 textAlign: TextAlign.center,
//                 "Real stories from students who’ve leveled up their filmmaking journey.",
//                 style: CraftStyles.tsWhiteNeutral300W500,
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               // Wrap the CustomScrollView inside Expanded to avoid unbounded height error
//               Container(
//                 height: SizeConfig.blockSizeVertical * 40,
//                 child: Flexible(
//                   child: CustomScrollView(
//                     slivers: [
//                       SliverStaggeredGrid.countBuilder(
//                         crossAxisCount: 2, // Number of columns
//                         itemCount: provider.gridItems.length,
//                         staggeredTileBuilder: (int index) {
//                           return StaggeredTile.fit(1); // Adjust this if needed
//                         },
//                         crossAxisSpacing: 8.0,
//                         mainAxisSpacing: 8.0,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Card(
//                             elevation: 1.0,
//                             color: CraftColors.neutralBlue800,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16.0),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: SizeConfig.blockSizeVertical * 1,
//                                   ),
//                                   RatingBar.builder(
//                                     initialRating: double.parse(
//                                         provider.gridItems[index]
//                                             ['rating']!), // set initial rating
//                                     minRating: 1, // minimum rating
//                                     direction: Axis
//                                         .horizontal, // horizontal or vertical
//                                     allowHalfRating:
//                                         true, // allow half star ratings
//                                     itemCount: 5, // number of stars
//                                     itemSize: 25, // size of each star
//                                     itemPadding: EdgeInsets.symmetric(
//                                         horizontal: 1.0), // space between stars
//                                     itemBuilder: (context, _) => Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     onRatingUpdate: (rating) {},
//                                   ),
//                                   SizedBox(
//                                     height: SizeConfig.blockSizeVertical * 1,
//                                   ),
//                                   Text(
//                                     provider.gridItems[index]['description'] ??
//                                         "No Description Available",
//                                     style: CraftStyles.tsNeutral500W500
//                                         .copyWith(fontSize: 18),
//                                   ),
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius:
//                                             15.0, // Circle radius (size of the circle)
//                                         backgroundImage: AssetImage(CraftImagePath
//                                             .image1), // Image from local assets
//                                       ),
//                                       SizedBox(
//                                         width:
//                                             SizeConfig.blockSizeHorizontal * 2,
//                                       ),
//                                       Text(
//                                         provider.gridItems[index]['title'] ??
//                                             "No Title Available",
//                                         style: CraftStyles.tsNeutral500W500,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Widget planPriceCard(String title, String price) {
//     return Container(
//       margin: EdgeInsets.all(6),
//       width: SizeConfig.blockSizeHorizontal * 95,
//       decoration: BoxDecoration(
//         color: CraftColors.neutralBlue750,
//         borderRadius: BorderRadius.all(Radius.circular(16)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               textAlign: TextAlign.center,
//               title,
//               style: CraftStyles.tswhiteW600.copyWith(fontSize: 20),
//             ),
//             SizedBox(
//               height: SizeConfig.blockSizeVertical * 2,
//             ),
//             // Subtitle
//             Text(
//               textAlign: TextAlign.center,
//               price,
//               style:
//                   CraftStyles.tswhiteW600.copyWith(fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget informationPlan(String title, String suTitle) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             textAlign: TextAlign.center,
//             title,
//             style: CraftStyles.tsWhiteNeutral300W500,
//           ),
//           SizedBox(
//             height: SizeConfig.blockSizeVertical * 2,
//           ),
//           Text(
//             textAlign: TextAlign.center,
//             suTitle,
//             style: CraftStyles.tsWhiteNeutral50W60016,
//           ),
//           Divider(
//             thickness: 0.1,
//           )
//         ],
//       ),
//     );
//   }

//   Widget simpleTransplantPlanWidget() {
//     return Consumer<LandingScreenProvider>(builder: (context, provider, child) {
//       return Container(
//         margin: EdgeInsets.all(8),
//         width: SizeConfig.safeBlockHorizontal * 85,
//         decoration: BoxDecoration(
//           color: CraftColors.neutralBlue850,
//           borderRadius: BorderRadius.all(Radius.circular(24)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               // Title
//               Text(
//                 textAlign: TextAlign.center,
//                 "Simple, transparent plans",
//                 style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 25),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               // Subtitle
//               Text(
//                 textAlign: TextAlign.center,
//                 "We believe Untitled should be accessible to all companies, no matter the size.",
//                 style: CraftStyles.tsWhiteNeutral300W500,
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               // Wrap the CustomScrollView inside Expanded to avoid unbounded height error
//               Card(
//                 elevation: 1.0,
//                 color: CraftColors.neutralBlue800,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       planPriceCard("Basic", "₹ 799/-"),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                       informationPlan(
//                           "Devices you can watch at the same time", "1"),
//                       informationPlan("Download devices", "No"),
//                       informationPlan("All courses across 7 categories", "No"),
//                       informationPlan("Access to sessions by CraftSchool",
//                           "Learn by doing in just 30 days."),
//                       informationPlan("Supported devicese",
//                           "Computer, TV, Phone or Tablet"),
//                       informationPlan("Join exclusive Community", "Yes"),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                       Center(
//                         child: SizedBox(
//                           width: SizeConfig.blockSizeHorizontal * 82,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: Size(
//                                   SizeConfig.blockSizeVertical * 45,
//                                   SizeConfig.blockSizeVertical * 5),
//                               backgroundColor: CraftColors.neutralBlue800,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 side: BorderSide(
//                                   color:
//                                       CraftColors.white, // Set the border color
//                                   width: 0.2, // Set the border width
//                                 ),
//                               ),
//                               elevation: 5,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   CraftStrings.strSubscribeNow,
//                                   style: CraftStyles.tsWhiteNeutral50W60016
//                                       .copyWith(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               Card(
//                 elevation: 1.0,
//                 color: CraftColors.neutralBlue800,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       planPriceCard("Standard", "₹ 4299/-"),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                       informationPlan(
//                           "Devices you can watch at the same time", "1"),
//                       informationPlan("Download devices", "No"),
//                       informationPlan("All courses across 7 categories", "No"),
//                       informationPlan("Access to sessions by CraftSchool",
//                           "Learn by doing in just 30 days."),
//                       informationPlan("Supported devicese",
//                           "Computer, TV, Phone or Tablet"),
//                       informationPlan("Join exclusive Community", "Yes"),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                       Center(
//                         child: SizedBox(
//                           width: SizeConfig.blockSizeHorizontal * 82,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: Size(
//                                   SizeConfig.blockSizeVertical * 45,
//                                   SizeConfig.blockSizeVertical * 5),
//                               backgroundColor: CraftColors.primaryBlue500,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 side: BorderSide(
//                                   // Set the border color
//                                   width: 0.2, // Set the border width
//                                 ),
//                               ),
//                               elevation: 5,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   CraftStrings.strSubscribeNow,
//                                   style: CraftStyles.tsWhiteNeutral50W60016
//                                       .copyWith(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//               Card(
//                 elevation: 1.0,
//                 color: CraftColors.neutralBlue800,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       planPriceCard("Premium", "₹ 8799/-"),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                       informationPlan(
//                           "Devices you can watch at the same time", "1"),
//                       informationPlan("Download devices", "No"),
//                       informationPlan("All courses across 7 categories", "No"),
//                       informationPlan("Access to sessions by CraftSchool",
//                           "Learn by doing in just 30 days."),
//                       informationPlan("Supported devicese",
//                           "Computer, TV, Phone or Tablet"),
//                       informationPlan("Join exclusive Community", "Yes"),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                       Center(
//                         child: SizedBox(
//                           width: SizeConfig.blockSizeHorizontal * 82,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: Size(
//                                   SizeConfig.blockSizeVertical * 45,
//                                   SizeConfig.blockSizeVertical * 5),
//                               backgroundColor: CraftColors.neutralBlue800,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 side: BorderSide(
//                                   color:
//                                       CraftColors.white, // Set the border color
//                                   width: 0.2, // Set the border width
//                                 ),
//                               ),
//                               elevation: 5,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   CraftStrings.strSubscribeNow,
//                                   style: CraftStyles.tsWhiteNeutral50W60016
//                                       .copyWith(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: SizeConfig.blockSizeVertical * 2,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(
//                 height: SizeConfig.blockSizeVertical * 2,
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
  
//     SizeConfig().init(context);

//     return ChangeNotifierProvider(
//         create: (_) => LandingScreenProvider(),
//         child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
//            print("widget.carousalImages");
//             print(provider.courses);
//        if (provider.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//           return Scaffold(
//               appBar: PreferredSize(
//                 preferredSize: const Size.fromHeight(kToolbarHeight),
//                 child: CustomAppBar(
//                   isContainerVisible: provider.isContainerVisible,
//                   isCategoryVisible: provider.isCategoryVisible,
//                   onMenuPressed: () {
//                     provider
//                         .toggleSlidingContainer(); // Trigger toggle when menu is pressed
//                   },
//                   onCategoriesPressed: () {
//                     provider.toggleSlidingCategory();
//                   },
//                 ),
//               ),
//               backgroundColor: CraftColors.black18,
//               bottomNavigationBar: BottomAppBarWidget(
//                 index: 0,
//               ),
//               floatingActionButton: FloatingActionButtonWidget(),
//               floatingActionButtonLocation:
//                   FloatingActionButtonLocation.centerDocked,
//               body: Stack(
//                 children: [
//                   ListView(
//                     shrinkWrap: true,
//                     physics: ScrollPhysics(),
//                     children: [
//                       masterClassBlock(),
//                       MasterImagesCarousel(carousalImages: provider.carousalImages,),
//                       // masterImages(),
//                       annualPlanSignUp(),
//                       everyMonthBlock(),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(
//                             routeGlobalKey.currentContext!,
//                           ).pushNamed(
//                             Coursedetailscreen.route,
//                           );
//                         },
//                         child: bannerImages(
//                             tag: "New !",
//                             title:
//                                 "The great screenplay makes everybody step up to the bar and deliver.",
//                             subTitle: "Learn from the living legend Salim khan",
//                             textStyle: CraftStyles.tssecondary800W500,
//                             textBackground: CraftColors.secondary100,
//                             image: CraftImagePath.bannerImage),
//                       ),
//                       masterOfCraftSchool(),
//                       browseCourse(),
//                       bannerImages(
//                           tag: "Exclusive",
//                           title:
//                               "A Legacy of Storytelling: The Final Teachings of Vikram Ghokle.",
//                           subTitle:
//                               "Recorded with profound insight and grace, this course is the last piece of wisdom Vikram Ghokle left us.",
//                           textStyle: CraftStyles.tsdarkBrownW500,
//                           textBackground: CraftColors.lightOrange,
//                           image: CraftImagePath.image4),
//                       categoryCourse(),
//                       bannerWatchVideo(
//                           tag: "",
//                           title:
//                               "Master the Filmmaking \nProcess with R. Balki",
//                           subTitle:
//                               "Start learning from R. Balki’s exclusive \ncourse – ",
//                           textStyle: CraftStyles.tsdarkBrownW500,
//                           textBackground: CraftColors.lightOrange,
//                           image: CraftImagePath.image9),
//                       storyTellingWidget(),
//                       joinCommunity(
//                           tag: "",
//                           title: "Join the CraftSchool \nCommunity",
//                           subTitle:
//                               "Connect with filmmakers and industry \nexperts, wherever you are.",
//                           textStyle: CraftStyles.tsdarkBrownW500,
//                           textBackground: CraftColors.lightOrange,
//                           image: CraftImagePath.bannerImage2,
//                           titleText: "Exclusive Community",
//                           subTitleText:
//                               "Unlock the ultimate experience with our \nExclusive Community! With a CraftSchool \nsubscription or course purchase, you’ll gain \naccess to:"),
//                       joinFlimFestival(),
//                       flimMakingJourney(),
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
//               ));
//         }));
//   }
// }
