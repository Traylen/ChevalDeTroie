import 'dart:ffi';

import 'package:chevaldetroie/model/database.dart';
import 'package:chevaldetroie/model/roles.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Users {
  final String collection = "user";
  Map<String, dynamic> data = <String, dynamic>{
    'id': '',
    'name': '',
    'email': '',
    'password': '',
    'role': '',
    'age': '',
    'phone': '',
    'photo': '',
    'ffe_url': '',
    'dp': '',
  };

  Users setName(name) {
    data.update('name', (value) => name);
    return this;
  }

  Users setEmail(email) {
    data.update('email', (value) => email);
    return this;
  }

  Users setPassword(password) {
    data.update('password', (value) => password);
    return this;
  }

  Users setRole(Roles role) {
    data.update('role', (value) => role.getId());
    return this;
  }

  Users setAge(int age) {
    data.update("age", (value) => age);
    return this;
  }

  Users setPhone(phone) {
    data.update('phone', (value) => phone);
    return this;
  }

  Users setPhoto(photo) {
    data.update("photo", (value) => photo);
    return this;
  }

  Users setFfeUrl(ffeUrl) {
    data.update("ffe_url", (value) => ffeUrl);
    return this;
  }

  Users setDP(DP) {
    data.update("dp", (value) => DP);
    return this;
  }

  ObjectId getId() {
    return data['_id'];
  }

  String getName() {
    return data['name'];
  }

  String getEmail() {
    return data['email'];
  }

  String getPassword() {
    return data['password'];
  }

  Roles getRole() {
    return data[''];
  }

  String getAge() {
    return data['age'];
  }

  String getPhone() {
    return data['phone'];
  }

  String getPhoto() {
    return data['photo'];
  }

  String getFfeUrl() {
    return data['ffe_url'];
  }

  String getDP() {
    return data['dp'];
  }

  Future<Users> findById(id) async {
    var currentObjectId = id is String ? ObjectId.fromHexString(id) : id;
    List<Map<String, dynamic>> list =
        await Database().findByField(collection, '_id', currentObjectId);
    data.addAll(list[0]);
    return this;
  }

  Future<Users> findFirstByField(field, value) async {
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
