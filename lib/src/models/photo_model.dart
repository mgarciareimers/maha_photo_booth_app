import 'dart:convert';
import 'dart:typed_data';

// Constants.
import 'package:maha_photo_booth_app/src/commons/constants/fields.dart';

PhotoModel photoModelFromJson(String str) => PhotoModel.fromJson(json.decode(str));

String photoModelToJson(PhotoModel data) => json.encode(data.toJson());

class PhotoModel {
  PhotoModel({
    this.id,
    this.name,
    this.photo,
    this.date,
  });

  int? id;
  String? name;
  Uint8List? photo;
  DateTime? date;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
    id: json[Fields.ID],
    name: json[Fields.NAME],
    photo: json[Fields.PHOTO],
    date: json[Fields.DATE],
  );

  Map<String, dynamic> toJson() => {
    Fields.ID: this.id,
    Fields.NAME: this.name,
    Fields.PHOTO: this.photo,
    Fields.DATE: this.date.toString(),
  };
}
