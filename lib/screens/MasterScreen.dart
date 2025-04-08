import 'package:craft_school/providers/CourseDetailProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/BrowseOtherCourse.dart';
import 'package:craft_school/widgets/BrowseTrendingCourse.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/ImageGridView.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
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
      if (!provider.isLoading) {
        provider.getMasterAllAPI();
       
        provider.getTrendingClassAPI();
      }
      if(!provider.istrendingMasterLoading)
      {
 provider.getTrendingMasterAPI();
      }
    });
  }
   Widget browseOtherCourse() {
    return Consumer<MasterAllProvider>(
    builder: (context, provider, child) {
      return 
       BrowseTrendingCourse(imagePaths:provider.trendingClassData ,title: CraftStrings.strTrendingClass,onPressed: ()
       {
    
       },
        onSaveButtonOnTap: (index) {
                  provider.saveTrendingCourse(index);
                },
                onunSaveButtonOnTap: (index) {
                  provider.unsaveTrendingCourse(index);
                },);
      
    },
        );
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
                }, isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
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
                     ImageGridView(imagePaths:  provider.masterAllData),
                        TrendingSkill(imagePaths:provider.trendingMasterData ,title:  CraftStrings.strtrendingSkills,onPressed: ()
         {

         },),
                      browseOtherCourse(),
                    
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

}
