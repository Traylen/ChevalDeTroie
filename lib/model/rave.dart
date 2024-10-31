import 'package:chevaldetroie/model/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Rave {
  final String collection = "rave";
  Map<String, dynamic> data = <String, dynamic>{
    'theme': '',
    'picture': '',
    'date': '',
    'validate': false,
  };

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

  String? getId() {
    return data['_id']?.toString();
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

  Future<Rave> findById(String id) async {
    var currentObjectId = ObjectId.fromHexString(id);
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

  Future<void> insert() async {
    if (data.values.any((value) => value == '')) {
      throw ('Données incomplètes : tous les champs doivent être remplis avant l\'insertion');
    }
    await Database().add(collection, data);
  }
}
