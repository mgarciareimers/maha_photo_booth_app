import 'package:flutter/material.dart';

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
    );
  }
}
