import 'package:mongo_dart/mongo_dart.dart';

class Database {
  //Db db = Db('mongodb://10.0.2.2:27017/flutter');

  Db db = Db('mongodb://127.0.0.1:27017/flutter');

  void add(String collection, Map<String, dynamic> data) async {
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

    // Mise à jour des données par ID
    await coll.updateOne(where.id(id),
        modify.set("name", name).set("age", age).set("phone", phone)
        // .set("age", data['age'])
        // .set("phone", data['phone'])
        // .set("email", data['email'])
        // .set("role", data['role'])
        // .set("photo", data['photo'])
        // .set("ffe_url", data['ffe_url'])
        // .set("dp", data['dp']),
        );
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

  // update One
  // Future<void> updateOne(collection, id, field) async {
  //   await db.open();
  //   var output =
  //       await db.collection(collection).updateOne();
  //   await db.close();
  // }

  DbCollection collection(String collection) {
    return db.collection(collection);
  }
}
