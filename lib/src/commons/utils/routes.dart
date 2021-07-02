import 'package:flutter/material.dart';

// Pages.
import 'package:maha_photo_booth_app/src/pages/gallery_page.dart';
import 'package:maha_photo_booth_app/src/pages/home_page.dart';
import 'package:maha_photo_booth_app/src/pages/photo_page.dart';

class Routes {
  static const String GALLERY = 'gallery';
  static const String HOME = 'home';
  static const String PHOTO = 'photo';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      GALLERY: (BuildContext context) => GalleryPage(),
      HOME: (BuildContext context) => HomePage(),
      PHOTO: (BuildContext context) => PhotoPage(photo: null),
    };
  }
}