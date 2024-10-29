import 'package:chevaldetroie/view/concour.dart';
import 'package:chevaldetroie/view/horseLesson.dart';
import 'package:chevaldetroie/view/raveParty.dart';
import 'package:flutter/material.dart';
import 'View/home/homePage.dart';
import 'View/authentification/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cheval De Troie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FormPage(),
    );
  }
}
