import 'dart:io';

import 'package:craft_school/common_widget/custom_text_field_widget.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/extentions.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:craft_school/providers/sign_up_provider.dart';

class Career extends StatelessWidget {
  static const String route = "/Career";
  Career({super.key});
  final BorderRadius borderRadius = const BorderRadius.all(
    Radius.circular(8),
  );
  final BorderSide focusedBorder = const BorderSide(
    width: 1.0,
  );
  final BorderSide enableBorder = BorderSide(
    width: 1.0,
  );
   List<String> selectedFiles =[];
  Widget buildMostInterestedCard({
    required String title,
    required String subtitle,
    required Color color,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: Platform.isAndroid
            ? SizeConfig.blockSizeVertical * 78
            : SizeConfig.blockSizeVertical * 71,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
          child: Column(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: Platform.isAndroid
                    ? SizeConfig.blockSizeVertical * 72
                    : SizeConfig.blockSizeVertical * 70,
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                    Consumer<SignUpProvider>(
                      builder: (context, signUpProvider, _) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Form(
                            key: signUpProvider
                                .formKey, // Wrap all fields inside the Form widget
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // First Name Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strFirstName,
                                  hintText: CraftStrings.strEnterFirstName,
                                  onChange: (val) {},
                                  textEditingController:
                                      signUpProvider.firstNameController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signUpProvider.validateFirstName,
                                ),
                                // Last Name Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strLastName,
                                  hintText: CraftStrings.strEnterLastName,
                                  onChange: (val) {},
                                  textEditingController:
                                      signUpProvider.lastNameController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signUpProvider.validateLastName,
                                ),
                                // Email Field with Validation
                                CustomTextFieldWidget(
                                  title: CraftStrings.strEmail,
                                  hintText: CraftStrings.strEnterEmail,
                                  onChange: (val) {},
                                  textEditingController:
                                      signUpProvider.emailController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signUpProvider.validateEmailField,
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
                                      signUpProvider.phoneNumberController,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  validator: signUpProvider.validatePhoneNumber,
                                ),
                                Text(
            "Position",
            style: CraftStyles.tsWhiteNeutral100W50014,
          ),
          8.0.heightBox,

Theme(
   data: ThemeData(
    hintColor: CraftColors.neutral300, // Sets hint text color globally inside this widget
  ),
  child: DropdownButtonFormField<String>(
    
     validator: signUpProvider.validateCareerField, 
    style: CraftStyles.tsWhiteNeutral100W500, // Ensures selected text is white
    dropdownColor: CraftColors.neutralBlue850, // Matches background
  
    decoration: InputDecoration(
       errorStyle: CraftStyles.tsWhiteNeutral300W50012,
      hintText: "Select Career Field", 
      hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500), // Explicitly setting white color
      floatingLabelBehavior: FloatingLabelBehavior.never, // Prevents label from floating
      isDense: true, // Keeps text field compact
      border: OutlineInputBorder(
          borderRadius: borderRadius, borderSide: enableBorder),
      focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius, borderSide: focusedBorder),
      enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius, borderSide: enableBorder),
      disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius, borderSide: enableBorder),
      errorBorder: OutlineInputBorder(
          borderRadius: borderRadius, borderSide: enableBorder),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius, borderSide: focusedBorder),
      filled: true,
      fillColor: CraftColors.neutralBlue850,
    ),
  
    value: signUpProvider.selectedCareerField,
    items: signUpProvider.careerFields.map((field) {
      return DropdownMenuItem(
        value: field, 
        child: Text(field, style: CraftStyles.tsWhiteNeutral100W500), // Ensures items are white
      );
    }).toList(),
  
    onChanged: (value) {
      signUpProvider.setSelectedCareerField(value!);
    },
  ),
),



16.0.heightBox,
FormField<List<String>>(
  
  validator: (value) => signUpProvider.validateResume(signUpProvider.resumeFile),
  builder: (formState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              allowMultiple: true, 
            );
            if (result != null) {
              signUpProvider.setResumeFile(result.files.map((file) => file.path!).toList());
              formState.didChange(signUpProvider.resumeFile); // Trigger validation update
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Upload Resume", style: CraftStyles.tsWhiteNeutral100W50014),
              Icon(Icons.upload, color: CraftColors.neutral100),
            ],
          ),
        ),
        if (signUpProvider.resumeFile!.isNotEmpty)
          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: signUpProvider.resumeFile!.map((filePath) {
              return Chip(
                label: Text(filePath.split('/').last, style: CraftStyles.tsWhiteNeutral100W50014.copyWith(fontSize: 10)),
                backgroundColor: CraftColors.neutralBlue800,
                deleteIcon: Icon(Icons.close, color: Colors.white),
                onDeleted: () {
                  signUpProvider.resumeFile!.remove(filePath);
                  signUpProvider.notifyListeners();
                  formState.didChange(signUpProvider.resumeFile); // Trigger validation update
                },
              );
            }).toList(),
          ),
        if (formState.hasError) // Show error message
          Padding(
            padding: EdgeInsets.only(top: 4,left: 10),
            child: Text(
              formState.errorText ?? '',
              style:  CraftStyles.tsWhiteNeutral300W50012,
            ),
          ),
      ],
    );
  },
),



                              ],
                            ),
                          ),
                        );
                      },
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ChangeNotifierProvider(
        create: (_) => LandingScreenProvider(),
        child: Consumer<LandingScreenProvider>(builder: (context, provider, _) {
          return Scaffold(
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
               isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
              ),
            ),
            backgroundColor: CraftColors.black18,
            body: Stack(
              children: [
                ChangeNotifierProvider(
                  create: (_) => SignUpProvider(),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      buildMostInterestedCard(
                        title: CraftStrings.strJoinUs,
                        subtitle: "",
                        color: CraftColors.neutralBlue800,
                        titleStyle: CraftStyles.tsWhiteNeutral50W70016,
                        subtitleStyle: CraftStyles.tsWhiteNeutral300W500,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Consumer<SignUpProvider>(
                          builder: (context, signUpProvider, _) {
                            return ElevatedButton(
                              onPressed: () {
                                if (signUpProvider.validateForm()) {
                                  signUpProvider.uploadResume(
                                  
                                  );
                                } else {
                                  // Form is invalid, show error messages
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    SizeConfig.blockSizeVertical * 100,
                                    SizeConfig.blockSizeVertical * 5),
                                backgroundColor: CraftColors.primaryBlue550,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                CraftStrings.strJoinUs,
                                style: CraftStyles.tsWhiteNeutral50W60016,
                              ),
                            );
                          },
                        ),
                      ),
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
        }));
  }
}
