import 'package:craft_school/main.dart';
import 'package:craft_school/providers/LandingScreenProvider.dart';
import 'package:craft_school/providers/personal_account_provider.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_images.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:craft_school/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DeviceLimitReachedScreen extends StatefulWidget {
  final String msg;
    static const String route = "/deviceLimitScreen";

  const DeviceLimitReachedScreen({super.key, required this.msg});
  @override
  State<DeviceLimitReachedScreen> createState() => _DeviceLimitReachedScreenState();
}

class _DeviceLimitReachedScreenState extends State<DeviceLimitReachedScreen> {
  
  @override
  void initState() {
    super.initState();

   final provider =
          Provider.of<LandingScreenProvider>(context, listen: false);


           if(!provider.isDeviceInfoLoading)
      {
        provider.getLoggedInDeviceInfoAPI();
      } 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CraftColors.black18,
      appBar: AppBar(
        title: Text("Device Limit Reached",style: CraftStyles.tsWhiteNeutral50W70016,),
        leading: Icon(Icons.arrow_back_ios,color: CraftColors.neutral100,),
        backgroundColor: CraftColors.neutral900,  // Custom color
      ),
      body: 
        Consumer<LandingScreenProvider>(
                builder: (context, provider, child) {
              return 
      ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                                      CraftImagePath.device, // Replace with your image path
                                      fit: BoxFit.cover, // Ensures the image fills the space
                                    ),
                Text(
                  "Login Pending Device Limit Reached",
                  style: CraftStyles.tsWhiteNeutral50W70016,
                ),
                SizedBox(height: 20),
                Text(
                 "${widget.msg} \nOr"
                  "\nPlease log out from other devices to proceed.",
                  textAlign: TextAlign.center,
                  style: CraftStyles.tsNeutral100W400,
                ),
                SizedBox(height: 30),
                
                // Display devices the user is logged in to (Optional)
                if (provider.deviceInfoList.isNotEmpty) 
                  Container(
                    padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                          color: CraftColors.neutralBlue800,
                            borderRadius: BorderRadius.circular(5)
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Currently logged in devices:",
                          style: CraftStyles.tsWhiteNeutral50W70016,
                        ),
                        SizedBox(height: 10),
                     ListView.builder(
                       shrinkWrap: true,
        physics: ScrollPhysics(),
  itemCount: provider.deviceInfoList[0].deviceInfo.length, // Length of your device list
  itemBuilder: (context, index) {
  if(provider.isDeviceInfoLoading)
      {
    return CircularProgressIndicator(color: CraftColors.neutral100,);
      }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.devices, size: 20, color: Colors.grey),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider.deviceInfoList.length.toString(),style: CraftStyles.tsWhiteNeutral50W600),
                  Text(provider.deviceInfoList[0].deviceInfo[index].device, style: CraftStyles.tsWhiteNeutral50W600),
                  Text(provider.deviceInfoList[0].deviceInfo[index].lastUsedTime, style: CraftStyles.tsNeutral100W400),
                ],
              ),
            ],
          ),
          //  Text(provider.deviceInfoList[0].deviceInfo.length.toString(),style: CraftStyles.tsWhiteNeutral50W600),
          //   Text(provider.deviceInfoList[0].countofdevice.toString(),style: CraftStyles.tsWhiteNeutral50W600),
          Consumer<PersonalAccountProvider>(builder: (context, personalprovider, child) {
            
            return
          ElevatedButton(
            onPressed: () {
              // Show confirmation dialog before logging out
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Confirm Logout"),
                  content: Text("Are you sure you want to log out from these devices?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);  // Close the dialog
                      },
                      child: Text("Cancel"),
                    ),
                    
                    TextButton(
                      onPressed: () {
                        personalprovider.logoutAPI(provider.deviceInfoList[0].deviceInfo[index].token).then((value) {
 Navigator.pop(context); 
                       
                        showLogoutSuccess(); 
                        if(!provider.isDeviceInfoLoading)
      {
        provider.getLoggedInDeviceInfoAPI().then((value){
 print("#ruchita loggin");
    print("#ruchita loggin device");
  print("#ruchita loggin device ${provider.deviceInfoList[0].deviceInfo.length.toString()}");
    print("#ruchita loggin countofdevice");
    print("#ruchita loggin countofdevice ${provider.deviceInfoList[0].countofdevice.toString()}");
if(int.parse(provider.deviceInfoList[0].deviceInfo.length.toString()) < int.parse(provider.deviceInfoList[0].countofdevice.toString()))
{
  print("#ruchitaSuccessful Condition");
  Navigator.of(
            routeGlobalKey.currentContext!,
          ).pushNamed(
            LandingScreen.route,
          );
}
        }  );    } 
 
                        });
                       
                       
                      },
                      child: Text("Logout"),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(SizeConfig.blockSizeVertical * 5, SizeConfig.blockSizeVertical * 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: CraftColors.neutral100),
              ),
              backgroundColor: CraftColors.neutralBlue750,
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 25),
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            child:
             personalprovider.isLoading?
           Center(child: CircularProgressIndicator(color: CraftColors.neutral100,)):
        
             Text("Logout", style: CraftStyles.tsWhiteNeutral50W600),
          );
          }),
        ],
      ),
    );
  },
)

                      ],
                    ),
                  ),
           
          
                // Logout from all devices button
                
              ],
            ),
          ),
        ],
      );
                })
    );
  }

  void showLogoutSuccess() {
    ScaffoldMessenger.of(routeGlobalKey.currentContext!).showSnackBar(
      
      SnackBar(content: Text("Logged out from these devices successfully!")),
    );
  }
}
