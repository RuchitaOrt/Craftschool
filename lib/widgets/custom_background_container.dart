import 'dart:io';

import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBackgroundContainer extends StatelessWidget {
  const CustomBackgroundContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height:Platform.isAndroid?SizeConfig.blockSizeVertical * 20: SizeConfig.blockSizeVertical * 18,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CraftImagePath.backGroundimage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: const IntroTextSection(), // Call the extracted widget
      ),
    );
  }
}

class IntroTextSection extends StatelessWidget {
  const IntroTextSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
            CraftStrings.strGetSignInsubIntro,
            style: CraftStyles.tsWhiteNeutral100W500,
          ),
        ],
      ),
    );
  }
}
