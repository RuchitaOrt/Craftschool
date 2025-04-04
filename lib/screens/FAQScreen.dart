import 'package:craft_school/providers/Faq_provider.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';

class FAQScreen extends StatefulWidget {
  static const String route = "/faqScreen";

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  @override
  void initState() {
    super.initState();

    // Run the API calls when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerSubscription =
          Provider.of<LandingScreenProvider>(context, listen: false);

      if (!providerSubscription.isSubscriptionLoading) {
        providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI();
        
      }
     
      // Only call the API if it's not already loading
      final provider = Provider.of<FAQProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getFAQAPI();
      }
      for (var category in provider.faqList) {
      for (var question in provider.faqList.first.dataOfCategory) {
        _isExpandedMap[question.questionId] = false;
      }
    }
    });
  }

  // final Map<String, dynamic> jsonData = {
  //   "status": true,
  //   "message": "Data Found",
  //   "data": [
  //     {
  //       "cat_id": 8,
  //       "category_name": "Courses & Enrollment",
  //       "data_of_category": [
  //         {
  //           "question_id": 10,
  //           "question": "What kind of filmmaking courses do you offer?",
  //           "answer":
  //               "We offer a wide range of courses, including acting, editing, cinematography, scriptwriting, and more."
  //         },
  //         {
  //           "question_id": 6,
  //           "question": "How can I enroll in a course?",
  //           "answer": "You can buy a single course or take a subscription."
  //         },
  //         {
  //           "question_id": 5,
  //           "question": "Are the courses suitable for beginners?",
  //           "answer": "Yes"
  //         }
  //       ]
  //     },
  //     {
  //       "cat_id": 7,
  //       "category_name": "Community",
  //       "data_of_category": [
  //         {
  //           "question_id": 9,
  //           "question": "How can I join the community?",
  //           "answer":
  //               "You get that feature in Subscription. After that, you can see posts of masters or post in the community page."
  //         },
  //         {
  //           "question_id": 8,
  //           "question": "How does the filmmaking community work?",
  //           "answer":
  //               "You get that feature in Subscription. After that, you can see posts of masters or post in the community page."
  //         }
  //       ]
  //     }
  //   ]
  // };

  Map<int, bool> _isExpandedMap = {};


  @override
  Widget build(BuildContext context) {
   // List<dynamic> faqCategories = provider.faqList;

    return ChangeNotifierProvider(
      create: (_) => LandingScreenProvider(),
      child: Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: provider.isCategoryVisible,
                onMenuPressed: provider.toggleSlidingContainer,
                onCategoriesPressed: provider.toggleSlidingCategory,
                isContainerVisible: provider.isContainerVisible,
               
              ),
            ),
            backgroundColor: CraftColors.black18,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add FAQ Title
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "FAQ",
                          style: CraftStyles.tsWhiteNeutral50W60016.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Expanded to ensure ListView scrolls properly
                     Consumer<FAQProvider>(
                  builder: (context, provider, child) {return
                      Expanded(
                        child: ListView(
                          children: provider.faqList.map((category) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    category.categoryName,
                                    style: CraftStyles.tsWhiteNeutral50W60016
                                        .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: category.dataOfCategory
                                      .map<Widget>((question) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Card(
                                        color: CraftColors.neutralBlue800,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        elevation: 3,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            dividerColor: Colors.transparent,
                                          ),
                                          child: ExpansionTile(
                                            backgroundColor:
                                                CraftColors.neutralBlue800,
                                            tilePadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                            iconColor: CraftColors.neutral100,
                                            textColor: Colors.white,
                                            collapsedTextColor: Colors.white,
                                            title: Text(
                                              question.question,
                                              style: CraftStyles
                                                  .tsWhiteNeutral50W60016
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                            // Custom Plus/Minus Icon
                                            trailing: Icon(
                                              _isExpandedMap[question.questionId] ??
                                                      false
                                                  ? Icons.remove
                                                  : Icons.add,
                                              color: Colors.white,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            collapsedShape:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            onExpansionChanged: (expanded) {
                                              setState(() {
                                                _isExpandedMap[question.questionId] = expanded;
                                              });
                                            },
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text(
                                                  question.answer,
                                                  style: CraftStyles
                                                      .tsWhiteNeutral50W60016
                                                      .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      );})
                  
                    ],
                  ),
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
        },
      ),
    );
  }
}
