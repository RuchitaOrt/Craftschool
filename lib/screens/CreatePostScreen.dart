import 'dart:io';
import 'package:craft_school/providers/CommunityProvider.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/screens/PostScreen.dart';
import 'package:craft_school/utils/GlobalLists.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:craft_school/widgets/SlidingCategory.dart';
import 'package:craft_school/widgets/SlidingMenu.dart';
import 'package:craft_school/widgets/VideoPlayerWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreatePostScreen extends StatefulWidget {
  final String postcomment;
  final String postId;
  final List<dynamic> medias;
  final bool iseditView;
  static const String route = '/createpostscreen';

  const CreatePostScreen({
    super.key,
    required this.postcomment,
    required this.postId,
    required this.medias,
    required this.iseditView,
  });

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _captionController = TextEditingController();
  List<File> _selectedMedia = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LandingScreenProvider>(context, listen: false);
    if (!provider.isSubscriptionLoading) {
      provider.getcheckSubscriptionIndividualFlowWiseInfoAPI();
    }
    if (widget.iseditView) {
      _captionController.text = widget.postcomment;
    }
  }

  Future<void> _pickMedia() async {
    if (_selectedMedia.length + widget.medias.length >= 10) {
      setState(() {
        _errorMessage = "You can only select up to 10 media.";
      });
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      if (_selectedMedia.length + widget.medias.length + files.length > 10) {
        setState(() {
          _errorMessage = "You can only select up to 10 media.";
        });
        return;
      }
      setState(() {
        _selectedMedia.addAll(files);
        _errorMessage = null;
      });
    }
  }

  void _removeMedia(dynamic media, int index, CommunityProvider provider) {
    if (media is File) {
      setState(() {
        _selectedMedia.remove(media);
      });
    } else {
      provider
          .deleteMediaFromCommunityPosttAPI(media.mediaId.toString())
          .then((value) {
        setState(() {
          widget.medias.removeAt(index - _selectedMedia.length);
        });
      });
    }
  }

  bool isVideo(String path) {
    return path.toLowerCase().endsWith('.mp4') ||
        path.toLowerCase().endsWith('.mov');
  }

  Future<Widget> _buildMediaPreview(File file) async {
    if (isVideo(file.path)) {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.memory(
              uint8list!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          file,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  bool _validateForm() {
    if (_captionController.text.isEmpty) {
      setState(() {
        _errorMessage = "Please enter some text for your post.";
      });
      return false;
    }
    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pushNamed(PostScreen.route);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingScreenProvider(),
      child: Consumer<LandingScreenProvider>(
        builder: (context, provider, _) {
          return WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(
                  isCategoryVisible: provider.isCategoryVisible,
                  onMenuPressed: provider.toggleSlidingContainer,
                  onCategoriesPressed: provider.toggleSlidingCategory,
                  isContainerVisible: provider.isCategoryVisible,
                  isSearchClickVisible: ()
                {
                  provider.toggleSearchIconCategory();
                },
                isSearchValueVisible: provider.isSearchIconVisible,
                ),
              ),
              backgroundColor: CraftColors.black18,
              body: Consumer<CommunityProvider>(
                builder: (context, communityprovider, _) {
                  List<dynamic> combinedMedia = [..._selectedMedia, ...widget.medias];
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.iseditView ? "Edit Post" : "Create Post",
                                style: CraftStyles.tsWhiteNeutral50W70016,
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 2),
                              TextField(
                                controller: _captionController,
                                style: CraftStyles.tsWhiteNeutral300W400,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  hintText: "What’s up, ${GlobalLists.customerName} ?",
                                  filled: true,
                                  fillColor: CraftColors.neutralBlue750,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 4),
                              if (_errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: _pickMedia,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          CraftImagePath.imagelogo,
                                          height: 16.0,
                                          width: 16.0,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Media",
                                          style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeVertical * 14,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_validateForm()) {
                                          if (widget.iseditView) {
                                            communityprovider.editPost(
                                                _captionController.text, _selectedMedia, widget.postId);
                                          } else {
                                            communityprovider.uploadPost(_captionController.text, _selectedMedia);
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                          SizeConfig.blockSizeVertical * 0.6,
                                          SizeConfig.blockSizeVertical * 5,
                                        ),
                                        backgroundColor: CraftColors.primaryBlue550,
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 5,
                                      ),
                                      child: communityprovider.ispostLoading
                                          ? const CircularProgressIndicator(color: CraftColors.neutral100)
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  CraftImagePath.publishlogo,
                                                  height: 16.0,
                                                  width: 16.0,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  CraftStrings.strPublish,
                                                  style: CraftStyles.tsWhiteNeutral50W60016.copyWith(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 4),
                              if (combinedMedia.isNotEmpty)
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemCount: combinedMedia.length,
                                  itemBuilder: (context, index) {
                                    var media = combinedMedia[index];
                                    return Stack(
                                      children: [
                                        FutureBuilder<Widget>(
                                          future: media is File
                                              ? _buildMediaPreview(media)
                                              : Future.value(
                                                  isVideo(media.mediaUrl)
                                                      ? VideoPlayerWidget(videoUrl: media.mediaUrl)
                                                      : ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: Image.network(
                                                            media.mediaUrl,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                ),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const Center(child: CircularProgressIndicator());
                                            }
                                            return snapshot.data!;
                                          },
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: GestureDetector(
                                            onTap: () => _removeMedia(media, index, communityprovider),
                                            child: const Icon(
                                              Icons.delete_rounded,
                                              color: Colors.red,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (provider.isContainerVisible) SlidingMenu(isVisible: provider.isContainerVisible),
                      if (provider.isCategoryVisible)
                        SlidingCategory(
                          isExpanded: provider.isCategoryVisible,
                          onToggleExpansion: provider.toggleSlidingCategory,
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'dart:io';
// import 'package:craft_school/providers/CommunityProvider.dart';
// import 'package:craft_school/providers/LandingScreenProvider.dart';
// import 'package:craft_school/screens/PostScreen.dart';
// import 'package:craft_school/utils/GlobalLists.dart';
// import 'package:craft_school/utils/craft_colors.dart';
// import 'package:craft_school/utils/craft_images.dart';
// import 'package:craft_school/utils/craft_strings.dart';
// import 'package:craft_school/utils/craft_styles.dart';
// import 'package:craft_school/utils/sizeConfig.dart';
// import 'package:craft_school/widgets/CustomAppBar.dart';
// import 'package:craft_school/widgets/SlidingCategory.dart';
// import 'package:craft_school/widgets/SlidingMenu.dart';
// import 'package:craft_school/widgets/VideoPlayerWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

// class CreatePostScreen extends StatefulWidget {
//   final String postcomment;
//   final String postId;
//   final List<dynamic> medias;
//   final bool iseditView;
//   static const String route = '/createpostscreen';

//   const CreatePostScreen({
//     super.key,
//     required this.postcomment,
//     required this.postId,
//     required this.medias,
//     required this.iseditView,
//   });

//   @override
//   _CreatePostScreenState createState() => _CreatePostScreenState();
// }

// class _CreatePostScreenState extends State<CreatePostScreen> {
//   final _captionController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   List<XFile> _selectedMedia = [];
//   List<String> result = [];
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();

//     final providerSubscription =
//         Provider.of<LandingScreenProvider>(context, listen: false);

//     if (!providerSubscription.isSubscriptionLoading) {
//       providerSubscription.getcheckSubscriptionIndividualFlowWiseInfoAPI();
//     }
//     if (widget.iseditView) {
//       _captionController.text = widget.postcomment;
//     }
//   }

//   Future<void> _pickMedia() async {
//     if (_selectedMedia.length + widget.medias.length >= 10) {
//       setState(() {
//         _errorMessage = "You can only select up to 10 media.";
//       });
//       return;
//     }

//     final XFile? file = await _picker.pickMedia();
//     if (file != null) {
//       setState(() {
//         _errorMessage = null;
//         _selectedMedia.add(file);
//         result = _selectedMedia.map((e) => e.path).toList();
//       });
//     }
//   }

//   void _removeMedia(dynamic media, int index, CommunityProvider provider) {
//     if (media is XFile) {
//       setState(() {
//         _selectedMedia.remove(media);
//       });
//     } else {
//       provider
//           .deleteMediaFromCommunityPosttAPI(media.mediaId.toString())
//           .then((value) {
//         setState(() {
//           widget.medias.removeAt(index - _selectedMedia.length);
//         });
//       });
//     }
//   }

//   bool isVideo(String url) {
//     return url.toLowerCase().endsWith('.mp4') ||
//         url.toLowerCase().endsWith('.mov');
//   }

//   Future<Widget> _buildMediaPreview(XFile file) async {
//     if (isVideo(file.path)) {
//       final uint8list = await VideoThumbnail.thumbnailData(
//         video: file.path,
//         imageFormat: ImageFormat.JPEG,
//         quality: 75,
//       );
//       return Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.memory(
//               uint8list!,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             ),
//           ),
//           const Align(
//             alignment: Alignment.center,
//             child: Icon(
//               Icons.play_circle_fill,
//               color: Colors.white,
//               size: 40,
//             ),
//           )
//         ],
//       );
//     } else {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Image.file(
//           File(file.path),
//           fit: BoxFit.cover,
//         ),
//       );
//     }
//   }

//   bool _validateForm() {
//     if (_captionController.text.isEmpty) {
//       setState(() {
//         _errorMessage = "Please enter some text for your post.";
//       });
//       return false;
//     }

//     if (_selectedMedia.length + widget.medias.length > 10) {
//       setState(() {
//         _errorMessage = "You can only select up to 10 media.";
//       });
//       return false;
//     }

//     setState(() {
//       _errorMessage = null;
//     });
//     return true;
//   }
//   Future<bool> _onBackPressed() async {
//      Navigator.of(context).pushNamed(PostScreen.route).then((value) {});
//     return true; // Allow default back press behavior
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {
//           return WillPopScope(
//               onWillPop: _onBackPressed,
//             child: Scaffold(
//               appBar: PreferredSize(
//                 preferredSize: const Size.fromHeight(kToolbarHeight),
//                 child: CustomAppBar(
//                   isCategoryVisible: provider.isCategoryVisible,
//                   onMenuPressed: provider.toggleSlidingContainer,
//                   onCategoriesPressed: provider.toggleSlidingCategory,
//                   isContainerVisible: provider.isCategoryVisible,
//                 ),
//               ),
//               backgroundColor: CraftColors.black18,
//               body: Consumer<CommunityProvider>(
//                   builder: (context, communityprovider, _) {
//                 List<dynamic> combinedMedia = [..._selectedMedia, ...widget.medias];
//                 return Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.iseditView ? "Edit Post" : "Create Post",
//                               style: CraftStyles.tsWhiteNeutral50W70016,
//                             ),
//                             SizedBox(height: SizeConfig.blockSizeVertical * 2),
//                             TextField(
//                               controller: _captionController,
//                               style: CraftStyles.tsWhiteNeutral300W400,
//                               maxLines: 8,
//                               decoration: InputDecoration(
//                                 hintText:
//                                     "What’s up, ${GlobalLists.customerName} ?",
//                                 filled: true,
//                                 fillColor: CraftColors.neutralBlue750,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: SizeConfig.blockSizeVertical * 4),
//                             if (_errorMessage != null)
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 16.0),
//                                 child: Text(
//                                   _errorMessage!,
//                                   style: const TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 GestureDetector(
//                                   onTap: _pickMedia,
//                                   child: Row(
//                                     children: [
//                                       SvgPicture.asset(
//                                         CraftImagePath.imagelogo,
//                                         height: 16.0,
//                                         width: 16.0,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         "Media",
//                                         style: CraftStyles.tsWhiteNeutral50W60016
//                                             .copyWith(fontSize: 14),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: SizeConfig.blockSizeVertical * 14,
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       if (_validateForm()) {
//                                         if (widget.iseditView) {
//                                           communityprovider.editPost(
//                                               _captionController.text,
//                                               _selectedMedia,
//                                               widget.postId);
//                                         } else {
//                                           communityprovider.uploadPost(
//                                               _captionController.text,
//                                               _selectedMedia);
//                                         }
//                                       }
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       minimumSize: Size(
//                                         SizeConfig.blockSizeVertical * 0.6,
//                                         SizeConfig.blockSizeVertical * 5,
//                                       ),
//                                       backgroundColor: CraftColors.primaryBlue550,
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 4, vertical: 4),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       elevation: 5,
//                                     ),
//                                     child: communityprovider.ispostLoading
//                                         ? const CircularProgressIndicator(
//                                             color: CraftColors.neutral100,
//                                           )
//                                         : Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               SvgPicture.asset(
//                                                 CraftImagePath.publishlogo,
//                                                 height: 16.0,
//                                                 width: 16.0,
//                                               ),
//                                               const SizedBox(width: 8),
//                                               Text(
//                                                 CraftStrings.strPublish,
//                                                 style: CraftStyles
//                                                     .tsWhiteNeutral50W60016
//                                                     .copyWith(fontSize: 14),
//                                               ),
//                                             ],
//                                           ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: SizeConfig.blockSizeVertical * 4),
//                             if (combinedMedia.isNotEmpty)
//                               GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   crossAxisSpacing: 8,
//                                   mainAxisSpacing: 8,
//                                 ),
//                                 itemCount: combinedMedia.length,
//                                 itemBuilder: (context, index) {
//                                   var media = combinedMedia[index];
//                                   return Stack(
//                                     children: [
//                                       FutureBuilder<Widget>(
//                                         future: media is XFile
//                                             ? _buildMediaPreview(media)
//                                             : Future.value(
//                                                 isVideo(media.mediaUrl)
//                                                     ? VideoPlayerWidget(
//                                                         videoUrl: media.mediaUrl)
//                                                     : ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                                 8),
//                                                         child: Image.network(
//                                                           media.mediaUrl,
//                                                           fit: BoxFit.cover,
//                                                         ),
//                                                       ),
//                                               ),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return const Center(
//                                                 child:
//                                                     CircularProgressIndicator());
//                                           }
//                                           return snapshot.data!;
//                                         },
//                                       ),
//                                       Align(
//                                         alignment: Alignment.topLeft,
//                                         child: GestureDetector(
//                                           onTap: () => _removeMedia(
//                                               media, index, communityprovider),
//                                           child: const Icon(
//                                             Icons.delete_rounded,
//                                             color: Colors.red,
//                                             size: 24,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     if (provider.isContainerVisible)
//                       SlidingMenu(isVisible: provider.isContainerVisible),
//                     if (provider.isCategoryVisible)
//                       SlidingCategory(
//                         isExpanded: provider.isCategoryVisible,
//                         onToggleExpansion: provider.toggleSlidingCategory,
//                       ),
//                   ],
//                 );
//               }),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
