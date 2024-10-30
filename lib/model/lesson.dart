import 'package:chevaldetroie/model/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Lessons {
  final String collection = "Lessons";
  Map<String, dynamic> data = <String, dynamic>{
    'terrain': '',
    'type': '',
    'date': '',
    'time': '',
    'duree': '',
    'validate': '',
  };

  Lessons setTerrain(String terrain) {
    data.update('terrain', (value) => terrain);
    return this;
  }

  Lessons setType(String type) {
    data.update('type', (value) => type);
    return this;
  }

  Lessons setDate(String date) {
    data.update('date', (value) => date);
    return this;
  }

  Lessons setTime(String time) {
    data.update('time', (value) => time);
    return this;
  }

  Lessons setDuree(String duree) {
    data.update('duree', (value) => duree);
    return this;
  }

  Lessons setValidate(String validation) {
    data.update('validate', (value) => validation);
    return this;
  }

  String getId() {
    return data['_id'];
  }

  String getTerrain() {
    return data['terrain'];
  }

  String getType() {
    return data['type'];
  }

  String getDate() {
    return data['date'];
  }

  String getTime() {
    return data['time'];
  }

  String getDuree() {
    return data['duree'];
  }

  bool getValidate() {
    return data['validate'];
  }

  Future<Lessons> findById(id) async {
    var currentObjectId = id is String ? ObjectId.fromHexString(id) : id;
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, '_id', currentObjectId);
    data.addAll(list[0]);
    return this;
  }

  Future<Lessons> findFirstByField(String field, dynamic value) async {
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

  void insert() {
    if (data.isEmpty) throw ('Missing data');
    Database().add(collection, data);
  }
}
