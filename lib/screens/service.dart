import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For SVG support
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';

class AspiringTrainingScreen extends StatefulWidget {
   static const String route = "/services";
  const AspiringTrainingScreen({Key? key}) : super(key: key);

  @override
  _AspiringTrainingScreenState createState() => _AspiringTrainingScreenState();
}

class _AspiringTrainingScreenState extends State<AspiringTrainingScreen> {
  @override
  Widget build(BuildContext context) {
 return 
      ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: 
        Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
        return
    Scaffold(
     appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: false,
                onMenuPressed: () {
                  provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                },
                   onCategoriesPressed: () {  }, isContainerVisible: false,
              ),
            ),
      backgroundColor: CraftColors.black18,
      bottomNavigationBar: BottomAppBarWidget(index: 1,),
      floatingActionButton:FloatingActionButtonWidget(),
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
                
                       aspiringTraining(),
                     
                      
                    ],
                  ),
                ),
                if (provider.isContainerVisible)
                        SlidingMenu(isVisible: provider.isContainerVisible),
              ],
            ),
    );
      }));
  }

  Widget aspiringTraining() {
    return Consumer<LandingScreenProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Why Aspiring Filmmakers Choose Us for Training",
                style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: provider.aspiringListItems
                      .length, // Use the length of the list from provider
                  itemBuilder: (context, index) {
                    bool isOddIndex = index.isOdd; // Check if index is odd

                    return Container(
                      margin: EdgeInsets.all(8),
                      width: SizeConfig.safeBlockHorizontal * 80,
                      decoration: BoxDecoration(
                        color: CraftColors.neutralBlue800,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: isOddIndex
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            // First block (text)
                            if (!isOddIndex) ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(provider
                                          .aspiringListItems[index]['icon']!),
                                      SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 1),
                                      Text(
                                        provider.aspiringListItems[index]
                                            ['title']!,
                                        style: CraftStyles
                                            .tsWhiteNeutral50W60016
                                            .copyWith(fontSize: 14),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 2),
                                      Text(
                                        provider.aspiringListItems[index]
                                            ['subtext']!,
                                        style: CraftStyles.tsWhiteNeutral300W500
                                            .copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            // Second block (image)
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 40,
                              height: SizeConfig.blockSizeVertical * 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: AssetImage(provider
                                      .aspiringListItems[index]['image']!),
                                  fit: BoxFit
                                      .cover, // Optional: Ensures the image scales properly
                                ),
                              ),
                            ),
                            // Add first block (text) on the right when index is odd
                            if (isOddIndex) ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(provider
                                          .aspiringListItems[index]['icon']!),
                                      SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 1),
                                      Text(
                                        provider.aspiringListItems[index]
                                            ['title']!,
                                        style: CraftStyles
                                            .tsWhiteNeutral50W60016
                                            .copyWith(fontSize: 14),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 2),
                                      Text(
                                        provider.aspiringListItems[index]
                                            ['subtext']!,
                                        style: CraftStyles.tsWhiteNeutral300W500
                                            .copyWith(fontSize: 12),
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
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
