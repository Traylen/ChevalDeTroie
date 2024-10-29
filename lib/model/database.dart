import 'package:mongo_dart/mongo_dart.dart';

class Database {

Db db = Db('mongodb://10.0.2.2:27017/flutter');

void add(String collection, Map<String, dynamic> data) async {
  await db.open();
    await db.collection(collection).insert(data);
  await db.close();
}

}
