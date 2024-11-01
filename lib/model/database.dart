import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Db db = Db('mongodb://10.0.2.2:27017/flutter');

  void add(String collection, Map<String, dynamic> data) async {
    await db.open();
    await db.collection(collection).insert(data);
    await db.close();
  }

  Future<List<Map<String, dynamic>>> findByField(collection, field, value,
      {rating = 10}) async {
    await db.open();
    var output =
        await db.collection(collection).find(where.eq(field, value)).toList();
    await db.close();
    return output;
  }

  // trust me (kiwi)
  Future<List<Map<String, dynamic>>> findAll(collection) async {
    await db.open();
    var output = await db.collection(collection).find().toList();
    await db.close();
    return output;
  }

  DbCollection collection(String collection) {
    return db.collection(collection);
  }
}
