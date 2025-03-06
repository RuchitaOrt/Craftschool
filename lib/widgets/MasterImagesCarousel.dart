import 'dart:async';
import 'package:craft_school/dto/LandingScreenResponse.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';  // Correct import

class MasterImagesCarousel extends StatefulWidget {
 final List<CarousalImagesDatum> carousalImages;
  const MasterImagesCarousel({Key? key, required this.carousalImages}) : super(key: key);

  @override
  _MasterImagesCarouselState createState() => _MasterImagesCarouselState();
}

class _MasterImagesCarouselState extends State<MasterImagesCarousel> {
  late Timer _timer;
  int _currentPage = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();  // Corrected CarouselController

  @override
  void initState() {
    super.initState();
    print("widget.carousalImages");
    print(widget.carousalImages);
    if(widget.carousalImages.isNotEmpty)
    {
    _startAutoScrolling();
    }

  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Start the auto-scrolling functionality
  void _startAutoScrolling() {
    if (_carouselController != null) {

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      // Loop the carousel when we reach the last item
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back to the first image
      }

      _carouselController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.carousalImages.isNotEmpty?SizedBox(
      height: SizeConfig.blockSizeVertical * 20,
      child: CarouselSlider.builder(
        itemCount: widget.carousalImages.length,
        carouselController: _carouselController,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          double scale = 1.0;
          if (realIndex == _currentPage) {
            scale = 1.2; // Enlarge center image
          } else if (realIndex == _currentPage - 1 || realIndex == _currentPage + 1) {
            scale = 0.8; // Smaller adjacent images
          }
    
          return Transform.scale(
            scale: scale,  // Apply the scale to images
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),  // Adjust margin between images
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.carousalImages[index].imageUrl,
                  width: SizeConfig.safeBlockHorizontal * 33,  // 33% of screen width per image
                  height: SizeConfig.blockSizeVertical * 20,
                  fit: BoxFit.cover,  // Make sure the image covers the container
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,  // Enable auto-play
          enlargeCenterPage: true,  // Enlarge the center image
          aspectRatio: 16 / 9,  // Adjust aspect ratio if needed
          autoPlayInterval: Duration(seconds: 3),  // Auto scroll interval
          enableInfiniteScroll: true,  // Infinite scrolling
          scrollPhysics: BouncingScrollPhysics(),
          viewportFraction: 0.33,  // Ensure 3 images fit on screen
        ),
      ),
    ):Container();
  }
}

