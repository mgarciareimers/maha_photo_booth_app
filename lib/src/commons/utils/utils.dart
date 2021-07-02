import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';

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
}