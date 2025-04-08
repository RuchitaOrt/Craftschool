import 'dart:async';

import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/MasterScreenDetail.dart';
import 'package:craft_school/screens/courseDetailScreen.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
   static const String route = "/searchScreen";
   SearchScreen({super.key});
   final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void _onSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel(); // Cancel previous timer

    _debounce = Timer(const Duration(milliseconds: 500), () { // Debounce API call
      if (query.isNotEmpty) {
        Provider.of<LandingScreenProvider>(routeGlobalKey.currentContext!, listen: false)
            .getSearchList(query);
      }
    });

  
      searchController.text = query; // Ensure text remains in field
      searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: searchController.text.length), // Keeps cursor at the end
      );
    
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
 
  }

  Widget _buildSearchBar(LandingScreenProvider provider) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: provider.toggleSearchIconCategory,
          ),
        ),
        Expanded(
          child: CustomTextFieldWidget(
            textFieldContainerHeight: 40,
            title: "",
            hintText: CraftStrings.strSearch,
            textEditingController: searchController,
            autovalidateMode: AutovalidateMode.disabled,
            onChange: _onSearch, // Text remains while API is called
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.search, color: CraftColors.neutral100),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return 
     Consumer<LandingScreenProvider>(
      builder: (context, provider, _) {

        return
    WillPopScope(
     onWillPop: ()async
      {
       provider.toggleSearchIconCategory();
        // provider.onBackPressed();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AppBar(
      backgroundColor: CraftColors.neutralBlue800,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace:  Padding(
            padding: const EdgeInsets.only(top: 5),
            child: _buildSearchBar(provider),
          )
          
            ),
    ),
              
              backgroundColor: CraftColors.black18,
        
        
          body: Stack(
                children: [
                serchView(provider),
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
      }
     );
}
Widget serchView(LandingScreenProvider provider)
{
  if(provider.isSearchLoading)
  {
    return Center(child:  CircularProgressIndicator(),);
  }
return  ListView(
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
                  );
}
}