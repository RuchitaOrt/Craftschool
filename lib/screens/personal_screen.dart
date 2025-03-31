import 'dart:io';

import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/personal_account_provider.dart';
import 'package:craft_school/screens/settings.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



class PersonalScreen extends StatefulWidget {
   static const String route = "/personalScreen";
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  File? _profileImage;
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
      final provider = Provider.of<PersonalAccountProvider>(context, listen: false);
      if (!provider.isLoading) {
        provider.getFetchCustomerInfoAPI();

        
       
      }
    });
  }
  final BorderRadius borderRadius = const BorderRadius.all(
    Radius.circular(8),
  );
  final BorderSide focusedBorder = const BorderSide(
    width: 1.0,
  );
  final BorderSide enableBorder = BorderSide(
    width: 1.0,
  );

  Widget buildMostInterestedCard({
    required String title,
    required String subtitle,
    required Color color,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
  }) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
          child: Column(
            children: [
              Consumer<PersonalAccountProvider>(builder: (context, personalAccountProvider, _) {
                return SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 60,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                     
                      Padding(
  padding: const EdgeInsets.only(top: 8),
  child: _buildProfileImage(),
),
  Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Form(
                              key: personalAccountProvider
                                  .formKey, // Wrap all fields inside the Form widget
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   
                                CustomTextFieldWidget(
                                  title: CraftStrings.strFirstName,
                                  hintText: CraftStrings.strEnterFirstName,
                                  onChange: (val) {},
                                  textEditingController:
                                      personalAccountProvider.firstNameController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: personalAccountProvider.validateFirstName,
                                ),
                                // Last Name Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strLastName,
                                  hintText: CraftStrings.strEnterLastName,
                                  onChange: (val) {},
                                  textEditingController:
                                      personalAccountProvider.lastNameController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: personalAccountProvider.validateLastName,
                                ),
                               CustomTextFieldWidget(
                                  title: CraftStrings.strEmail,
                                  hintText: CraftStrings.strEnterEmail,
                                  onChange: (val) {},
                                  textEditingController:
                                      personalAccountProvider.emailController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: personalAccountProvider.validateEmailField,
                                ),
                                // Phone Number Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strPhoneNo,
                                  hintText: CraftStrings.strEnterPhoneNo,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly, 
                                  ],
                                  textInputType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  onChange: (val) {},
                                  textEditingController:
                                      personalAccountProvider.phoneNumberController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: personalAccountProvider.validatePhoneNumber,
                                ),
                                ],
                              ),
                            ),
                          )
                     
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _pickProfileImage() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  if (result != null && result.files.isNotEmpty) {
    setState(() {
      _profileImage = File(result.files.first.path!);
    });
  }
}
Widget _buildProfileImage() {
  
 return Consumer<PersonalAccountProvider>(
    builder: (context, provider, _) {
      print("profileImageUrl");
      print(provider.profileImageUrl);
       ImageProvider? imageProvider;

      if (_profileImage != null) {
         print("profileImageUrl1");
        imageProvider = FileImage(_profileImage!);
      } else if (provider.profileImageUrl.isNotEmpty) {
         print("profileImageUrl2");
        imageProvider = NetworkImage(provider.profileImageUrl);
      }
  return  GestureDetector(
    onTap: _pickProfileImage,
    child: Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade800,
            backgroundImage:
                _profileImage != null ? FileImage(_profileImage!) :provider.profileImageUrl!=""?  NetworkImage(provider.profileImageUrl)
                :AssetImage(CraftImagePath.whiteCamera),
            // child: imageProvider == null
            //     ? Icon(
            //         Icons.person,
            //         size: 50,
            //         color: Colors.white70,
            //       )
            //     : Image.network(provider.profileImageUrl),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
    });
}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return 
    ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return
    Scaffold(
      appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              isContainerVisible: provider.isContainerVisible,
              isCategoryVisible: provider.isCategoryVisible,
              onMenuPressed: () {
                provider.toggleSlidingContainer(); // Trigger toggle when menu is pressed
              },
              onCategoriesPressed: () {
                provider.toggleSlidingCategory();
              },
            ),
            ),
            backgroundColor: CraftColors.black18,
      body: 
      
      Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text(
                                      textAlign: TextAlign.center,
                                      "Personal",
                                      style: CraftStyles.tsWhiteNeutral50W700
                                          .copyWith(fontSize: 20),
                                    ),
                 ],
               ),
             ),
             SizedBox(height: SizeConfig.blockSizeVertical*2,),
              buildMostInterestedCard(
                title: CraftStrings.str03Intro,
                subtitle: CraftStrings.strAccountDetail,
                color: CraftColors.neutralBlue800,
                titleStyle: CraftStyles.tsWhiteNeutral50W70016,
                subtitleStyle: CraftStyles.tsWhiteNeutral300W500,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical*2,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Consumer<PersonalAccountProvider>(
                  builder: (context, personalAccountProvider, _) {
                    return ElevatedButton(
                      onPressed: () {
                        if (personalAccountProvider.validateForm()) {
                          personalAccountProvider.getUpdateCustomerInfoAPI([_profileImage!]);
                      Navigator.of(context)
                        .pushNamed(
                          Settings.route,
                        )
                        .then((value) {});
                         
                        } else {
                          // Form is invalid, show error messages
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
                        CraftStrings.strSave,
                        style: CraftStyles.tsWhiteNeutral50W60016,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              // GestureDetector(
              //   onTap: () {
                 
              //   },
              //   child: Text(
              //     CraftStrings.strCancel, // Dynamic Sign-In text
              //     textAlign: TextAlign.center,
              //     style: CraftStyles.tsWhiteNeutral50W60016,
              //   ),
              // ),
            ],
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
}
