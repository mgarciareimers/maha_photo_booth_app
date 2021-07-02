import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';
import 'package:maha_photo_booth_app/src/commons/constants/strings.dart';
import 'package:maha_photo_booth_app/src/commons/utils/app_localizations.dart';
import 'package:maha_photo_booth_app/src/widgets/text_field_custom.dart';

class DialogPhotoName extends StatelessWidget {
  final Function(String value) onPhotoNameChanged;
  final Function() onContinueSavingPhotoButtonClicked;

  const DialogPhotoName({
    Key? key,
    required this.onPhotoNameChanged,
    required this.onContinueSavingPhotoButtonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? this._createCupertinoPhotoNameDialog(context) : this._createMaterialPhotoNameDialog(context);
  }

  // Method that creates the cupertino 'photo name' dialog.
  Widget _createCupertinoPhotoNameDialog(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context)!.translate('photo_name')),
        content: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.translate('photo_name_text')),
                SizedBox(height: Sizes.MARGIN_16),
                TextFieldCustom(hint: Strings.EMPTY_STRING, onValueChanged: this.onPhotoNameChanged),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(AppLocalizations.of(context)!.translate('cancel'), style: TextStyle(color: Colors.red, fontSize: Sizes.FONT_18)),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text(AppLocalizations.of(context)!.translate('continue'), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: Sizes.FONT_18)),
            onPressed: () => this.onContinueSavingPhotoButtonClicked(),
          ),
        ]
    );
  }

  // Method that creates the material 'photo name' dialog.
  Widget _createMaterialPhotoNameDialog(BuildContext context) {
    return AlertDialog(
        title: Text(AppLocalizations.of(context)!.translate('photo_name')),
        contentPadding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 0),
        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.translate('photo_name_text')),
              SizedBox(height: Sizes.MARGIN_16),
              TextFieldCustom(hint: Strings.EMPTY_STRING, onValueChanged: this.onPhotoNameChanged),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('cancel'), style: TextStyle(color: Colors.red, fontSize: Sizes.FONT_18)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('continue'), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: Sizes.FONT_18)),
            onPressed: () => this.onContinueSavingPhotoButtonClicked(),
          ),
        ]
    );
  }
}
