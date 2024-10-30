import 'package:chevaldetroie/model/database.dart';
import 'package:chevaldetroie/model/users.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Horse {
  final String collection = "horse";
  Map<String, dynamic> data = <String, dynamic>
  {
  'name': '',
  'photo': '',
  'age': '',
  'robe': '',
  'race': '',
  'sexe': '',
  'specialite': '',
  'owner': '',
  };

  Horse setName(name)
  {
    data.update('name', (value) => name);
    return this;
  }

  Horse setRobe(robe)
  {
    data.update('robe', (value) => robe);
    return this;
  }

  Horse setRace(race)
  {
    data.update('race', (value) => race);
    return this;
  }

  Horse setSexe(sexe)
  {
    data.update('sexe', (value) => sexe);
    return this;
  }

  Horse setAge(int age)
  {
    data.update("age", (value) => age);
    return this;
  }

  Horse setSpecialite(specialite)
  {
    data.update('specialite', (value) => specialite);
    return this;
  }

  Horse setPhoto(photo)
  {
    data.update("photo", (value) => photo);
    return this;
  }

  Horse setOwner(Users user)
  {
    data.update("owner", (value) => user.getId());
    return this;
  }

    String getId(){
    return data['_id'];
  }

  String getName(){
    return data['name'];
  }

  String getAge(){
    return data['age'];
  }

  String getRobe(){
    return data['robe'];
  }
  Future<Users> getOwner() async {
    return await Users().findById(data['owner']);
  }
  int getRace(){
    return data['race'];
  }
  String getSpecialite(){
    return data['specialite'];
  }
  String getPhoto(){
    return data['photo'];
  }
  String getSexe(){
    return data['sexe'];
  }


  Future<Horse> findById(id) async {
    var currentObjectId = id is String ? ObjectId.fromHexString(id): id;
    List<Map<String, dynamic>> list = await Database().findByField(collection, '_id', currentObjectId);
    data.addAll(list[0]);
    return this;
  }

  Future<Horse> findFirstByField(field, value) async {
    List<Map<String, dynamic>> list = await Database().findByField(collection, field, value);
    data.addAll(list[0]);
    return this;
  }

  Future<List<Map<String, dynamic>>> findAllByField(field, value) async {
    List<Map<String, dynamic>> list = await Database().findByField(collection, field, value);
    return list;
  }

  void insert() {
    if(data.isEmpty) throw('Missing data');
      Database().add(collection, data);
  }
}