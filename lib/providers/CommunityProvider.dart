import 'dart:convert';
import 'dart:io';

import 'package:craft_school/dto/CommentListResponse.dart' as comment;
import 'package:craft_school/dto/GetAllCommunityResponse.dart';
import 'package:craft_school/dto/SavedCourseResponse.dart';
import 'package:craft_school/dto/SavedPostListResponse.dart' as savedPost;
import 'package:craft_school/dto/UpcomingCourseResponse.dart' as upcoming;
import 'package:craft_school/main.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/ShowDialog.dart';
import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class CommunityProvider with ChangeNotifier {
  TextEditingController reportController = TextEditingController();
  TextEditingController commentController= TextEditingController();
bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

   List<Datum> _communityList = [];

  // Getter for data
  List<Datum> get communityList => _communityList;
  set communityList(List<Datum> data) {
    _communityList = data;
    notifyListeners();
  }

   int _start = 0;
  final int _length = 10; // Number of blogs per fetch
 int totalLength=0;
  

  // Method to create request body
  createRequestBody() {
    return {
      "start": _start,
      "length": _length,
      
    };
  }


  bool _isgetCommunityLoading = false;
  bool get isgetCommunityLoading => _isgetCommunityLoading;

  set isgetCommunityLoading(bool value) {
    _isgetCommunityLoading = value;
    notifyListeners();
  }
Future<void> getCommunityAPI(bool firstclick) async {
if(firstclick)
{
  _start=0;
  _communityList=[];
}
    isgetCommunityLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody =createRequestBody();

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.get_all_community_post,
        (response) async {
          GetAllCommunityResponse resp = response;
        print("#community");
          if (resp.status == true) {
            isgetCommunityLoading=false;
            // Append the new blogs to the list
            _communityList.addAll(resp.data);
               totalLength=resp.total;
               
            _start += _length; // Update the start for next fetch
          
            notifyListeners();
            print("_communityListapi");
           print(_communityList.length);
          }
        },
        (error) {
          // Handle error case
          print("#community error");
          isgetCommunityLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isgetCommunityLoading = false;
      return Future.error("No Internet Connection");
    }
  }

bool _ispostLoading = false;
  bool get ispostLoading => _ispostLoading;

  set ispostLoading(bool value) {
    _ispostLoading = value;
    notifyListeners();
  }

Future<void> uploadPost(String postText, List<File> files) async {
  ispostLoading=true;
  var uri = Uri.parse(APIManager.addCommunityPost);
  
  // Creating a multipart request
  var request = http.MultipartRequest('POST', uri);

  // Add the post text as form data
  request.fields['post'] = postText;

  // Add the files to the request
  for (var file in files) {
    var mimeType = lookupMimeType(file.path); // Get mime type based on file extension
    var multipartFile = await http.MultipartFile.fromPath(
      'media', 
      file.path, 
      contentType: mimeType != null ? MediaType.parse(mimeType) : MediaType('application', 'octet-stream')
    );
    request.files.add(multipartFile);
  }

  // Add authorization header
  request.headers['Authorization'] = 'Bearer ${GlobalLists.authtoken}';

  // Sending the request
  var response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    // Success
    print('Post uploaded successfully');
    var responseData = await response.stream.bytesToString();
    print('Response: $responseData');
           Navigator.of(routeGlobalKey.currentContext!)
                        .pushNamed(
                          PostScreen.route,
                        )
                        .then((value) {});
    ispostLoading=false;
  } else {
    // Failure
    print('Error: ${response.statusCode}');
    ispostLoading=false;
  }

}

createSaveCommunityRequestBody(String communityId){
  
    return {
      "community_post_id":communityId
     
 
    };
}
  //save community

   Future<void> savedCommunityAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSaveCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.save_community_post,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
            print(API.save_community_post);
            print(resp.message);
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

   Future<void> unsavedCommunityAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSaveCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.unsave_community_post,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
            print(API.unsave_community_post);
            print(resp.message);
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

  //like 
    Future<void> likeCommunityAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSaveCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.like_community_post,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
            print(API.like_community_post);
            print(resp.message);
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
   //Unlike 
    Future<void> dislikeCommunityAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSaveCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.dislike_community_post,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
            print(API.like_community_post);
            print(resp.message);
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

createReportCommunityRequestBody(String communityId,String reportText){
  
    return {
      "community_post_id":communityId,
     "reason":reportText
 
    };
}

