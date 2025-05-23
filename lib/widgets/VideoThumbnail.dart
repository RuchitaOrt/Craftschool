import 'package:craft_school/utils/craft_images.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data' as typed;

class VideoThumbnailCache extends ChangeNotifier {
  // Cache to store generated thumbnails
  Map<String, typed.Uint8List?> videoThumbnails = {};

  // Method to get the thumbnail image for a video URL
  ImageProvider getThumbnailImage(String videoUrl) {
    print("Thumbnail cache status: $videoThumbnails");

    if (videoThumbnails.containsKey(videoUrl)) {
      // ✅ Thumbnail is cached, return it
      return MemoryImage(videoThumbnails[videoUrl]!);
    } else {
      // ❌ Thumbnail not cached, start generating asynchronously
      generateThumbnail(videoUrl);
      // Return a placeholder while generating
      return AssetImage(CraftImagePath.image1);
    }
  }

  // Method to asynchronously generate a thumbnail and notify listeners
  Future<void> generateThumbnail(String videoUrl) async {
    if (videoThumbnails.containsKey(videoUrl)) return; // ✅ Prevent duplicate calls

    try {
      final typed.Uint8List? thumbnailData = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300, // Max width for the thumbnail
        quality: 75, // Thumbnail quality
      );

      if (thumbnailData != null) {
        // ✅ Cache the generated thumbnail
        videoThumbnails[videoUrl] = thumbnailData;
        notifyListeners(); // 🔥 Notify UI to rebuild
      }
    } catch (e) {
      print("Error generating thumbnail: $e");
    }
  }
}


// import 'package:craft_school/utils/craft_images.dart';
// import 'package:flutter/material.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'dart:typed_data' as typed;
// class VideoThumbnailCache {
//   // Cache to store generated thumbnails
//   Map<String, typed.Uint8List?> videoThumbnails = {};

//   // Method to get the thumbnail image for a video URL
//   ImageProvider getThumbnailImage(String videoUrl) {
//     // Check if the thumbnail is already cached
//     print("thumbnaail");
//     print(videoThumbnails);
//     print(videoUrl);
//     if (videoThumbnails.containsKey(videoUrl)) {
//       // Return the cached thumbnail image
//       return MemoryImage(videoThumbnails[videoUrl]!);
//     } else {
//       // If the thumbnail is not cached, start generating it asynchronously
//       generateThumbnail(videoUrl);
//       // Return a placeholder while the thumbnail is being generated
//       return AssetImage(CraftImagePath.image1);  // Update with your actual placeholder path
//     }
//   }

//   // Method to asynchronously generate a thumbnail and cache it
//   Future<void> generateThumbnail(String videoUrl) async {
//     try {
//       // Generate the thumbnail for the video
//       final typed.Uint8List? thumbnailData = await VideoThumbnail.thumbnailData(
//         video: videoUrl,
//         imageFormat: ImageFormat.JPEG,
//         maxWidth: 300,  // Max width for the thumbnail
//         quality: 75,    // Thumbnail quality
//       );

//       if (thumbnailData != null) {
//         // Cache the generated thumbnail
//         videoThumbnails[videoUrl] = thumbnailData;
//       }
//     } catch (e) {
//       print("Error generating thumbnail: $e");
//     }
//   }
// }