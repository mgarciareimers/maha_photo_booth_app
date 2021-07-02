import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Database.
import 'package:maha_photo_booth_app/src/database/database_helper.dart';

// Models.
import 'package:maha_photo_booth_app/src/models/photo_model.dart';

// Utils.
import 'package:maha_photo_booth_app/src/commons/utils/app_localizations.dart';
import 'package:maha_photo_booth_app/src/commons/utils/routes.dart';
import 'package:maha_photo_booth_app/src/commons/utils/utils.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/sizes.dart';
import 'package:maha_photo_booth_app/src/commons/constants/strings.dart';
import 'package:maha_photo_booth_app/src/pages/photo_page.dart';

// Widgets.
import 'package:maha_photo_booth_app/src/widgets/item_list_photo.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({ Key? key }) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool? hasLoaded;
  bool? isLoading;
  List<PhotoModel>? photos;

  @override
  void initState() {
    this.hasLoaded = false;
    this.isLoading = false;
    this.photos = [];

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
    if (this.hasLoaded!) {
      return this._createLoadedContent();
    }

    return FutureBuilder(
      future: this._getPhotos(),
      builder: (BuildContext context, AsyncSnapshot<List<PhotoModel>?> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(this.context).primaryColor)
              )
            );
          case ConnectionState.done: break;
        }

        this.hasLoaded = true;

        this._handleResponse(snapshot.data);

        return this._createLoadedContent();
      },
    );
  }

  // Method that handles the response.
  void _handleResponse(List<PhotoModel>? photos) {
    try {
      this.photos!.addAll(photos!);
    } catch(e) {
      this.photos = [];
    }
  }

  // Method that creates the loaded content.
  Widget _createLoadedContent() {
    if (this.photos == null || this.photos!.length <= 0) {
      return Container(
        padding: EdgeInsets.all(Sizes.MARGIN_16),
        child: Center(
          child: Text(AppLocalizations.of(this.context)!.translate('photos_not_found')),
        ),
      );
    }

    return Container(
      height: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: this.photos!.length,
        itemBuilder: (BuildContext context, int index) => ItemListPhoto(index: index, photo: this.photos![index], isLast: index >= this.photos!.length - 1, onItemClicked: this._onItemClicked, onDeleteItemButtonClicked: this._deleteItem),
      ),
    );
  }

  // Method that gets the photos.
  Future<List<PhotoModel>?> _getPhotos() async {
    await DatabaseHelper().database;
    return await DatabaseHelper().getPhotos();
  }

  // Method that is called when the user deletes an item.
  void _deleteItem(int index, int id) async {
    if (this.isLoading!) {
      return;
    }

    Utils.showProgressBarAlertDialog(this.context, AppLocalizations.of(this.context)!.translate('deletingPhoto'));

    int deleted = await DatabaseHelper().deletePhotoById(id);

    Navigator.pop(this.context);

    if (deleted <= 0) {
      return Utils.showAlertDialog(this.context, AppLocalizations.of(this.context)!.translate('error'), AppLocalizations.of(this.context)!.translate('deletePhotoError'), AppLocalizations.of(this.context)!.translate('ok'), null, Navigator.pop, null);
    }

    this.photos!.removeAt(index);
    this.setState(() {});
  }

  // Method that is called when the user clicks the item.
  void _onItemClicked(PhotoModel photo) {
    Navigator.push(this.context,
      Platform.isIOS ?
        CupertinoPageRoute(builder: (BuildContext context) => PhotoPage(photo: photo))
          :
        MaterialPageRoute(builder: (BuildContext context) => PhotoPage(photo: photo))
    );
  }
}