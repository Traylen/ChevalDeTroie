

import 'package:chevaldetroie/model/database.dart';
import 'package:chevaldetroie/model/roles.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Users {
  final String collection = "user";
  Map<String, dynamic> data = <String, dynamic>
  {
  'name': '',
  'email': '',
  'password': '',
  'role': '',
  'age': '',
  'phone': '',
  'photo': '',
  'ffe_rul': '',
  'dp': '',
  };

  Users setName(name)
  {
    data.update('name', (value) => name);
    return this;
  }

  Users setEmail(email)
  {
    data.update('email', (value) => email);
    return this;
  }

  Users setPassword(password)
  {
    data.update('password', (value) => password);
    return this;
  }

  Users setRole(Roles role)
  {
    // data.update(<String, dynamic>{'': }.entries);
    return this;
  }

  Users setAge(age)
  {
    data.update("age", (value) => age);
    return this;
  }

  Users setPhone(phone)
  {
    data.update('phone', (value) => phone);
    return this;
  }

  Users setPhoto(photo)
  {
    data.update("photo", (value) => photo);
    return this;
  }

  Users setFfeUrl(ffeUrl)
  {
    data.update("ffe_url", (value) => ffeUrl);
    return this;
  }

  Users setDP(DP)
  {
    data.update("dp", (value) => DP);
    return this;
  }

  Future<Map<String, dynamic>> findById(id) async {
    return await Database().findById(collection, '_id', ObjectId.fromHexString(id));
  }

  void insert() {
    if(data.isEmpty) throw('Missing data');
      Database().add(collection, data);
  }
}