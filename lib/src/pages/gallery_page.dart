import 'package:flutter/material.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/strings.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.APP_NAME, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
    );
  }
}
