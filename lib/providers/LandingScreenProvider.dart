import 'package:craft_school/dto/CustomerCategoryListResponse.dart';
import 'package:craft_school/dto/CustomerIdCategoryWiseResponse.dart' as catWise;
import 'package:craft_school/dto/LandingScreenResponse.dart' as landingResp;
import 'package:craft_school/dto/LogoutResponse.dart';
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/SPManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';

class LandingScreenProvider with ChangeNotifier {
  // List to hold the image data (image paths or URLs)
  List<String> _imagePaths = [
    CraftImagePath.image1,
    CraftImagePath.image2,
    CraftImagePath.image3,
    CraftImagePath.image4,
    CraftImagePath.image5,
    CraftImagePath.image6,
    CraftImagePath.image7,
    CraftImagePath.image8,
    CraftImagePath.image9
  ];

  // Getter to access the image data
  List<String> get imagePaths => _imagePaths;

  // Method to update the image data
  void updateImages(List<String> newImages) {
    _imagePaths = newImages;
    notifyListeners();
  }

  List<Map<String, String>> trendingMasters = [
    {
      'name': 'Salim Khan',
      'subtitle': 'An influential storyteller and screenplay writer, transformed Indian cinema with iconic films like Zanjeer and Deewar, bringing authenticity to the "Indian hero" archetype through compelling characters and a focus on human relationships.',
      'image': CraftImagePath.image6,
    },
    {
      'name': 'Aashif Shaikh',
       'subtitle': 'An influential storyteller and screenplay writer, transformed Indian cinema with iconic films like Zanjeer and Deewar, bringing authenticity to the "Indian hero" archetype through compelling characters and a focus on human relationships.',
      'image': CraftImagePath.image4,
    },
    {
      'name': 'Salim Khan',
       'subtitle': 'An influential storyteller and screenplay writer, transformed Indian cinema with iconic films like Zanjeer and Deewar, bringing authenticity to the "Indian hero" archetype through compelling characters and a focus on human relationships.',
      'image':CraftImagePath.image9,
    },
    {
      'name': 'Aashif Shaikh',
       'subtitle': 'An influential storyteller and screenplay writer, transformed Indian cinema with iconic films like Zanjeer and Deewar, bringing authenticity to the "Indian hero" archetype through compelling characters and a focus on human relationships.',
      'image': CraftImagePath.image3,
    },
    // Add more masters if needed
  ];


  final List<Map<String, String>> aspiringListItems = [
    {
      'image': CraftImagePath.image5,
      'title': 'Live Webinars',
      'subtext':
          'Stay on track by attending live, interactive acting sessions with industry professionals. 100% practical.',
      'icon': CraftImagePath.live,
    },
    {
      'image': CraftImagePath.image6,
      'title': 'Community-Based Learning',
      'subtext':
          'Collaborate with a global community of filmmakers, actors, and storytellers sharing your passion.',
      'icon': CraftImagePath.community,
    },
    {
      'image': CraftImagePath.image7,
      'title': 'Certification',
      'subtext':
          'Graduate with an official Film making Certification, recognized by top studios and production houses.',
      'icon': CraftImagePath.certificate,
    },
    {
      'image': CraftImagePath.image8,
      'title': 'Taught by Industry Experts',
      'subtext':
          'Learn directly from top actors, directors, and producers who work on major films and TV shows.',
      'icon': CraftImagePath.industry,
    },
    // Add more static items as needed
  ];
  List<Map<String, dynamic>> blogsItem = [
    {
      'image': CraftImagePath.image5,
      'title': 'Live Webinars',
      'subtext':
          'Stay on track by attending live, interactive acting sessions with industry professionals. 100% practical.',
      'icon': CraftImagePath.live,
      'isExpanded': false, // New field to track the expanded state
    },
    {
      'image': CraftImagePath.image6,
      'title': 'Community-Based Learning',
      'subtext':
          'Collaborate with a global community of filmmakers, actors, and storytellers sharing your passion.',
      'icon': CraftImagePath.community,
      'isExpanded': false, // New field to track the expanded state
    },
    {
      'image': CraftImagePath.image7,
      'title': 'Certification',
      'subtext':
          'Graduate with an official Film making Certification, recognized by top studios and production houses.',
      'icon': CraftImagePath.certificate,
      'isExpanded': false, // New field to track the expanded state
    },
    // Add more static items as needed
  ];
  final List<Map<String, String>> gridItems = [
    {
      'rating': "4",
      'title': 'Lynn Harris',
      'description':
          'This is a longer description that will expand depending on how much space it needs.This is a longer description that will expand depending on how much space it needs.This is a longer description that will expand depending on how much space it needs.',
    },
    {
      'rating': "3",
      'title': 'Lynn Harris',
      'description': 'This is a short description.',
    },
    {
      'rating': "3",
      'title': 'Lynn Harris',
      'description':
          'This is a longer description that will expand depending on how much space it needs.This is a longer description that will expand depending on how much space it needs.This is a longer description that will expand depending on how much space it needs.',
    },
    {
      'rating': "3",
      'title': 'Lynn Harris',
      'description': 'A medium description.',
    },

    // Add more items as needed
  ];
  double calculateTextHeight(String text) {
    // Calculate text height based on the length of the description
    int length = text.length;
    if (length <= 50) {
      return 60.0; // Short text
    } else if (length <= 100) {
      return 80.0; // Medium length text
    } else {
      return 100.0; // Long text
    }
  }

