import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlidingCategory extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpansion;

  const SlidingCategory({
    Key? key,
    required this.isExpanded,
    required this.onToggleExpansion,
  }) : super(key: key);

  @override
  _SlidingCategoryState createState() => _SlidingCategoryState();
}

class _SlidingCategoryState extends State<SlidingCategory> {
  String? expandedCategory;

  void toggleCategoryExpansion(String category) {
    setState(() {
      expandedCategory = expandedCategory == category ? null : category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: 0,
      right: 0,
      top: 0,
      height: widget.isExpanded ? SizeConfig.blockSizeVertical * 60 : 0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: CraftColors.neutralBlue800,
        child: Column(
          children: [
            if (widget.isExpanded)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return _CategoryTile(
                      category: categories[index],
                      isExpanded: expandedCategory == categories[index],
                      onTap: () => toggleCategoryExpansion(categories[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

const categories = [
  'Popular',
  'Cinematography',
  'Script writing',
  'Models Casting'
];

class _CategoryTile extends StatelessWidget {
  final String category;
  final bool isExpanded;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.category,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isExpanded ? CraftColors.neutralBlue750 : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              dense: true,
              leading: SvgPicture.asset(CraftImagePath.acting),
              title: Text(
                category,
                style:
                    CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
              ),
              trailing: AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: Duration(milliseconds: 300),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: CraftColors.neutral100,
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          child: isExpanded
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: CraftColors.neutralBlue750,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return _SubCategoryTile();
                    },
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}

// class _SubCategoryTile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//       child: Container(
//         decoration: BoxDecoration(
//           color: CraftColors.neutralBlue750,
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Container(
//                 width: SizeConfig.blockSizeHorizontal * 18,
//                 height: SizeConfig.safeBlockVertical * 5,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   image: DecorationImage(
//                     image: AssetImage(CraftImagePath.image9),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Embrace Eco-Friendly Living & Gardening",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: CraftStyles.tsWhiteNeutral50W700
//                           .copyWith(fontSize: 12),
//                     ),
//                     Text(
//                       "Vikram Ghokhale",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: CraftStyles.tsWhiteNeutral50W700
//                           .copyWith(fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _SubCategoryTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: CraftColors.neutralBlue750,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  CraftImagePath.image9,
                  width: SizeConfig.blockSizeHorizontal * 18,
                  height: SizeConfig.safeBlockVertical * 6,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Embrace Eco-Friendly Living & Gardening",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CraftStyles.tsWhiteNeutral50W700
                          .copyWith(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Vikram Ghokhale",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CraftStyles.tsWhiteNeutral50W600
                          .copyWith(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
