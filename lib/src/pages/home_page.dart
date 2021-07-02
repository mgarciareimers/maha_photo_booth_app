import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Utils.
import 'package:maha_photo_booth_app/src/commons/utils/app_localizations.dart';
import 'package:maha_photo_booth_app/src/commons/utils/routes.dart';
import 'package:maha_photo_booth_app/src/commons/utils/utils.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';
import 'package:maha_photo_booth_app/src/commons/constants/strings.dart';
import 'package:maha_photo_booth_app/src/database/database_helper.dart';
import 'package:maha_photo_booth_app/src/models/photo_model.dart';

// Widgets.
import 'package:maha_photo_booth_app/src/widgets/button_custom.dart';
import 'package:maha_photo_booth_app/src/widgets/text_field_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickedFile? pickedFile;
  String? photoName;

  @override
  void initState() {
    this.photoName = Strings.EMPTY_STRING;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.APP_NAME, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: this._createContent(),
    );
  }


  // Method that creates the content.
  Widget _createContent() {
    return Container(
      padding: EdgeInsets.all(Sizes.MARGIN_16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonCustom(text: AppLocalizations.of(this.context)!.translate('take_a_photo'), onClicked: this._onTakePhotoButtonClicked, icon: Icon(Icons.camera_alt, color: Colors.white)),
            SizedBox(height: Sizes.MARGIN_16),

            ButtonCustom(text: AppLocalizations.of(this.context)!.translate('view_photos'), onClicked: this._onViewPhotosButtonClicked, icon: Icon(Icons.photo, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // Method that is called when the user clicks the 'view photos' button.
  void _onViewPhotosButtonClicked(BuildContext context) {
    Navigator.pushNamed(this.context, Routes.GALLERY);
  }

  // Method that is called when the user clicks the 'take photo' button.
  void _onTakePhotoButtonClicked(BuildContext context) async {
    try {
      this.pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

      if (this.pickedFile == null) {
        return;
      }

      // Show naming dialog.
      this._showPhotoNameDialog();
    } catch(e) {
      Utils.showAlertDialog(this.context, AppLocalizations.of(this.context)!.translate('error'), AppLocalizations.of(this.context)!.translate('genericErrorCameraOpening'), AppLocalizations.of(this.context)!.translate('ok'), null, Navigator.pop, null);
    }
  }

  // Method that shows the 'photo name' dialog.
  void _showPhotoNameDialog() {
    this.photoName = Strings.EMPTY_STRING;

    showDialog(context: this.context, builder: (BuildContext context) => Platform.isIOS ? this._createCupertinoPhotoNameDialog() : this._createMaterialPhotoNameDialog());
  }

  // Method that creates the cupertino 'photo name' dialog.
  Widget _createCupertinoPhotoNameDialog() {
    return CupertinoAlertDialog(
      title: Text(AppLocalizations.of(this.context)!.translate('photo_name')),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(this.context)!.translate('photo_name_text')),
            SizedBox(height: Sizes.MARGIN_16),
            TextFieldCustom(hint: Strings.EMPTY_STRING, onValueChanged: this._onPhotoNameChanged),
          ],
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(AppLocalizations.of(this.context)!.translate('cancel'), style: TextStyle(color: Colors.red, fontSize: Sizes.FONT_18)),
          onPressed: () => Navigator.pop(this.context),
        ),
        CupertinoDialogAction(
          child: Text(AppLocalizations.of(this.context)!.translate('continue'), style: TextStyle(color: Theme.of(this.context).primaryColor, fontSize: Sizes.FONT_18)),
          onPressed: () => this._onContinueSavingPhotoButtonClicked(),
        ),
      ]
    );
  }

  // Method that creates the material 'photo name' dialog.
  Widget _createMaterialPhotoNameDialog() {
    return AlertDialog(
      title: Text(AppLocalizations.of(this.context)!.translate('photo_name')),
      contentPadding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 0),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(this.context)!.translate('photo_name_text')),
            SizedBox(height: Sizes.MARGIN_16),
            TextFieldCustom(hint: Strings.EMPTY_STRING, onValueChanged: this._onPhotoNameChanged),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(this.context)!.translate('cancel'), style: TextStyle(color: Colors.red, fontSize: Sizes.FONT_18)),
          onPressed: () => Navigator.pop(this.context),
        ),
        TextButton(
          child: Text(AppLocalizations.of(this.context)!.translate('continue'), style: TextStyle(color: Theme.of(this.context).primaryColor, fontSize: Sizes.FONT_18)),
          onPressed: () => this._onContinueSavingPhotoButtonClicked(),
        ),
      ]
    );
  }

  // Method that is called when the user changes the 'photo name' text field.
  void _onPhotoNameChanged(String value) {
    this.photoName = value;
  }

  // Method that is called when the user clicks the 'continue' button.
  void _onContinueSavingPhotoButtonClicked() async {
    if (this.photoName == null || this.photoName!.trim().length <= 0) {
      Navigator.pop(this.context);
      return Utils.showAlertDialog(this.context, AppLocalizations.of(this.context)!.translate('error'), AppLocalizations.of(this.context)!.translate('photoNameValidationError'), AppLocalizations.of(this.context)!.translate('ok'), null, this._onOkValidationErrorButtonClicked, null);
    }

    FocusScope.of(this.context).unfocus();

    await DatabaseHelper().database;
    PhotoModel photo = await DatabaseHelper().insertPhoto(new PhotoModel(name: this.photoName, photo: await this.pickedFile!.readAsBytes()));

    Navigator.pop(this.context);

   ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(this.context)!.translate('success_insert_photo')),
      duration: Duration(milliseconds: 700),
    ));
  }

  // Method that is called when the user clicks the 'ok' button in photo name validation error.
  void _onOkValidationErrorButtonClicked(BuildContext context) {
    Navigator.pop(this.context);
    this._showPhotoNameDialog();
  }
}
