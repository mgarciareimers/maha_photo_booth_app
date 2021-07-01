import 'package:flutter/material.dart';

// Utils.
import 'package:maha_photo_booth_app/src/commons/utils/app_localizations.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';
import 'package:maha_photo_booth_app/src/commons/constants/strings.dart';
import 'package:maha_photo_booth_app/src/commons/utils/routes.dart';

// Widgets.
import 'package:maha_photo_booth_app/src/widgets/button_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.APP_NAME, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: this._createContent(context),
    );
  }

  // Method that creates the content.
  Widget _createContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Sizes.MARGIN_16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonCustom(text: AppLocalizations.of(context)!.translate('take_a_photo'), onClicked: this._onTakePhotoButtonClicked, icon: Icon(Icons.camera_alt, color: Colors.white)),
            SizedBox(height: Sizes.MARGIN_16),

            ButtonCustom(text: AppLocalizations.of(context)!.translate('view_photos'), onClicked: this._onViewPhotosButtonClicked, icon: Icon(Icons.photo, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // Method that creates the

  // Method that is called when the user clicks the 'take photo' button.
  void _onTakePhotoButtonClicked(BuildContext context) {

  }

  // Method that is called when the user clicks the 'view photos' button.
  void _onViewPhotosButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, Routes.GALLERY);
  }
}
