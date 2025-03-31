import 'package:craft_school/utils/craft_images.dart';
import 'package:flutter/material.dart';

class CourseDetailProvider with ChangeNotifier {
bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  void toggleExpansion() {
    _isExpanded = !_isExpanded;
    notifyListeners(); // Notify all listeners (widgets) that the state has changed
  }
 List<String> _imagePaths = [
    CraftImagePath.image1,
    CraftImagePath.image2,
    CraftImagePath.image3,
    CraftImagePath.image1,
  ];

  // Getter to access the image data
  List<String> get imagePaths => _imagePaths;

  // Method to update the image data
  void updateImages(List<String> newImages) {
    _imagePaths = newImages;
    notifyListeners();
  }
    final List<Map<String, String>> chipPlanData = [
    {'label': 'Individual', 'image': ''},
    {'label': 'Subscription', 'image': ''},
  
  ];
      String? selectedChip="Individual";
        void onSingleChipSelected(String? label) {
   
      selectedChip = label; // Update the selected chip
      // if(label=="Google")
      // {
      //   signInWithGoogle();
      // }
    notifyListeners();
  }
 
   final List<Map<String, String>> learnNewList = [
    {
    
      'title': 'Free Webinars & Live Classes:',
      'subtext': 'Odio quod labore rerum aliquam voluptate sed est debitis.',
  
    },
    {
  
      'title': 'All Courses Access:',
      'subtext': ' Enjoy full access to our entire library of filmmaking courses.',

    },
   
    // Add more static items as needed
  ];
List<Map<String, dynamic>> blogsItem = [
    {
      'image': CraftImagePath.image5,
      'title': 'Live Webinars',
      'subtext': 'Stay on track by attending live, interactive acting sessions with industry professionals. 100% practical.',
      'icon': CraftImagePath.live,
      'isExpanded': false , // New field to track the expanded state
      'isChecked': false,
    },
    {
      'image': CraftImagePath.image6,
      'title': 'Community-Based Learning',
      'subtext': 'Collaborate with a global community of filmmakers, actors, and storytellers sharing your passion.',
      'icon': CraftImagePath.community,
      'isExpanded': false, // New field to track the expanded state
      'isChecked': false,
    },
    {
      'image': CraftImagePath.image7,
      'title': 'Certification',
      'subtext': 'Graduate with an official Film making Certification, recognized by top studios and production houses.',
      'icon': CraftImagePath.certificate,
      'isExpanded': false, // New field to track the expanded state
      'isChecked': false,
    },
    // Add more static items as needed
  ];



  void toggleCheckbox(int index, bool value) {
    blogsItem[index]['isChecked'] = value;
    notifyListeners(); // Notify listeners to update UI
  }

  bool isBuyNowExpanded = false;

  // Function to toggle the expanded/collapsed state
  void toggleBuyNowExpansion() {
    isBuyNowExpanded = !isBuyNowExpanded;
    notifyListeners();  // Notify listeners to rebuild the widget
  }


  //Other courses

   bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

}


