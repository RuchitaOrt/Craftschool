import 'package:craft_school/main.dart';
import 'package:craft_school/providers/membership_provider.dart';
import 'package:craft_school/screens/successful_screen.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/PlanPriceCard.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/sign_In_provider.dart';

class ChangePlan extends StatelessWidget {
  
  static const String route = "/changePlan` ";
  ChangePlan({super.key});
  final BorderRadius borderRadius = const BorderRadius.all(
    Radius.circular(8),
  );
  final BorderSide focusedBorder = const BorderSide(
    width: 1.0,
  );
  final BorderSide enableBorder = BorderSide(
    width: 1.0,
  );

 

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                 isCategoryVisible:false,
                onMenuPressed: () {
                  // provider.toggleSlidingContainer(); // Trigger toggle when menu is pressed
                },
                onCategoriesPressed: () {  }, isContainerVisible: false,
              ),
            ),
            backgroundColor: CraftColors.black18,
      body: ChangeNotifierProvider(
        create: (_) => MembershipProvider(),
        child:
        Consumer<MembershipProvider>(
                  builder: (context, membershipProvider, _) {return Padding(
          padding: const EdgeInsets.only(left: 14,right: 14),
          child: ListView(
            shrinkWrap: true,
            children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text(
                                      textAlign: TextAlign.center,
                                      "Membership",
                                      style: CraftStyles.tsWhiteNeutral50W700
                                          .copyWith(fontSize: 20),
                                    ),
                 ],
               ),
             ),
              SizedBox(height: SizeConfig.blockSizeVertical*1,),
             Column(
                mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                 Text(
                                      textAlign: TextAlign.center,
                                      membershipProvider.isChangePlan?  "Confirm Plan":"Change Plan",
                                      style: CraftStyles.tsWhiteNeutral50W700
                                          .copyWith(fontSize: 20),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Enjoy insider knowledge from top actors and filmmakers with \nimmersive, on-demand courses across acting, production, and \nmore.",
                                      style: CraftStyles.tsWhiteNeutral300W500
                                          .copyWith(fontSize: 12),
                                    ),
                 ],
               ),
             SizedBox(height: SizeConfig.blockSizeVertical*1,),
      //chnage plan
   membershipProvider.isChangePlan?confirmPlan(membershipProvider):   changePlan(membershipProvider),
          SizedBox(height: SizeConfig.blockSizeVertical*2,),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: 
                     ElevatedButton(
                      onPressed: () {
                        if(membershipProvider.isChangePlan)
                        {
                      Navigator.of(
                                                            routeGlobalKey
                                                                .currentContext!,
                                                          ).pushNamed(
                                                            SuccessfulScreen.route,
                                                            
                                                          );
                        }else if(!membershipProvider.isChangePlan)
                        {
                          membershipProvider.confirmationPlan();
                        }
                      
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(SizeConfig.blockSizeVertical * 100,
                            SizeConfig.blockSizeVertical * 5),
                        backgroundColor: CraftColors.primaryBlue550,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                    membershipProvider.isChangePlan?    CraftStrings.strConfirm: CraftStrings.strContinue,
                        style: CraftStyles.tsWhiteNeutral50W60016,
                      ),
                    )
                 
              ),
             
            ],
          ),
        );
                  })
      ),
    );
    
  }
  Widget changePlan(MembershipProvider membershipProvider)
  {
    return   Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Text(
                                      textAlign: TextAlign.start,
                                      "Your current plan",
                                      style: CraftStyles.tsWhiteNeutral300W500
                                          .copyWith(fontSize: 12),
                                    ),
             planPriceCard("Standard","₹ 4299/-",true),
              SizedBox(height: SizeConfig.blockSizeVertical*2,),
               Text(
                                      textAlign: TextAlign.start,
                                      "Select a plan to subscribe",
                                      style: CraftStyles.tsWhiteNeutral300W500
                                          .copyWith(fontSize: 12),
                                    ),
                                     SizedBox(height: SizeConfig.blockSizeVertical*1,),
             PlanPriceCard(
            title: 'Basic Plan',
            price: '₹ 299/-',
            isStandard: false,
            index: 0,
            selectedPlanIndex: membershipProvider.selectedPlanIndex,
            onCheckboxChange: membershipProvider.selectPlan,
          ),
          PlanPriceCard(
            title: 'Premium Plan',
            price: '₹ 499/-',
            isStandard: false,
            index: 1,
            selectedPlanIndex: membershipProvider.selectedPlanIndex,
            onCheckboxChange: membershipProvider.selectPlan,
          ),
        ],);
  }
    Widget confirmPlan(MembershipProvider membershipProvider)
  {
    return   Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Text(
                                      textAlign: TextAlign.start,
                                      "Current Plan",
                                      style: CraftStyles.tsWhiteNeutral300W500
                                          .copyWith(fontSize: 12),
                                    ),
             planPriceCard("Standard","₹ 4299/-",false),
              SizedBox(height: SizeConfig.blockSizeVertical*2,),
               Text(
                                      textAlign: TextAlign.start,
                                      "New Plan",
                                      style: CraftStyles.tsWhiteNeutral300W500
                                          .copyWith(fontSize: 12),
                                    ),
                                     planPriceCard("Basic","₹ 799/-",false),
                                     SizedBox(height: SizeConfig.blockSizeVertical*1,),
                                     Text(
                                      textAlign: TextAlign.start,
                                      "Your new plan will start immediately, and your previous plan will be canceled. The payment for the updated plan will be processed instantly. To manage your subscription or cancel, visit craftschool.com/cancelplan.",
                                      style: CraftStyles.tsWhiteNeutral300W500
                                          .copyWith(fontSize: 12),
                                    ),
            
        ],);
  }
    Widget planPriceCard(String title,String price,bool isStandard) {
    return Container(
      margin: EdgeInsets.all(6),
      width: SizeConfig.blockSizeHorizontal * 95,
      height: SizeConfig.safeBlockVertical*8,
      decoration: BoxDecoration(
       gradient:isStandard?  LinearGradient(
            begin: Alignment.topLeft, // Starting point of the gradient
            end: Alignment.bottomRight, // Ending point of the gradient
            colors:[
              CraftColors.secondary550,
             CraftColors.primaryBlue500
            ] ):LinearGradient(colors:[ CraftColors.neutralBlue800,
             CraftColors.neutralBlue800] ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              title,
              style: CraftStyles.tswhiteW600.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            // Subtitle
            Text(
              textAlign: TextAlign.center,
              price,
              style:
                  CraftStyles.tswhiteW600.copyWith(fontWeight: FontWeight.w500,fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
