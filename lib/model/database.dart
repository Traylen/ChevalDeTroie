import 'package:mongo_dart/mongo_dart.dart';

class Database {
  final Db db = Db('mongodb://10.0.2.2:27017/flutter');

  Future<void> add(String collection, Map<String, dynamic> data) async {
    await db.open();
    await db.collection(collection).insert(data);
    await db.close();
  }

  Future<void> update(String collection, ObjectId id, String name, String age,
      String phone) async {
    // var db = await Db.create(
    //     "mongodb://127.0.0.1:27017/chevaldetroie"); // Modifier si nécessaire
    await db.open();
    var coll = db.collection(collection);

    await coll.updateOne(where.id(id),
        modify.set("name", name).set("age", age).set("phone", phone));
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

  Future<List<Map<String, dynamic>>> findAll(collection) async {
    await db.open();
    var output =
        await db.collection(collection).find({"validate": "True"}).toList();
    await db.close();
    return output;
  }

  Future<void> updateOne(collection, id, participant, field) async {
    await db.open();
    var output = await db.collection(collection).updateOne(
        where.id(id),
        {
          '\$push': {field: participant}
        },
        upsert: true);
    await db.close();
  }

  DbCollection collection(String collection) {
    return db.collection(collection);
  }
}
