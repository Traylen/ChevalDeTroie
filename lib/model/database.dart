import 'package:mongo_dart/mongo_dart.dart';

class Database {

Db db = Db('mongodb://10.0.2.2:27017/flutter');

void add(String collection, Map<String, dynamic> data) async {
  await db.open();
    await db.collection(collection).insert(data);
  await db.close();
}

Future<Map<String, dynamic>> findById(collection, field, ObjectId value, {rating = 10}) async {
  await db.open();
  var output = await db.collection(collection).find(where.eq(field, value)).first;
  await db.close();
  return output;
}

DbCollection collection(String collection){
  return db.collection(collection);
}

}
