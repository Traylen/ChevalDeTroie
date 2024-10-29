

import 'package:chevaldetroie/model/database.dart';

class Users {
  final String collection = "user";

  void add(Map<String, dynamic> data) {
    if(data.isEmpty) throw('Missing data');
      Database().add(collection, data);

  }
}