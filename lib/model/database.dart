import 'package:mongo_dart/mongo_dart.dart';

class Database {
  final Db db = Db('mongodb://10.0.2.2:27017/flutter');

  Future<void> add(String collection, Map<String, dynamic> data) async {
    await db.open();
    await db.collection(collection).insert(data);
    await db.close();
  }

  Future<List<Map<String, dynamic>>> findByField(
      String collection, String field, dynamic value,
      {int rating = 10}) async {
    await db.open();
    var output =
        await db.collection(collection).find(where.eq(field, value)).toList();
    await db.close();
    return output;
  }

  Future<void> update(
      String collection, ObjectId id, Map<String, dynamic> data) async {
    await db.open();
    await db.collection(collection).updateOne(
          where.id(id),
          modify.set('validate', data['validate']),
        );
    await db.close();
  }

  DbCollection collection(String collectionName) {
    return db.collection(collectionName);
  }
}
