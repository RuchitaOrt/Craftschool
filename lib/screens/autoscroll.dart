import 'dart:async';
import 'package:craft_school/dto/MasterListResponse.dart';
import 'package:craft_school/providers/MasterAllProvider.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:provider/provider.dart';

class SlantedImageReel extends StatefulWidget {
  @override
  _SlantedImageReelState createState() => _SlantedImageReelState();
}

class _SlantedImageReelState extends State<SlantedImageReel> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;


  @override
  void initState() {
    super.initState();
 final provider = Provider.of<MasterAllProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getMasterAllAPI();
       
       
      }
   
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + 2, // Moves right continuously
          duration: Duration(milliseconds: 50),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gridHeight = MediaQuery.of(context).size.height * 0.3;

    return    Consumer<MasterAllProvider>(
                builder: (context, provider, child) {return SizedBox(
      height: gridHeight,
      width: screenWidth, // Full width
      child: GridView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal, // Scroll in horizontal direction
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120, // Controls height of each image
          mainAxisSpacing: 10,
          crossAxisSpacing: 17,
          childAspectRatio: 1, // Square items
        ),
        itemCount: provider.masterAllData.length * 1000, // Infinite effect
        itemBuilder: (context, index) {
          return _buildSlantedImage(provider.masterAllData[index % provider.masterAllData.length]);
        },
      ),
    );
                });
  }

  Widget _buildSlantedImage(Datum imagePath) {
    return Transform.rotate(
      angle: -0.15,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(imagePath.masterImage),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1),
          ],
        ),
      ),
    );
  }
}
