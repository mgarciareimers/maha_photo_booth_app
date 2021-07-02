import 'package:sqflite/sqflite.dart';

// Models.
import 'package:maha_photo_booth_app/src/models/photo_model.dart';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/fields.dart';

class PhotoDatabaseService {
  static void createTable(Database database, int version) async {
    return await database.execute(
      'CREATE TABLE ${ Fields.PHOTOS }('
        '${ Fields.ID } INTEGER PRIMARY KEY AUTOINCREMENT, '
        '${ Fields.NAME } TEXT, '
        '${ Fields.PHOTO } BLOB, '
        '${ Fields.DATE } TEXT'
      ')'
    );
  }

  // Get all.
  static Future<List<PhotoModel>> getAll(Database database) async {
    List<Map<String, dynamic>> results = await database.query(Fields.PHOTOS, orderBy: '${ Fields.DATE } DESC');

    List<PhotoModel> photos = [];

    if (results.length > 0) {
      for (Map<String, dynamic> element in results) {
        PhotoModel photo =  PhotoModel.fromJson(element);

        if (photo.id != null) {
          photos.add(photo);
        }
      }
    }

    return photos;
  }

  // Insert.
  static Future<PhotoModel> insert(Database database, PhotoModel photo) async {
    photo.date = new DateTime.now();
    photo.id = await database.insert(Fields.PHOTOS, photo.toJson());

    return photo;
  }

  // Update.
  static Future<int> update(Database database, PhotoModel photo) async {
    photo.date = new DateTime.now();
    return await database.update(Fields.PHOTOS, photo.toJson(), where: '${ Fields.ID } = ?', whereArgs: [photo.id]);
  }

  // Delete.
  static Future<int> delete(Database database, int id) async {
    return await database.delete(Fields.PHOTOS, where: '${ Fields.ID } = ?', whereArgs: [id]);
  }
}