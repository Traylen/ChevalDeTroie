import 'package:chevaldetroie/view/concour.dart';
import 'package:chevaldetroie/view/horseLesson.dart';
import 'package:chevaldetroie/view/raveParty.dart';
import 'package:flutter/material.dart';

class ChooseFormPage extends StatefulWidget {
  const ChooseFormPage({super.key});

  @override
  State<ChooseFormPage> createState() => _ChooseFormPageState();
}

class _ChooseFormPageState extends State<ChooseFormPage> {
  List<String> title = [
    "Concour",
    "Cours d'équitation",
    "Soirée",
  ];
  List form = [
    const Concour(),
    //Horselesson(),
    Raveparty(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe3eaf1),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Widget>.generate(
              3,
              (int index) => GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => form[index]));
                },
                child: Card(
                  child: SizedBox(
                      width: 400,
                      height: 150,
                      child: Center(
                          child: Text(
                        title[index],
                        style: const TextStyle(fontSize: 24),
                      ))),
                ),
              ),
            ),
          ),
        )));
  }
}
