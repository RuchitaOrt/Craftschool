import 'package:craft_school/providers/CourseDetailProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/BrowseOtherCourse.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/ImageGridView.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/TrendingSkill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MasterScreen extends StatefulWidget {
  static const String route = "/masterScreen";
  const MasterScreen({Key? key}) : super(key: key);

  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
   Widget browseOtherCourse() {
    return ChangeNotifierProvider(
      create: (_) => CourseDetailProvider(),
      child: Consumer<CourseDetailProvider>(
      builder: (context, provider, child) {
        return 
         BrowseOtherCourse(imagePaths:provider.imagePaths ,title:  "Trending Classes",onPressed: ()
         {

         },);
        
      },
    ));
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
                  provider.toggleSlidingContainer(); // Trigger toggle when menu is pressed
                  
                },   onCategoriesPressed: () {  }, isContainerVisible: false,
              ),
            ),
            backgroundColor: CraftColors.black18,
            bottomNavigationBar: BottomAppBarWidget(index: -1,),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                                        "Masters of the CraftSchool",
                                        style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 16),
                                      ),
                      ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
                     ImageGridView(imagePaths:  provider.imagePaths),
                        TrendingSkill(imagePaths:provider.imagePaths ,title:  CraftStrings.strtrendingSkills,onPressed: ()
         {

         },),
                      browseOtherCourse(),
                    
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

}
