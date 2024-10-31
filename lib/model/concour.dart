import 'package:chevaldetroie/model/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Competition {
  final String collection = "Competition";
  Map<String, dynamic> data = <String, dynamic>{
    'name': '',
    'adresse': '',
    'pp': '',
    'date': '',
    'participants': []
  };

  Competition setName(String name) {
    data.update('name', (value) => name);
    return this;
  }

  Competition setAdresse(String adresse) {
    data.update('adresse', (value) => adresse);
    return this;
  }

  Competition setPP(String pp) {
    data.update('pp', (value) => pp);
    return this;
  }

  Competition setDate(String date) {
    data.update('date', (value) => date);
    return this;
  }

  String getId() {
    return data['_id'];
  }

  String getName() {
    return data['name'];
  }

  String getAdresse() {
    return data['adresse'];
  }

  String getPP() {
    return data['pp'];
  }

  String getDate() {
    return data['date'];
  }

  getParticipants() {
    return data['participants'];
  }

  int getLengthParticipants() {
    return data['participants'].length;
  }

  Future<Competition> findById(id) async {
    var currentObjectId = id is String ? ObjectId.fromHexString(id) : id;
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, '_id', currentObjectId);
    data.addAll(list[0]);
    return this;
  }

  Future<Competition> findFirstByField(String field, dynamic value) async {
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
