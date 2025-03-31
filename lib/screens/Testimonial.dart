import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/TestimonialProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart'; // For SizeConfig

class Testimonial extends StatefulWidget {
   static const String route = "/testimonial";
  const Testimonial({Key? key}) : super(key: key);

  @override
  _TestimonialScreenState createState() => _TestimonialScreenState();
}

class _TestimonialScreenState extends State<Testimonial> {
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
      final provider = Provider.of<TestimonialProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getTestimonialAPI();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
 return  ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: 
        Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
        return

    Scaffold(
     appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: provider.isCategoryVisible,
                onMenuPressed: () {
                  provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                },
                   onCategoriesPressed: () {  provider.toggleSlidingCategory();}, isContainerVisible: provider.isContainerVisible,
              ),
            ),
      backgroundColor: CraftColors.black18,
      
      body: Stack(
              children: [
                // Wrap ListView with ConstrainedBox to ensure it gets proper layout constraints
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 0.0, maxHeight: double.infinity),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                
                      realWidget()
                     
                      
                    ],
                  ),
                ),
                if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
              if (provider.isCategoryVisible) SlidingCategory(
                isExpanded: provider.isCategoryVisible,
                onToggleExpansion: provider.toggleSlidingCategory,
              ),
              ],
            ),
    );
      }));
  }

  Widget realWidget() {
    return Consumer<TestimonialProvider>(builder: (context, provider, child) {
       if(provider.isLoading)
      {
        return Center(child: CircularProgressIndicator());
      }
      return Container(
        margin: EdgeInsets.all(8),
        width: SizeConfig.safeBlockHorizontal * 85,
        decoration: BoxDecoration(
          color: CraftColors.neutralBlue850,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Title
              Text(
                textAlign: TextAlign.center,
                "What our learners say about us",
                style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 25),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              // Subtitle
              Text(
                textAlign: TextAlign.center,
                "Real stories from students who’ve leveled up their filmmaking journey.",
                style: CraftStyles.tsWhiteNeutral300W500,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              // Wrap the CustomScrollView inside Expanded to avoid unbounded height error
              Container(
                height: SizeConfig.blockSizeVertical * 60,
                //removed fleible from here
                child: CustomScrollView(
                  slivers: [
                    SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 2, // Number of columns
                      itemCount: provider.testimonialData.length,
                      staggeredTileBuilder: (int index) {
                        return StaggeredTile.fit(1); // Adjust this if needed
                      },
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 1.0,
                          color: CraftColors.neutralBlue800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                RatingBar.builder(
                                  tapOnlyMode: false,
                                  updateOnDrag: false,
                                  ignoreGestures: true,
                                  initialRating: double.parse(
                                      provider.testimonialData[index].rating.toString()
                                          ), // set initial rating
                                  minRating:0, // minimum rating
                                  direction: Axis
                                      .horizontal, // horizontal or vertical
                                  allowHalfRating:
                                      true, // allow half star ratings
                                  itemCount: 5, // number of stars
                                  itemSize: 25, // size of each star
                                  itemPadding: EdgeInsets.symmetric(
                                      horizontal: 1.0), // space between stars
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Text(
                                  provider.testimonialData[index].description ??
                                  "",
                                  style: CraftStyles.tsNeutral500W500
                                      .copyWith(fontSize: 18),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius:
                                          15.0, // Circle radius (size of the circle)
                                      backgroundImage: NetworkImage(provider.testimonialData[index].photo!), // Image from local assets
                                    ),
                                    SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    Text(
                                      provider.testimonialData[index].name ??
                                          "",
                                      style: CraftStyles.tsNeutral500W500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
            ],
          ),
        ),
      );
    });
  }

}
