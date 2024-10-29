import 'package:chevaldetroie/view/auth/login.dart';
import 'package:chevaldetroie/view/auth/register.dart';
import 'package:flutter/material.dart';

import 'view/home/homepage.dart';

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
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/register': (context) => Register(),
        '/login': (context) => Login(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
