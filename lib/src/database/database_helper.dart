import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Services.
import 'package:maha_photo_booth_app/src/database/services/photo_database_service.dart';

// Models.
import 'package:maha_photo_booth_app/src/models/photo_model.dart';

class DatabaseHelper {
  static const String DATABASE_NAME = 'photo_booth_app_database.db';
  static const int DATABASE_VERSION = 1;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();

    return _database;
  }

  // Initialize database.
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, DATABASE_NAME);

    return await openDatabase(path, version: DATABASE_VERSION, onCreate: this._onCreate, onConfigure: this._onConfigure);
  }

  // Create the tables.
  void _onCreate(Database database, int version) {
    PhotoDatabaseService.createTable(database, version);
  }

  // Configure the database.
  void _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  // Close database.
  Future close() async => _database!.close();

  // Photo.
  Future<List<PhotoModel>> getPhotos() async => await PhotoDatabaseService.getAll(_database!);
  Future<PhotoModel> insertPhoto(PhotoModel photo) async => await PhotoDatabaseService.insert(_database!, photo);
  Future<int> updatePhotoById(PhotoModel photo) async => await PhotoDatabaseService.update(_database!, photo);
  Future<int> deletePhotoById(int id) async => await PhotoDatabaseService.delete(_database!, id);
}