  // Getter to access the blogsItem list
  List<Map<String, dynamic>> get blogs => blogsItem;

// Toggle the expansion state of a specific blog item
  void toggleExpansion(int index) {
    // Collapse all items before expanding the clicked one
    for (int i = 0; i < blogsItem.length; i++) {
      if (i != index) {
        blogsItem[i]['isExpanded'] = false;
      }
    }

    // Toggle the clicked item's expansion state
    blogsItem[index]['isExpanded'] = !blogsItem[index]['isExpanded'];
    notifyListeners();
  }

  final List<Map<String, String>> flimJourneyList = [
    {
      'image': CraftImagePath.image5,
      'title': 'Flexible Payment',
      'subtext':
          'Choose from three plans with the option to pay monthly or annually.',
      'icon': CraftImagePath.payment,
    },
    {
      'image': CraftImagePath.image6,
      'title': 'Unlimited Course',
      'subtext':
          ' Explore all CraftSchool courses at your fingertips with any plan.',
      'icon': CraftImagePath.course,
    },
    {
      'image': CraftImagePath.image7,
      'title': 'Exclusive Community',
      'subtext':
          'Join our community of passionate filmmakers and industry professionals.',
      'icon': CraftImagePath.exclusiveCommunity,
    },
    {
      'image': CraftImagePath.webinars,
      'title': 'Yearly Live Webinars',
      'subtext':
          'Enjoy at least 8 live webinars every year with industry experts.',
      'icon': CraftImagePath.webinars,
    },
    // Add more static items as needed
  ];

  final List<Map<String, String>> storyTellingListItems = [
    {
      'image': CraftImagePath.image5,
      'title': 'Introduction to Auto Layout',
      'subtext':
          'To start her course, Helen demonstrates a simple act that’s one of the hardest thing...',
      'icon': "",
    },
    {
      'image': CraftImagePath.image6,
      'title': 'Horizontal, vertical, and wrap layout',
      'subtext':
          'To start her course, Helen demonstrates a simple act that’s one of the hardest things...',
      'icon': CraftImagePath.lock,
    },
    {
      'image': CraftImagePath.image7,
      'title': 'Padding and Gap Between',
      'subtext':
          'To start her course, Helen demonstrates a simple act that’s one of the hardest things...',
      'icon': CraftImagePath.lock,
    },
    {
      'image': CraftImagePath.image8,
      'title': 'Auto layout Alignment  ',
      'subtext':
          'To start her course, Helen demonstrates a simple act that’s one of the hardest things...',
      'icon': CraftImagePath.lock,
    },
    // Add more static items as needed
  ];
  final List<Map<String, String>> joinCommunityList = [
    {
      'title': 'Free Webinars & Live Classes:',
      'subtext':
          'Join sessions with renowned industry experts, available exclusively to our members.',
    },
    {
      'title': 'All Courses Access:',
      'subtext':
          ' Enjoy full access to our entire library of filmmaking courses.',
    },

    // Add more static items as needed
  ];
  final List<Map<String, String>> joinGuildlineList = [
    {
      'title': 'Category-Based Entries:',
      'subtext':
          'J Choose your preferred category—Acting, Directing, Cinematography, and more—to showcase your talent.',
    },
    {
      'title': 'Celebrity Judging Panel:',
      'subtext':
          'Gain feedback and recognition from our distinguished panel of actors, directors, and industry experts.',
    },
    {
      'title': 'Celebrity Judging Panel:',
      'subtext':
          'Gain feedback and recognition from our distinguished panel of actors, directors, and industry experts.',
    },
    {
      'title': 'Celebrity Judging Panel:',
      'subtext':
          'Gain feedback and recognition from our distinguished panel of actors, directors, and industry experts.',
    },
    {
      'title': 'Celebrity Judging Panel:',
      'subtext':
          'Gain feedback and recognition from our distinguished panel of actors, directors, and industry experts.',
    },

    // Add more static items as needed
  ];
  int selectedChipIndex = 0; // -1 means no chip selected

