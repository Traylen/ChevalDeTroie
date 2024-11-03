import 'dart:ffi';

import 'package:chevaldetroie/model/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Rave {
  final String collection = "rave";
  Map<String, dynamic> data = <String, dynamic>{
    'theme': '',
    'picture': '',
    'date': '',
    'validate': false,
    'participants': [],
    'commentaire': []
  };

  Future<void> edtiRave(id, participant, field) async {
    await Database().updateOne(collection, id, participant, field);
  }

  Rave setTheme(String theme) {
    data.update('theme', (value) => theme, ifAbsent: () => theme);
    return this;
  }

  Rave setPicture(String picture) {
    data.update('picture', (value) => picture, ifAbsent: () => picture);
    return this;
  }

  Rave setDate(String date) {
    data.update('date', (value) => date, ifAbsent: () => date);
    return this;
  }

  Rave setValidate(bool validation) {
    data.update('validate', (value) => validation, ifAbsent: () => validation);
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

    if (list.isNotEmpty) {
      data.addAll(list[0]);
    }
    return this;
  }

  Future<Rave> findFirstByField(String field, dynamic value) async {
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, field, value);

    if (list.isNotEmpty) {
      data.addAll(list[0]);
    }
    return this;
  }

  Future<List<Map<String, dynamic>>> findAllByField(
      String field, dynamic value) async {
    return await Database().findByField(collection, field, value);
  }

  Future<void> update() async {
    if (data.containsKey('_id') && data['_id'] != null) {
      var objectId = data['_id'] as ObjectId;
      await Database().update(collection, objectId, data);
    } else {
      throw Exception(
          "Impossible de mettre à jour : l'identifiant est manquant.");
    }
  }

  Future<List<Rave>> findUnvalidatedRaves() async {
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, 'validate', false);
    return list.map((data) {
      Rave rave = Rave();
      rave.data = data;
      return rave;
    }).toList();
  }

  Future<void> insert() async {
    if (data.values.any((value) => value == '')) {
      throw ('Données incomplètes : tous les champs doivent être remplis avant l\'insertion');
    }
    await Database().add(collection, data);
  }
}
