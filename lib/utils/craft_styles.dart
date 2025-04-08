import 'package:craft_school/utils/craft_colors.dart';
import 'package:flutter/material.dart';

class CraftStyles {
  CraftStyles._privateConstructor();
   static const TextStyle tswhiteW600 = TextStyle(
    color: CraftColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 25.0,
  );
  static const TextStyle tssecondary550W700 = TextStyle(
    color: CraftColors.secondary550,
    fontWeight: FontWeight.w700,
    fontSize: 25.0,
  );
  static const TextStyle tsWhiteNeutral50W700 = TextStyle(
    color: CraftColors.neutral50,
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
  );
  static const TextStyle tsWhiteNeutral300W500 = TextStyle(
    color: CraftColors.neutral300,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
    static const TextStyle tsWhiteNeutral200W500 = TextStyle(
    color: CraftColors.neutral200,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
    static const TextStyle tsPrimaryblue500300W500 = TextStyle(
    color: CraftColors.primaryBlue500,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
  
    static const TextStyle tsWhiteNeutral300W300 = TextStyle(
    color: CraftColors.neutral300,
    fontWeight: FontWeight.w300,
    fontSize: 14.0,
  );
   static const TextStyle tsWhiteNeutral500W400 = TextStyle(
    color: CraftColors.neutral500,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );
   static const TextStyle tsWhiteNeutral300W400 = TextStyle(
    color: CraftColors.neutral300,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );
    static const TextStyle tsWhiteNeutral300W50012 = TextStyle(
    color: CraftColors.neutral300,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );
  static const TextStyle tsWhiteNeutral50W70016 = TextStyle(
    color: CraftColors.neutral50,
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
  );
   
  static const TextStyle tsWhiteNeutral50W60016 = TextStyle(
    color: CraftColors.neutral50,
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
  );
  static const TextStyle tsWhiteNeutral100W500 = TextStyle(
    color: CraftColors.neutral100,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );
  static const TextStyle tssecondary800W500 = TextStyle(
    color: CraftColors.secondary800,
    fontWeight: FontWeight.w500,
    fontSize: 10.0,
  );
    static const TextStyle tsdarkBrownW500 = TextStyle(
    color: CraftColors.darkBrown,
    fontWeight: FontWeight.w500,
    fontSize: 10.0,
  );
   static const TextStyle tspurpleW500 = TextStyle(
    color: CraftColors.purple,
    fontWeight: FontWeight.w500,
    fontSize: 10.0,
  );
  static const TextStyle tsWhiteNeutral100W50014 = TextStyle(
    color: CraftColors.neutral100,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
  static const TextStyle tsNeutral100W400 = TextStyle(
    color: CraftColors.neutral400,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );
    static const TextStyle tsNeutral100W40010 = TextStyle(
    color: CraftColors.neutral400,
    fontWeight: FontWeight.w800,
    fontSize: 10.0,
  );
  static const TextStyle tsNeutral500W500 = TextStyle(
    color: CraftColors.neutral50,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );

  static const TextStyle tsNeutral100W900 = TextStyle(
    color: CraftColors.neutral900,
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
  );
  static const TextStyle tsWhiteNeutral50W600 = TextStyle(
    color: CraftColors.neutral50,
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
  );

 static Color getTagBackgroundColor(String tag) {
  switch (tag) {
    case "New":
      return CraftColors.secondary100;
    case "Exclusively":
      return CraftColors.redlight;
    case "On Demand":
      return CraftColors.purplelight;
    default:
      return CraftColors.secondary100;
  }
}

static TextStyle getTagTextStyle(String tag) {
  switch (tag) {
    case "New":
      return tssecondary800W500;
      
    case "Exclusively":
      return tsdarkBrownW500;
    case "On Demand":
      return tspurpleW500;
    default:
      return tssecondary800W500;
  }
}
}
