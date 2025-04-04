import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/MasterScreenDetail.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
     Consumer<LandingScreenProvider>(
      builder: (context, provider, _) {return
    Scaffold(
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
                isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
              ),
            ),
            backgroundColor: CraftColors.black18,
      
      
        body: Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: 
                    ListView.builder(
                               shrinkWrap: true,
                               scrollDirection: Axis.vertical,
                               physics: ScrollPhysics(),
                               itemCount:provider.searchList.length,
                               itemBuilder: (context, index) {
                                 // return Text("kk");
                                
                                 return GestureDetector(
                                   onTap: ()
                                   {
                                    if( provider.searchList[index].tag==1)
                                    {
Navigator.of(routeGlobalKey.currentContext!)
                                              .pushNamed(Coursedetailscreen.route, arguments: provider.searchList[index].slugName)
                                              .then((value) {});
                                    }else{
                                       Navigator.of(routeGlobalKey.currentContext!)
                      .pushNamed(
                        MasterScreenDetail.route,arguments:provider.searchList[index].slugName
                      )
                      .then((value) {});
                                    }
                                     
                                   },
                                   child: Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Padding(
                                       padding: const EdgeInsets.only(left: 8,top: 8),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Container(
                                                 width: SizeConfig.blockSizeHorizontal * 20,
                                                 height: SizeConfig.safeBlockVertical * 8,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(4),
                                                   image: DecorationImage(
                                                     image: NetworkImage(provider.searchList[index].image),
                                                     fit: BoxFit.cover,
                                                   ),
                                                 ),
                                               ),
                                               SizedBox(
                                                 width: SizeConfig.blockSizeHorizontal * 2,
                                               ),
                                               Container(
                                                 width: SizeConfig.blockSizeHorizontal * 60,
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Text(
                                                                                                     provider.searchList[index].tag==1?provider.searchList[index].courseName!:     provider.searchList[index].masterName!,
                                                       maxLines: 2,
                                                       overflow: TextOverflow.ellipsis,
                                                       style: CraftStyles.tsWhiteNeutral50W700.copyWith(
                                                         fontSize: 12,
                                                       ),
                                                     ),
                                                     Text(
                                                                                            provider.searchList[index].tag==1?"Course":"Master",
                                                       maxLines: 2,
                                                       overflow: TextOverflow.ellipsis,
                                                       style: CraftStyles.tsWhiteNeutral300W500.copyWith(
                                                         fontSize: 10,
                                                       ),
                                                     ),
                                                     
                                                    
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           ),
                                           Divider(thickness: 0.2,)
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
                if (provider.isContainerVisible)
                  SlidingMenu(isVisible: provider.isContainerVisible),
                if (provider.isCategoryVisible)
                  SlidingCategory(
                    isExpanded: provider.isCategoryVisible,
                    onToggleExpansion: provider.toggleSlidingCategory,
                  ),
              ],
            ),
      
      

    );
      }
     );
}
}