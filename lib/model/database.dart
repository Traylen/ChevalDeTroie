import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Db db = Db('mongodb://127.0.0.1:27017/flutter');

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

  DbCollection collection(String collection) {
    return db.collection(collection);
  }
}
