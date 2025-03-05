import 'dart:io';

import 'package:craft_school/dto/CategoryListResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/CategoryListProvider.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/signup_screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:provider/provider.dart';

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
    void _onSingleChipSelected(String? label) {
    setState(() {
       _selectedChip = label; // Update the selected chip
    });
     
    
  }
  Widget buildSubInfoCard(
      {required String title,
      required String subtitle,
      required Color color,
      required TextStyle titleStyle,
      required TextStyle subtitleStyle,
      required String image}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: subtitleStyle,
              ),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 28.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        image,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMostInterestedCard(
      {required String title,
      required String subtitle,
      required Color color,
      required TextStyle titleStyle,
      required TextStyle subtitleStyle,
      required int index}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: subtitleStyle,
              ),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 4),
              //multiseclection
              if (index == 2)
                Consumer<CategoryListProvider>(
                    builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: double
                              .infinity, // Makes the wrap take all available width
                          maxHeight: SizeConfig.blockSizeVertical * 31.5,
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Wrap(
                              alignment:
                                  WrapAlignment.center, // Centers the chips
                              spacing: 12.0, // Space between chips
                              runSpacing: 5.0, // Space between rows of chips
                              children: provider.categoryList.map((chip) {
                                return GestureDetector(
                                  onTap: () {
                                    provider.onChipSelected(chip
                                        .id.toString()); // Handle chip selection manually
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: provider.selectedChips
                                              .contains(chip.id.toString())
                                          ? Colors
                                              .transparent // No background color on selection
                                          : CraftColors
                                              .neutralBlue750, // Default background color
                                      border: Border.all(
                                        color: provider.selectedChips
                                                .contains(chip.id.toString())
                                            ? CraftColors.secondary550 // White border when selected
                                            : CraftColors
                                                .neutralBlue750, // Default border color
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.network(
                                        provider.selectedChips
                                                .contains(chip.id.toString())?chip.greenIcon:  chip.icon,
                                          height: 15.0,
                                          width: 15.0,
                                         
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          chip.categoryName,
                                          style: TextStyle(
                                              color: provider.selectedChips
                                                .contains(chip.id.toString())?CraftColors.secondary550: Colors.white,
                                              fontSize: 12 // Default text color
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ));
                }),
              //single selection
              if (index == 3)
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                  child: Wrap(
                    spacing: 0.0, // Space between chips
                    runSpacing: 12.0, // Space between rows of chips
                    children: _chipAccountData.map((chip) {
                      return SizedBox(
                        width: SizeConfig.blockSizeHorizontal *
                            100, // Ensures one chip per row
                        child: FilterChip(
                          label: SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    chip['image']!,
                                    height: 24.0,
                                    width: 24.0,
                                  ),
                                  SizedBox(width: 8),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      chip['label']!,
                                      style: TextStyle(
                                        color: _selectedChip == chip['label']
                                            ? Colors.white
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          selected: _selectedChip ==
                              chip['label'], // Only one chip can be selected
                          onSelected: (isSelected) {
                            // If this chip is selected, set it as the selected chip
                            _onSingleChipSelected(chip['label']);
                          },
                          selectedColor: CraftColors
                              .neutralBlue750, // Removes background color on selection
                          backgroundColor: CraftColors
                              .neutralBlue750, // Background color when unselected
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            side: BorderSide(
                              color: _selectedChip == chip['label']
                                  ? Colors.white // Thicker border when selected
                                  : Colors
                                      .white, // Light border when unselected
                              width: _selectedChip == chip['label']
                                  ? 1.0 // Thicker width when selected
                                  : 0.1, // Lighter width when unselected
                            ),
                          ),
                          elevation: 0, // No shadow
                          showCheckmark:
                              false, // This removes the checkmark symbol!
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigatorWidget() {
    return Consumer<CategoryListProvider>(
                    builder: (context, provider, child) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: SvgPicture.asset(CraftImagePath.leftArrow),
            onPressed: () {
              setState(() {
                if (nextButtonClickCount > 0) {
                  nextButtonClickCount--; // Reverse the order on back button click
                  if (highlightedCardIndex > 0) {
                    highlightedCardIndex--;
                  }
                }
              });
            },
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(
                    routeGlobalKey.currentContext!,
                  ).pushNamedAndRemoveUntil(
                    LandingScreen.route,
                    (route) => false,
                  );
                },
                child: Text(
                  CraftStrings.strSkip,
                  style: CraftStyles.tsWhiteNeutral50W60016,
                ),
              ),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Increase the count on each click
                    if (nextButtonClickCount == 2) {
                      print("next click");
                      print(provider.selectedChips);
                     if(provider.selectedChips.isNotEmpty)
                     {
                       nextButtonClickCount++;
                       highlightedCardIndex = 2; // "Pick Your Path"
                     }else{
         
                      ShowDialogs.showToast("Please Select Category");
                    
                     }
                    }else
                    if (nextButtonClickCount < 4) {
                      print(nextButtonClickCount);
                      nextButtonClickCount++;
                      print(nextButtonClickCount);
                    }
                    if (nextButtonClickCount == 1) {
                      highlightedCardIndex = 0; // "Welcome to CraftSchool"
                    } else if (nextButtonClickCount == 2) {
                      highlightedCardIndex = 1; // "Create an Account"
                    } else if (nextButtonClickCount == 3) {
                      print("next click");
                      print(provider.selectedChips);
                     if(provider.selectedChips.isNotEmpty)
                     {
                       highlightedCardIndex = 2; // "Pick Your Path"

                       GlobalLists.selectedCategoryChipId=provider.selectedChips.join(',');
                     }else{
         
                      ShowDialogs.showToast("Please Select Category");
                    
                     }
                    } else if (nextButtonClickCount == 4) {
                      Navigator.of(
                        routeGlobalKey.currentContext!,
                      ).pushNamed(
                        SignUpScreen.route,
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CraftColors.primaryBlue550,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  CraftStrings.strNext,
                  style: CraftStyles.tsWhiteNeutral50W60016,
                ),
              ),
            ],
          ),
        ],
      ),
    );
                    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryListProvider>(context, listen: false).getCategoryList();
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
              height: Platform.isAndroid
                  ? SizeConfig.blockSizeVertical * 36
                  : SizeConfig.blockSizeVertical * 32,
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
                      height: Platform.isAndroid
                          ? SizeConfig.blockSizeVertical * 19.5
                          : SizeConfig.blockSizeVertical * 15.5,
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
          if (nextButtonClickCount < 2)
            buildSubInfoCard(
              title: subInfoData[nextButtonClickCount]['title']!,
              subtitle: subInfoData[nextButtonClickCount]['subtitle']!,
              image: subInfoData[nextButtonClickCount]['image']!,
              color: CraftColors.neutralBlue800,
              titleStyle: CraftStyles.tsWhiteNeutral50W70016,
              subtitleStyle: CraftStyles.tsWhiteNeutral300W500,
            ),
          if (nextButtonClickCount == 2)
            buildMostInterestedCard(
                title: "What are you most interested in?",
                subtitle:
                    "Select the areas of filmmaking you’d like to explore.",
                color: CraftColors.neutralBlue800,
                titleStyle: CraftStyles.tsWhiteNeutral50W70016,
                subtitleStyle: CraftStyles.tsWhiteNeutral300W500,
                index: 2),
          if (nextButtonClickCount == 3)
            buildMostInterestedCard(
                title: CraftStrings.str03Intro,
                subtitle: CraftStrings.strAccountDetail,
                color: CraftColors.neutralBlue800,
                titleStyle: CraftStyles.tsWhiteNeutral50W70016,
                subtitleStyle: CraftStyles.tsWhiteNeutral300W500,
                index: 3),
          bottomNavigatorWidget(),
        ],
      ),
    );
  }

  getCategoryListApi() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      var jsonbody = "";
      APIManager().apiRequest(context, API.categoryList, (response) async {
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
