import 'package:craft_school/dto/BlogDetailResponse.dart' as blogDetail;
import 'package:craft_school/dto/BlogResponse.dart' as blog;

import 'package:craft_school/main.dart';
import 'package:craft_school/utils/APIManager.dart';
import 'package:craft_school/utils/ShowDialog.dart';

import 'package:craft_school/utils/internetConnection.dart';
import 'package:flutter/material.dart';

class BlogProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Pagination variables
  int _start = 0;
  final int _length = 3; // Number of blogs per fetch
 int totalLength=0;
  List<blog.Datum> _blogList = [];

  // Getter for data
  List<blog.Datum> get blogList => _blogList;
  set blogList(List<blog.Datum> data) {
    _blogList = data;
    notifyListeners();
  }

  // Method to create request body
  createRequestBody(String categoryId,String sortBy) {
    return {
      "start": _start,
      "length": _length,
      "category": categoryId,
      "sort": sortBy
    };
  }

  // API call to get blogs
  Future<void> getBlogsAPI(String categoryId,String sortBy,bool isviewmore) async {
    isLoading = true;
print("getBlogsAPI");
if(!isviewmore)
{
  _start=0;
  _blogList=[];
}
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createRequestBody(categoryId,sortBy);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.blogs,
        (response) async {
          blog.BlogResponse resp = response;
          print("object");
print(_blogList.length.toString());
          if (resp.status == true) {
            // Append the new blogs to the list
            _blogList.addAll(resp.data);
    
            totalLength=resp.total;
            _start += _length; // Update the start for next fetch
             isLoading = false;
                 print("object");
print(_blogList.length.toString());
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error: $error');
          ShowDialogs.showToast("Server Not Responding");
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

 createDetailRequestBody(String slug) {
    return {
      "slug":  slug,
     
    };
  }
  List<blogDetail.Datum> _blogDetailList = [];

  // Getter for data
  List<blogDetail.Datum> get blogDetailList => _blogDetailList;
  set blogDetailList(List<blogDetail.Datum> data) {
    _blogDetailList = data;
    notifyListeners();
  }

    List<blogDetail.Datum> _relatedBlog=[];
    List<blogDetail.Datum> get relatedBlog => _relatedBlog;
  set relatedBlog(List<blogDetail.Datum> data) {
    _relatedBlog = data;
    notifyListeners();
  }

   List<blogDetail.Datum> _latestBlog=[];
    List<blogDetail.Datum> get latestBlog => _latestBlog;
  set latestBlog(List<blogDetail.Datum> data) {
    _latestBlog = data;
    notifyListeners();
  }
   Future<void> getBlogsDetailAPI(String slug) async {
    isLoading = true;
print("getBlogsDetailAPI");
    var status1 = await ConnectionDetector.checkInternetConnection();

    if (status1) {
      dynamic jsonbody = createDetailRequestBody(slug);

      return APIManager().apiRequest(
        routeGlobalKey.currentContext!,
        API.getParticularBlogDetails,
        (response) async {
          blogDetail.BlogDetailResponse resp = response;

          if (resp.status == true) {
            // Append the new blogs to the list
            blogDetailList=resp.data;
            relatedBlog=resp.relatedBlogs;
            latestBlog=resp.latestBlogs;
             isLoading = false;
            notifyListeners();
          }
        },
        (error) {
          // Handle error case
          print('Error clog detail: $error');
          ShowDialogs.showToast("Server Not Responding");
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
}
