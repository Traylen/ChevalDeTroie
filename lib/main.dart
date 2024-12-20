import 'dart:developer' as developer;
import 'package:chevaldetroie/view/authentification/login.dart';
import 'package:chevaldetroie/view/home/homePage.dart';
import 'package:chevaldetroie/view/raveParty.dart';
import 'package:chevaldetroie/model/database.dart';
import 'package:chevaldetroie/model/roles.dart';
import 'package:chevaldetroie/model/users.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cheval De Troie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FormPage(),
    );
  }
}
