import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';
import 'package:maha_photo_booth_app/src/commons/constants/strings.dart';

// Widgets.
import 'package:maha_photo_booth_app/src/widgets/progress_bar.dart';

class Utils {
  // Method that shows an alert dialog.
  static void showAlertDialog(BuildContext context, String title, String content, String positiveName, String? negativeName, dynamic positiveAction, dynamic negativeAction) {
    if (Platform.isIOS) {
      showCupertinoAlertDialog(context, title, content, positiveName, negativeName, positiveAction, negativeAction);
    } else {
      showMaterialAlertDialog(context, title, content, positiveName, negativeName, positiveAction, negativeAction);
    }
  }

  // Method that shows the material alert dialog.
  static void showMaterialAlertDialog(BuildContext context, String title, String content, String positiveName, String? negativeName, dynamic positiveAction, dynamic negativeAction) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
                title: Text(title),
                content: Text(content, style: TextStyle(fontSize: Sizes.FONT_16)),
                actions: <Widget>[
                  negativeAction == null ? Container() : TextButton(
                    child: Text(negativeName!, style: TextStyle(color: Colors.red, fontSize: Sizes.FONT_18)),
                    onPressed: () => negativeAction(context),
                  ),
                  TextButton(
                    child: Text(positiveName, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: Sizes.FONT_18)),
                    onPressed: () => positiveAction(context),
                  ),
                ]
            ),
          );
        }
    );
  }

  // Method that shows the cupertino alert dialog.
  static void showCupertinoAlertDialog(BuildContext context, String title, String content, String positiveName, String? negativeName, dynamic positiveAction, dynamic negativeAction) {
    List<Widget> actions = [];

    if (negativeAction != null) {
      actions.add(CupertinoDialogAction(isDefaultAction: false, child: Text(negativeName!, style: TextStyle(color: Colors.red, fontSize: Sizes.FONT_18)), onPressed: () => negativeAction(context)));
    }

    actions.add(CupertinoDialogAction(isDefaultAction: true, child: Text(positiveName, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: Sizes.FONT_18)), onPressed: () => positiveAction(context)));

    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: Text(title),
            content: Text(content, style: TextStyle(fontSize: Sizes.FONT_16)),
            actions: actions,
          ),
        );
      },
    );
  }

  // Method that shows the progressbar alert dialog.
  static void showProgressBarAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: ProgressBar(text: text, color: Theme.of(context).primaryColor)
        );
      },
    );
  }

  // Method that adds a character to the left and/or right of the input string in case of need.
  static String padCharacterLeftRight(int finalLength, String character, String string, bool left, bool right) {
    if (!left && !right) {
      return string;
    }

    while(string.length < finalLength) {
      if (left) {
        string = '$character$string';
      }

      if (right && string.length < finalLength) {
        string = '$string$character';
      }
    }

    return string;
  }

  // Method that gets a datetime string from a date time.
  static String getDateTimeString(DateTime dateTime) {
    final String year = dateTime.year.toString();
    final String month = padCharacterLeftRight(2, Strings.ZERO, dateTime.month.toString(), true, false);
    final String day = padCharacterLeftRight(2, Strings.ZERO, dateTime.day.toString(), true, false);
    final String hour = padCharacterLeftRight(2, Strings.ZERO, dateTime.hour.toString(), true, false);
    final String minutes = padCharacterLeftRight(2, Strings.ZERO, dateTime.minute.toString(), true, false);
    final String seconds = padCharacterLeftRight(2, Strings.ZERO, dateTime.second.toString(), true, false);

    return '$month/$day/$year $hour:$minutes:$seconds';
  }
}