addCommentCommunityRequestBody(String communityId,String commentText){
  
    return {
      "community_post_id":communityId,
     "comment":commentText
 
    };
}
  //delete post
   Future<void> deleteCommunityAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSaveCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.delete_community_post,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
        
             communityList.removeWhere((post) => post.id.toString() == communityID);
             notifyListeners();
             Navigator.pop(routeGlobalKey.currentContext!);
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

   //report post
   Future<void> reportCommunityAPI(String communityID,String reportText) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createReportCommunityRequestBody(communityID,reportText);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.report_community_post,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
        
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
 List<comment.Comment> _commentList = [];

  // Getter for data
  List<comment.Comment> get commentList => _commentList;
  set commentList(List<comment.Comment> data) {
    _commentList = data;
    notifyListeners();
  }
  //getParticular comment

   Future<void> commentsCommunityAPI(String communityID) async {
    _commentList=[];
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createSaveCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.get_community_post_details,
        (response) async {
          comment.CommentListResponse  resp = response;

          if (resp.status == true) {
           _commentList=resp.comments!;
           notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

  //add comment

   Future<void> addCommentCommunityAPI(String communityID,String commentText) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = addCommentCommunityRequestBody(communityID,commentText);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.community_post_comment,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
           
            commentController.text="";
           commentsCommunityAPI(communityID);

           
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

commentCommunityRequestBody(String communityId){
  
    return {
      "comment_id":communityId
     
 
    };
}

   //like comment
    Future<void> likeCommentCommunityAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = commentCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.likeCommunityPostComment,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
          
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

   //unlike comment
    Future<void> unlikeCommentCommunityAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = commentCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.unlikeCommunityPostComment,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
          
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
deleteCommentCommunityRequestBody(String communityId){
  
    return {
      "community_post_comment_id":communityId
     
 
    };
}

   //delete comment post
   Future<void> deleteCommentCommunityAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = deleteCommentCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.delete_community_post_comment,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
        
             commentList.removeWhere((post) => post.postId.toString() == communityID);
             notifyListeners();
             ShowDialogs.showToast(resp.message);
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
//saved post
 List<savedPost.Datum> _savedPostList = [];

  // Getter for data
  List<savedPost.Datum> get savedPostList => _savedPostList;
  set savedPostList(List<savedPost.Datum> data) {
    _savedPostList = data;
    notifyListeners();
  }
Future<void> getsavedCommunityAPI() async {
print("getsavedCommunityAPI");
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody ="";

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.get_all_saved_community_post,
        (response) async {
          savedPost.SavedPostListResponse resp = response;

          if (resp.status == true) {
            // Append the new blogs to the list
            _savedPostList.addAll(resp.data);
                print("object");
                print(_savedPostList.length);
          
            notifyListeners();
      
          }
        },
        (error) {
          // Handle error case
            print('Error getsavedCommunityAPI: $error');
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }

//update post

Future<void> editPost(String postText, List<File> files,String postId) async {
  ispostLoading=true;
  var uri = Uri.parse(APIManager.editCommunityPost);
  
  // Creating a multipart request
  var request = http.MultipartRequest('POST', uri);

  // Add the post text as form data
  request.fields['post'] = postText;
    request.fields['post_id'] = postId;

  // Add the files to the request
  for (var file in files) {
    var mimeType = lookupMimeType(file.path); // Get mime type based on file extension
    var multipartFile = await http.MultipartFile.fromPath(
      'media', 
      file.path, 
      contentType: mimeType != null ? MediaType.parse(mimeType) : MediaType('application', 'octet-stream')
    );
    request.files.add(multipartFile);
  }

  // Add authorization header
  request.headers['Authorization'] = 'Bearer ${GlobalLists.authtoken}';

  // Sending the request
  var response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    // Success
    print('Post uploaded successfully');
    var responseData = await response.stream.bytesToString();
    print('Response: $responseData');
           Navigator.of(routeGlobalKey.currentContext!)
                        .pushNamed(
                          PostScreen.route,
                        )
                        .then((value) {});
    ispostLoading=false;
  } else {
    // Failure
    print('Error: ${response.statusCode}');
    ispostLoading=false;
  }

}



   //delete Media from post



   deleteMediaCommunityRequestBody(String communityId){
  
    return {
      "community_post_media_id":communityId
     
 
    };
}

   Future<void> deleteMediaFromCommunityPosttAPI(String communityID) async {
   
    isLoading = true;

    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = deleteMediaCommunityRequestBody(communityID);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.deleteCommunityPostMedia,
        (response) async {
          SavedCoursesResponse  resp = response;

          if (resp.status == true) {
        
            
             notifyListeners();
           
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          // ShowDialogs.showToast("Server Not Responding");
          isLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isLoading = false;
      return Future.error("No Internet Connection");
    }
  }
 List<upcoming.Datum> _upcomingCourseList = [];

  // Getter for data
  List<upcoming.Datum> get upcomingCourseList => _upcomingCourseList;
  set upcomingCourseList(List<upcoming.Datum> data) {
    _upcomingCourseList = data;
    notifyListeners();
  }
 bool _isgetUpcomgLoading = false;
  bool get isgetUpcomgLoading => _isgetUpcomgLoading;

  set isgetUpcomgLoading(bool value) {
    _isgetUpcomgLoading = value;
    notifyListeners();
  }
   createUpcomingRequestBody() {
    return {
      "start": 0,
      "length": 0,
      
    };
  }
Future<void> getUpcomingCoursesAPI() async {

    isgetUpcomgLoading = true;
    upcomingCourseList=[];
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody =createUpcomingRequestBody();

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getUpcomingCourses,
        (response) async {
          upcoming.UpcomingCoursesResponse resp = response;
        print("#community");
          if (resp.status == true) {
            isgetUpcomgLoading=false;
            // Append the new blogs to the list
            _upcomingCourseList.addAll(resp.data);
        
            notifyListeners();
            print("_communityListapi");
           print(_communityList.length);
          }
        },
        (error) {
          // Handle error case
          print("#community error");
          isgetUpcomgLoading = false;
        },
        jsonval: jsonbody,
      );
    } else {
      // No internet connection
      ShowDialogs.showToast("Please check internet connection");
      isgetCommunityLoading = false;
      return Future.error("No Internet Connection");
    }
  }
}