  // final List<Map<String, String>> chipItems = [
  //   {'label': 'Model Casting', 'image': CraftImagePath.modelCasting},
  //   {'label': 'Acting', 'image': CraftImagePath.acting},
  //   {'label': 'Editing', 'image': CraftImagePath.editing},
  //   {'label': 'Executive Production', 'image': CraftImagePath.executiveprod},
   
  // ];

  List<List<CourseStatic>> filteredCourses = [
    // Example courses for each category
    [
      CourseStatic(
          title: 'Course 1',
          author: 'Aashif Shaikh',
          imagePath: CraftImagePath.image1,
          tagVisible: true),
      CourseStatic(
          title: 'Course 3',
          author: 'Jane Smith',
          imagePath: CraftImagePath.image3,
          tagVisible: false),
      CourseStatic(
          title: 'Course 2',
          author: 'John Doe',
          imagePath: CraftImagePath.image2,
          tagVisible: false)
    ],
    [
      CourseStatic(
          title: 'Course 2',
          author: 'John Doe',
          imagePath: CraftImagePath.image2,
          tagVisible: true),
      CourseStatic(
          title: 'Course 4',
          author: 'Sam Wilson',
          imagePath: CraftImagePath.image4,
          tagVisible: false),
      CourseStatic(
          title: 'Course 2',
          author: 'John Doe',
          imagePath: CraftImagePath.image3,
          tagVisible: false)
    ],
    [
      CourseStatic(
          title: 'Course 3',
          author: 'Jane Smith',
          imagePath: CraftImagePath.image3,
          tagVisible: false),
      CourseStatic(
          title: 'Course 3',
          author: 'Jane Smith',
          imagePath: CraftImagePath.image3,
          tagVisible: false)
    ],
    [
      CourseStatic(
          title: 'Course 4',
          author: 'Sam Wilson',
          imagePath: CraftImagePath.image4,
          tagVisible: true),
      CourseStatic(
          title: 'Course 2',
          author: 'John Doe',
          imagePath: CraftImagePath.image2,
          tagVisible: false)
    ],
  ];

  void selectChip(int index) {
    selectedChipIndex = index;
    notifyListeners();
  }

  bool _isContainerVisible = false;

  bool get isContainerVisible => _isContainerVisible;

  // Method to toggle the visibility of the sliding container
  void toggleSlidingContainer() {
    _isContainerVisible = !_isContainerVisible;
    notifyListeners(); // Notify listeners that the state has changed
  }
    bool _isCategoryVisible = false;

  bool get isCategoryVisible => _isCategoryVisible;

  // Method to toggle the visibility of the sliding container
  void toggleSlidingCategory() {
    _isCategoryVisible = !_isCategoryVisible;
    notifyListeners(); // Notify listeners that the state has changed
  }


  List<landingResp.Banner> _banner1 = [];
  List<landingResp.Banner> _banner2 = [];
  List<landingResp.Banner> _banner3 = [];

  // Getter for banner1
  List<landingResp.Banner> get banner1 => _banner1;

  // Setter for banner1
  set banner1(List<landingResp.Banner> value) {
    _banner1 = value;
    notifyListeners();  // Notify listeners when the value changes
  }

  // Getter for banner2
  List<landingResp.Banner> get banner2 => _banner2;

  // Setter for banner2
  set banner2(List<landingResp.Banner> value) {
    _banner2 = value;
    notifyListeners();  // Notify listeners when the value changes
  }

  // Getter for banner3
  List<landingResp.Banner> get banner3 => _banner3;

