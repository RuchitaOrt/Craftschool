import 'package:craft_school/main.dart';
import 'package:craft_school/providers/personal_account_provider.dart';
import 'package:craft_school/screens/Landing_Screen.dart';
import 'package:craft_school/screens/signIn_screen.dart';
import 'package:craft_school/screens/signup_screen.dart';
import 'package:craft_school/utils/craft_colors.dart';
import 'package:craft_school/utils/craft_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class ShowDialogs {
 


  unAthorizedTokenErrorDialog(BuildContext context, {String? message}) {

    final personalAccountProvider = Provider.of<PersonalAccountProvider>(context, listen: false);
    // set up the button

    Widget okButton = ElevatedButton(
        child: Text("OK"),
        onPressed: () {
personalAccountProvider.logoutAPI("");
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => SignInScreen()));
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("CraftSchool"),
      content: Text(message!),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor:CraftColors.neutralBlue850,
        backgroundColor: Colors.white,
        fontSize: 14.0);
  }
static exitDialog()
{
  showDialog(
    context: routeGlobalKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text('Exit App'),
      content: Text('Are you sure you want to exit?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop(); // Close the app
          },
          child: Text('Exit'),
        ),
      ],
    ),
  );
}
  static Future<bool> showConfirmDialogdelete(BuildContext context,
      String dialogTitle, String dialogMessage, Function() onYesTap) async {
    bool yesNo = await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,

          content: Container(
            height: 180,
            //width: double.infinity-10.0,
            //  color: customcolor.greybackground1,
            decoration: BoxDecoration(
              color: CraftColors.neutralBlue800,
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '$dialogMessage',
                    style: TextStyle(color: CraftColors.neutral100, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                                           padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0.0),
                      child: ElevatedButton(

                         style: ElevatedButton.styleFrom(
                               

                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(15.0)) ),
                  
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: CraftColors.black18,
                            fontSize: 14.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0.0),
                      child: ElevatedButton(
                        //padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),

                         style: ElevatedButton.styleFrom(
                                  
                                        shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(15.0)) ),
                        onPressed: onYesTap,
                      
                        child: Text(
                          'Yes, Remove',
                          style: TextStyle(
                            color: CraftColors.black18,
                            fontSize: 14.0,
                          ),
                        ),
                       
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
       
        );
      },
    );
    return yesNo;
  }

static showDeviceLimitExceededSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,  // Disable dismissing by tapping outside
    enableDrag: false,     // Disable dragging the sheet
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CraftColors.neutralBlue850,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Exceeding Device Limit Icon
            Icon(
              Icons.logout_outlined,
              color: Colors.red,
              size: 40,
            ),
            SizedBox(height: 20),
            // Title
            Text(
              'You Were Logged Out !',
              style: CraftStyles.tsWhiteNeutral200W500,
            ),
            SizedBox(height: 10),
            // Message
            Text(
              'You were logged out from another account due to exceeding device limit.',
              textAlign: TextAlign.center,
              style: CraftStyles.tsNeutral100W400,
            ),
            SizedBox(height: 30),
            // Logout Button
           
            TextButton(
              onPressed: () {
                // Go to home screen or perform other action
                Navigator.pop(context); // Close bottom sheet
                Navigator.of(
          routeGlobalKey.currentContext!,
        ).pushNamed(
          LandingScreen.route,
        );
              },
              child: Text(
                'Go Home',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      );
    },
  );
}

}

