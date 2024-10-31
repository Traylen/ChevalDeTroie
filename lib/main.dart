import 'dart:developer' as developer;

import 'package:chevaldetroie/model/rave.dart';
import 'package:chevaldetroie/view/admin.dart';
import 'package:chevaldetroie/view/concour.dart';
import 'package:chevaldetroie/view/horseLesson.dart';
import 'package:chevaldetroie/view/authentification/login.dart';
import 'package:chevaldetroie/view/login.dart';
import 'package:chevaldetroie/view/raveParty.dart';
import 'package:chevaldetroie/view/register.dart';
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
        home: RaveValidationPage(
          raveId: '6723417e64dd2aa794000000',
        ));
  }
}
