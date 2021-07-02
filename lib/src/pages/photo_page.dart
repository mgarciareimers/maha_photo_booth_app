import 'package:flutter/material.dart';
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';
import 'package:maha_photo_booth_app/src/commons/utils/utils.dart';

// Models.
import 'package:maha_photo_booth_app/src/models/photo_model.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/strings.dart';

class PhotoPage extends StatelessWidget {
  final PhotoModel? photo;

  const PhotoPage({
    Key? key,
    this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.photo);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.APP_NAME, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: this._createContent(context),
    );
  }

  // Method that creates the content.
  Widget _createContent(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          this._createPhoto(),
          this._createPhotoData(context),
        ],
      ),
    );
  }

  // Method that creates the photo.
  Widget _createPhoto() {
    return Image.memory(
      this.photo!.photo!,
      height: double.infinity,
      fit: BoxFit.fitHeight,
    );
  }

  // Method that creates the photo data.
  Widget _createPhotoData(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.6),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(Sizes.MARGIN_16),
        child: Column(
          children: [
            Text(this.photo!.name!, style: TextStyle(fontSize: Sizes.FONT_16, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis),
            SizedBox(height: Sizes.MARGIN_8),

            Text('${ Utils.getDateTimeString(this.photo!.date!) }', style: TextStyle(fontSize: Sizes.FONT_12, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
