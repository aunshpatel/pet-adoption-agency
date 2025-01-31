import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

const kWhiteColor = Colors.white;

const kBlackColor = Colors.black;

const kDarkTitleColor = Color(0XFF3A4355);

const kBackgroundColor = Color(0XFFE3E6EF);

const kLightTitleColor = Color(0XFF697489);

const kFontWeightBold = TextStyle(fontWeight: FontWeight.bold,);

const kFontWeight500 = TextStyle(fontWeight: FontWeight.w500,);

const kFont16Weight500 = TextStyle(fontSize:16,fontWeight: FontWeight.w500,);

const kBoldFont18 = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

const kSideMenuLightTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kLightTitleColor,
);

const kSideMenuDarkTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kDarkTitleColor,
);

const kLightSemiBoldTextStyle = TextStyle(
    color: kLightTitleColor,
    fontSize: 18,
    fontWeight:FontWeight.w500
);

Future<void> commonAlertBox(BuildContext context, String title, String message)  {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: Text(title, style: kSideMenuDarkTextStyle),
        content: Text(message, style: kLightSemiBoldTextStyle),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('OK', style: kLightSemiBoldTextStyle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

Route createCustomRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 600),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
      var scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOut),
      );

      return FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      );
    },
  );
}