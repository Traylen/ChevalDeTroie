import 'package:chevaldetroie/model/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Roles {
  final String collection = 'role';

  Map<String, dynamic> data = <String, dynamic>{
    'name': '',
  };

  Roles setName(name) {
    data.update('name', (value) => name);
    return this;
  }

  ObjectId getId() {
    return data['_id'];
  }

  Future<Roles> findById(id) async {
    var currentObjectId = id is String ? ObjectId.fromHexString(id) : id;
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, '_id', currentObjectId);
    data.addAll(list[0]);
    return this;
  }

  Future<Roles> findFirstByField(field, value) async {
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, field, value);
    data.addAll(list[0]);
    return this;
  }

  Future<List<Map<String, dynamic>>> findAllByField(field, value) async {
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, field, value);
    return list;
  }

  void insert() {
    if (data.isEmpty) throw ('Missing data');
    Database().add(collection, data);
  }
}
