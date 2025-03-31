import 'package:craft_school/providers/GetServiceProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For SVG support
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:video_player/video_player.dart';

class AspiringTrainingScreen extends StatefulWidget {
   static const String route = "/services";
  const AspiringTrainingScreen({Key? key}) : super(key: key);

  @override
  _AspiringTrainingScreenState createState() => _AspiringTrainingScreenState();
}

class _AspiringTrainingScreenState extends State<AspiringTrainingScreen> {
    late VideoPlayerController _controller;
  bool _isControllerInitialized = false; // To track if the video controller has been initialized
 bool _isPlaying = false;
  @override
  void dispose() {
    if (_isControllerInitialized) {
      _controller.dispose(); // Dispose the controller if it was initialized
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    
    final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription
            .getcheckSubscriptionIndividualFlowWiseInfoAPI();
      }

    // Keeping your original code as requested
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GetServiceProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getServiceAPI();

        _controller = VideoPlayerController.network(provider.serviceData[3].media1)
          ..initialize().then((_) {
            setState(() {
              _isControllerInitialized = true; // Mark controller as initialized
            });
          });
      }
    });
  }
   // Function to toggle play/pause
  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause(); // Pause the video
      } else {
        _controller.play(); // Play the video
      }
      _isPlaying = !_isPlaying; // Toggle the play state
    });
  }

  @override
  Widget build(BuildContext context) {
 return 
      ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: 
        Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
        return
    WillPopScope(
      onWillPop: ()async
      {
        provider.onBackPressed();
        return false;
      },
      child: Scaffold(
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
              ),
            ),
        backgroundColor: CraftColors.black18,
        bottomNavigationBar: BottomAppBarWidget(index: 1,),
        floatingActionButton:FloatingActionButtonWidget(isOnLandingScreen: false,),
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
                  if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
                if (provider.isCategoryVisible) SlidingCategory(
                  isExpanded: provider.isCategoryVisible,
                  onToggleExpansion: provider.toggleSlidingCategory,
                ),
                ],
              ),
      ),
    );
      }));
  }

  Widget aspiringTraining() {
    return Consumer<GetServiceProvider>(
      builder: (context, provider, child) {
         if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
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
                  itemCount: provider.serviceData
                      .length, // Use the length of the list from provider
                  itemBuilder: (context, index) {
                    bool isOddIndex = index.isOdd; // Check if index is odd
 if (index == 3 && !_isControllerInitialized) {
                  _controller = VideoPlayerController.network(provider.serviceData[3].media1)
                    ..initialize().then((_) {
                      setState(() {
                        _isControllerInitialized = true; // Mark controller as initialized
                      });
                    });
                }

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
                                      SvgPicture.asset(
                                        provider.getImagePath(index),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 1),
                                      Text(
                                        provider.serviceData[index]
                                            .title,
                                        style: CraftStyles
                                            .tsWhiteNeutral50W60016
                                            .copyWith(fontSize: 14),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 2),
                                      Text(
                                        provider.serviceData[index]
                                            .description,
                                        style: CraftStyles.tsWhiteNeutral300W500
                                            .copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            // Second block (image)
                          index == 3
        ?  Container(
                            width: SizeConfig.blockSizeHorizontal * 40,  // Full width
                            height: SizeConfig.blockSizeVertical * 25, // Full height
                            child: _isControllerInitialized
                                ? Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: _controller.value.aspectRatio,
                                        child: VideoPlayer(_controller),
                                      ),
                                      // Play/Pause button in the center of the video
                                      Center(
                                        child: IconButton(
                                          icon: Icon(
                                            _isPlaying ? Icons.pause : Icons.play_arrow,
                                            color: Colors.white,
                                            size: 25, // Size of the button
                                          ),
                                          onPressed: _togglePlayPause, // Toggle play/pause
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(child: CircularProgressIndicator()),
                          ): Container(
                              width: SizeConfig.blockSizeHorizontal * 40,
                              height: SizeConfig.blockSizeVertical * 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: NetworkImage(provider
                                      .serviceData[index].media1),
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
                                      SvgPicture.asset(
                                        provider.getImagePath(index),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 1),
                                      Text(
                                        provider.serviceData[index].title
                                            ,
                                        style: CraftStyles
                                            .tsWhiteNeutral50W60016
                                            .copyWith(fontSize: 14),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 2),
                                      Text(
                                        provider.serviceData[index]
                                           .description,
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
