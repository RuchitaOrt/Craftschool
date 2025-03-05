import 'dart:io';

import 'package:craft_school/dto/CategoryListResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/signup_screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/utils/craft_images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int nextButtonClickCount =
      0; // Track the number of times the "Next" button is clicked
  int highlightedCardIndex =
      0; // Initially, "Welcome to CraftSchool" is highlighted
  final List<Map<String, String>> subInfoData = [
    {
      'title':
          'Every membership gives you full access to our expanding library of 100+ industry-leading instructors.',
      'subtitle': 'Try CraftSchool for 30 days, risk free.',
      'image': CraftImagePath.frame2
    },
    {
      'title': 'Awesome! Each lesson takes just 15-20 mins.',
      'subtitle': 'Easily fit our short, focused lessons into your schedule.',
      'image': CraftImagePath.frame1
    },
  ];

  final List<Map<String, String>> _chipData = [
    {'label': 'Model Casting', 'image': CraftImagePath.modelCasting},
    {'label': 'Acting', 'image': CraftImagePath.acting},
    {'label': 'Editing', 'image': CraftImagePath.editing},
    {'label': 'Executive Production', 'image': CraftImagePath.executiveprod},
    {'label': 'Cinematographt', 'image': CraftImagePath.cinematography},
    {'label': 'Make-Up', 'image': CraftImagePath.makeup},
    {'label': 'Script Writing', 'image': CraftImagePath.scriptwriting},
    {'label': 'Flim Production', 'image': CraftImagePath.flimproduction},
    {'label': 'Line Production', 'image': CraftImagePath.lineproduction},
    {'label': 'Song Writing', 'image': CraftImagePath.songwriting},
    {'label': 'Actors Casting', 'image': CraftImagePath.actorcasting},
  ];
  final List<Map<String, String>> _chipAccountData = [
    {'label': 'Google', 'image': CraftImagePath.google},
    {'label': 'Apple', 'image': CraftImagePath.apple},
    {'label': 'Email', 'image': CraftImagePath.mail},
  ];
  String? _selectedChip;
  Set<String> _selectedChips = Set<String>();
  void _onSingleChipSelected(String? label) {
    setState(() {
      _selectedChip = label; // Update the selected chip
    });
  }

  void _onChipSelected(String label) {
    setState(() {
      if (_selectedChips.contains(label)) {
        _selectedChips.remove(label);
      } else {
        _selectedChips.add(label);
      }
    });
  }

 
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryListApi();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CraftColors.black,
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height:Platform.isAndroid? SizeConfig.blockSizeVertical * 36:SizeConfig.blockSizeVertical * 32,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(CraftImagePath.backGroundimage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:Platform.isAndroid?  SizeConfig.blockSizeVertical * 19.5:SizeConfig.blockSizeVertical * 15.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(CraftImagePath.whiteCamera),
                          SizedBox(height: SizeConfig.blockSizeVertical * 3),
                          Text(
                            CraftStrings.strGetIntro,
                            style: CraftStyles.tsWhiteNeutral50W700,
                          ),
                          Text(
                            CraftStrings.strGetsubIntro,
                            style: CraftStyles.tsWhiteNeutral100W500,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        // Card 1 (Pick Your Path)
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 25,
                          height: SizeConfig.blockSizeVertical * 12,
                          decoration: BoxDecoration(
                            color: highlightedCardIndex == 0
                                ? Colors
                                    .white // Highlight with white if 1st card is active
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                width: 0.1,
                                color: Colors.black.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 0.8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  CraftStrings.str01,
                                  style: highlightedCardIndex == 0
                                      ? CraftStyles.tsNeutral100W400
                                      : CraftStyles.tsNeutral500W500,
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeHorizontal * 2),
                                Text(
                                  CraftStrings.str01Intro,
                                  style: highlightedCardIndex == 0
                                      ? CraftStyles.tsNeutral100W900
                                      : CraftStyles.tsWhiteNeutral50W600,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
                        // Card 2 (Welcome to CraftSchool)
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 25,
                          height: SizeConfig.blockSizeVertical * 12,
                          decoration: BoxDecoration(
                            color: highlightedCardIndex == 1
                                ? Colors
                                    .white // Highlight with white if 2nd card is active
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                width: 0.1,
                                color: Colors.black.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 0.8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  CraftStrings.str02,
                                  style: highlightedCardIndex == 1
                                      ? CraftStyles.tsNeutral100W400
                                      : CraftStyles.tsNeutral500W500,
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeHorizontal * 2),
                                Text(
                                  CraftStrings.str02Intro,
                                  style: highlightedCardIndex == 1
                                      ? CraftStyles.tsNeutral100W900
                                      : CraftStyles.tsWhiteNeutral50W600,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
                        // Card 3 (Create an Account)
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 25,
                          height: SizeConfig.blockSizeVertical * 12,
                          decoration: BoxDecoration(
                            color: highlightedCardIndex == 2
                                ? Colors
                                    .white // Highlight with white if 3rd card is active
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                width: 0.1,
                                color: Colors.black.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 0.8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  CraftStrings.str03,
                                  style: highlightedCardIndex == 2
                                      ? CraftStyles.tsNeutral100W400
                                      : CraftStyles.tsNeutral500W500,
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeHorizontal * 2),
                                Text(
                                  CraftStrings.str03Intro,
                                  style: highlightedCardIndex == 2
                                      ? CraftStyles.tsNeutral100W900
                                      : CraftStyles.tsWhiteNeutral50W600,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }

   getCategoryListApi() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
     var jsonbody="";
           APIManager().apiRequest(context, API.categoryList,
          (response) async {
        CategoryListResponse resp = response;
       print(resp.data);
       
      }, (error) {
        ShowDialogs.showToast("Server Not Responding");
      }, path: jsonbody);
    } else {
      setState(() {});
      //  Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
}
