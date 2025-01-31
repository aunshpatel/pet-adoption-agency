import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

const kDarkTitleColor = Color(0XFF3A4355);

const kLightTitleColor = Color(0XFF697489);

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