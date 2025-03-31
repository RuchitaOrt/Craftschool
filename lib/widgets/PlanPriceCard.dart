import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
class PlanPriceCard extends StatelessWidget {
  final String title;
  final String price;
  final int planId;
  final bool isStandard;
  final int index; // Unique index for each plan card
  final int selectedPlanIndex; // Index of the selected plan from parent
  final Function(String,String ,int) onCheckboxChange; // Callback to handle checkbox selection with both title and planId

  PlanPriceCard({
    required this.title,
    required this.price,
    required this.isStandard,
    required this.index,
    required this.selectedPlanIndex,
    required this.onCheckboxChange,
    required this.planId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      width: SizeConfig.blockSizeHorizontal * 95,
      decoration: BoxDecoration(
        gradient: isStandard
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [CraftColors.secondary550, CraftColors.primaryBlue500],
              )
            : LinearGradient(
                colors: [CraftColors.neutralBlue800, CraftColors.neutralBlue800],
              ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: selectedPlanIndex == planId, // Check if this plan is selected
                  onChanged: (bool? newValue) {
                    if (newValue != null && newValue) {
                      // Notify parent of the change with both title and planId
                      onCheckboxChange(title,price ,planId);
                    }
                  },
                  activeColor: CraftColors.primaryBlue500,
                  checkColor: CraftColors.neutral100,
                ),
                Text(
                  title,
                  style: CraftStyles.tswhiteW600.copyWith(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1),
            Text(
              price,
              style: CraftStyles.tswhiteW600.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

