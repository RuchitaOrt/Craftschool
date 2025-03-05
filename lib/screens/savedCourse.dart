import 'package:craft_school/providers/CourseDetailProvider.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_strings.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/widgets/BottomAppBarNavigationScreen.dart';
import 'package:craft_school/widgets/BrowseOtherCourse.dart';
import 'package:craft_school/widgets/FloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:craft_school/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class Video {
  final String url;
  final String thumbnail;
  final String title;
  final String subtitle;
  final String description;

  Video({
    required this.url,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class SavedCourseScreen extends StatefulWidget {
  static const String route = "/savedVideoListscreen";

 
  @override
  _SavedCourseScreenState createState() => _SavedCourseScreenState();
}

class _SavedCourseScreenState extends State<SavedCourseScreen> {
final List<Video> videos = [
    Video(
      url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnail: CraftImagePath.image1,
      title: 'Big Buck Bunny',
      subtitle: 'By Blender Foundation',
      description: 'Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself...',
    ),
    Video(
      url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      thumbnail: CraftImagePath.image2,
      title: 'Elephant Dream',
      subtitle: 'By Blender Foundation',
      description: 'The first Blender Open Movie from 2006...',
    ),
    Video(
      url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      thumbnail: CraftImagePath.image4,
      title: 'Sintel',
      subtitle: 'By Blender Foundation',
      description: 'Sintel is an independently produced short film...',
    ),
    Video(
      url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
      thumbnail:CraftImagePath.image5,
      title: 'Tears of Steel',
      subtitle: 'By Blender Foundation',
      description: 'Tears of Steel was realized with crowd-funding...',
    ),
  ];
   final List<String> _imagePaths = [
    CraftImagePath.image1,
    CraftImagePath.image2,
    CraftImagePath.image3,
    CraftImagePath.image1,
  ];
  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    
    super.dispose();
  }

 
 Widget browseOtherCourse() {
    return ChangeNotifierProvider(
      create: (_) => CourseDetailProvider(),
      child: Consumer<CourseDetailProvider>(
      builder: (context, provider, child) {
        return 
         BrowseOtherCourse(imagePaths:provider.imagePaths ,title:  "Trending Classes",onPressed: ()
         {

         },);
        
      },
    ));
  }

@override
Widget build(BuildContext context) {


  return Scaffold(
   appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                isCategoryVisible: false,
                onMenuPressed: () {
                  // provider.toggleSlidingContainer();  // Trigger toggle when menu is pressed
                },
                   onCategoriesPressed: () {  }, isContainerVisible: false,
              ),
            ),
      backgroundColor: CraftColors.black18,
      bottomNavigationBar: BottomAppBarWidget(index: -1,),
      floatingActionButton:FloatingActionButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    
    body:  LayoutBuilder(
        builder: (context, constraints) {
          

          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          CraftStrings.strSavedCourses,
                          style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: SizeConfig.blockSizeVertical * 1),
            
                  Container(
                    height: SizeConfig.blockSizeVertical * 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return Card(
                          color: CraftColors.neutralBlue850,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 50,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: CraftColors.neutralBlue800,
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        image: DecorationImage(image: AssetImage(video.thumbnail), fit: BoxFit.cover),
                                      ),
                                      height: SizeConfig.blockSizeVertical * 28,
                                    ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                              decoration: BoxDecoration(
                                                color: CraftColors.secondary100,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "New !",
                                                  style: CraftStyles.tssecondary800W500,
                                                ),
                                              ),
                                            ),
                                      ),
                                    
                                  ],
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical * 1,
                                      ),
                                    
                                      Text(
                                        video.title,
                                        style: CraftStyles.tsWhiteNeutral50W600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16.0,
                                            backgroundImage: AssetImage(CraftImagePath.image3),
                                          ),
                                          SizedBox(
                                            width: SizeConfig.blockSizeHorizontal * 2,
                                          ),
                                          Container(
                                            width: SizeConfig.blockSizeHorizontal * 32,
                                            child: Text(
                                              "Komal Nahata",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: CraftStyles.tsWhiteNeutral50W700.copyWith(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
               
                 browseOtherCourse()
              ],
            ),
          );
        },
      ),
    
  );
}



}