  // Setter for banner3
  set banner3(List<landingResp.Banner> value) {
    _banner3 = value;
    notifyListeners();  // Notify listeners when the value changes
  }


Future<Map<String, dynamic>> createRequestBody() async {
    return {
      "token": await SPManager().getAuthToken(),
      
    };
  }
  logoutAPI() async {
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = await createRequestBody();
     

      APIManager().apiRequest(routeGlobalKey.currentContext!, API.logout,
          (response) async {
        LogoutResponse resp = response;
        // if (response['status'] == true) {
         if (resp.status == "success") {
          print("success");
          ShowDialogs.showToast(resp.message);
          SPManager().setAuthToken("");
          Navigator.of(
            routeGlobalKey.currentContext!,
          ).pushNamed(
            SignInScreen.route,
          );
         }
        // } else {
        //   // Handle failu
        //   print("response status fail");
        //   print(response['errors']);

        // }
      }, (error) {
     
        ShowDialogs.showToast("Server Not Responding");
      }, jsonval: jsonbody);
    } else {
      /// Navigator.of(_keyLoader.currentContext).pop();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
   bool _isLoading = false;
     
  List<landingResp.CoursesDatum> _courses = [];
  List<landingResp.MastersDatum> _masters = [];
  List<landingResp.CarousalImagesDatum> _carousalImages = [];

  // Getter for courses
  List<landingResp.CoursesDatum> get courses => _courses;

  // Setter for courses
  set courses(List<landingResp.CoursesDatum> value) {
    _courses = value;
    notifyListeners();  // Notify listeners when the value changes
  }

  // Getter for masters
  List<landingResp.MastersDatum> get masters => _masters;

  // Setter for masters
  set masters(List<landingResp.MastersDatum> value) {
    _masters = value;
    notifyListeners();  // Notify listeners when the value changes
  }

  // Getter and setter for carousal images
  List<landingResp.CarousalImagesDatum> get carousalImages => _carousalImages;

  set carousalImages(List<landingResp.CarousalImagesDatum> value) {
    _carousalImages = value;
    notifyListeners();
  }

  // Loading state
  bool get isLoading => _isLoading;

  // Set loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  bool _isCategoryLoading = false;
  // Loading state
  bool get isCategoryLoading => _isCategoryLoading;

  // Set loading state
  set isCategoryLoading(bool value) {
    _isCategoryLoading = value;
    notifyListeners();
  }
  // API call for home screen data
  Future<void> homeScreenAPI() async {
    // Set loading to true when the API request starts
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = "";
     
      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.homeScreen,
        (response) async {
          landingResp.LandingScreenResponse resp = response;

          if (resp.status == true) {
            // Updating the lists with fetched data
            masters = resp.data.masters.data;
            courses = resp.data.courses.data;
            carousalImages = resp.data.carousalImages.data;
            banner1=resp.data.banners.data.banner1;
            banner2=resp.data.banners.data.banner2;
            banner3=resp.data.banners.data.banner3;

            // Once data is fetched, set isLoading to false
            isLoading = false;
          }
        },
        (error) {
          // Handle error case
         
          ShowDialogs.showToast("Server Not Responding");

          // Set loading to false in case of an error
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");

      // Set loading to false when no internet
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
List<Datum> _categoryList = [];

  // Getter for data
  List<Datum> get categoryList => _categoryList;
  set categoryList(List<Datum> data) {
    _categoryList = data;
  }
   Future<void> getCustomerCategoryList() async {
    _isCategoryLoading = true;
    notifyListeners();

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      var jsonbody = "";
      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.customerSignupCategoriesList,
        (response) {
          CustomerCategoryListResponse resp = response;
          categoryList = resp.data;
         
          _isCategoryLoading = false;

          notifyListeners();
        },
        (error) {
          _isCategoryLoading = false;
         
          notifyListeners();
          ShowDialogs.showToast("Server Not Responding");
        },
        path: jsonbody,
      );
    } else {
      _isCategoryLoading = false;
     
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
 bool _isCategoryWiseLoading = false;
  // Loading state
  bool get isCategoryWiseLoading => _isCategoryWiseLoading;

  // Set loading state
  set isCategoryWiseLoading(bool value) {
    _isCategoryWiseLoading = value;
    notifyListeners();
  }

List<catWise.Datum> _categoryWiseList = [];

  // Getter for data
  List<catWise.Datum> get categoryWiseList => _categoryWiseList;
  set categoryWiseList(List<catWise.Datum> data) {
    _categoryWiseList = data;
  }
  Future<Map<String, dynamic>> createCustomerCategoryRequestBody(String category) async {
    return {
      "category_ids":[category],
    "start":0,
    "length":3
      
    };
  }
   Future<void> getCustomerIdWiseCategoryList(String category) async {
    _isCategoryWiseLoading = true;
    notifyListeners();

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      var jsonbody = createCustomerCategoryRequestBody(category);
      await APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.customercategoryIdsWiseCourses,
        (response) {
          catWise.CustomerIdCategoryWiseResponse resp = response;
          categoryWiseList = resp.data;
        
          _isCategoryWiseLoading = false;
          notifyListeners();
        },
        (error) {
          _isCategoryWiseLoading = false;
         
          notifyListeners();
          ShowDialogs.showToast("Server Not Responding");
        },
        path: jsonbody,
      );
    } else {
      _isCategoryWiseLoading = false;
     
      notifyListeners();
      ShowDialogs.showToast("Please check internet connection");
    }
  }
}

class ChipItem {
  final String title;
  ChipItem({required this.title});
}

class CourseStatic {
  final String title;
  final String author;
  final String imagePath;
  final bool tagVisible;

  CourseStatic({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.tagVisible,
  });
}
