import 'dart:ffi';

import 'package:chevaldetroie/model/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Rave {
  final String collection = "rave";
  Map<String, dynamic> data = <String, dynamic>{
    'theme': '',
    'picture': '',
    'date': '',
    'validate': '',
    'participants': [],
    'commentaire': []
  };

  Rave setTheme(String theme) {
    data.update('theme', (value) => theme);
    return this;
  }

  Rave setPicture(String picture) {
    data.update('picture', (value) => picture);
    return this;
  }

  Rave setDate(String date) {
    data.update('date', (value) => date);
    return this;
  }

  Rave setValidate(String validation) {
    data.update('validate', (value) => validation);
    return this;
  }

  ObjectId getId() {
    return data['_id'];
  }

  String getTheme() {
    return data['theme'];
  }

  String getPicture() {
    return data['picture'];
  }

  String getDate() {
    return data['date'];
  }

  bool getValidate() {
    return data['validate'];
  }

  getParticipants() {
    return data['participants'];
  }

  int getLengthParticipants() {
    return data['participants'].length;
  }

  getCommentaire() {
    return data['commentaire'];
  }

  int getLengthCommentaire() {
    return data['commentaire'].length;
  }

  Future<Rave> findById(id) async {
    var currentObjectId = id is String ? ObjectId.fromHexString(id) : id;
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, '_id', currentObjectId);
    data.addAll(list[0]);
    return this;
  }

  Future<Rave> findFirstByField(String field, dynamic value) async {
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, field, value);
    data.addAll(list[0]);
    return this;
  }

  Future<List<Map<String, dynamic>>> findAllByField(
      String field, dynamic value) async {
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, field, value);
    return list;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    List<Map<String, dynamic>> list = await Database().findAll(collection);
    return list;
  }

  Future<void> edtiRave(id, participant, field) async {
    await Database().updateOne(collection, id, participant, field);
  }

  void insert() {
    if (data.isEmpty) throw ('Missing data');
    Database().add(collection, data);
  }
}
