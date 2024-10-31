import 'package:chevaldetroie/model/horse.dart';
import 'package:chevaldetroie/model/users.dart';
import 'package:flutter/material.dart';

class HorseNRider extends StatefulWidget {
  const HorseNRider({super.key});

  @override
  State<HorseNRider> createState() => _HorseNRiderState();

}

class _HorseNRiderState extends State<HorseNRider> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();

    Future<List<Map<String, dynamic>>>.delayed(const Duration(seconds: 1), () => Users().findAllByField('dp', '1').then((value) {
      setState(() {
        users = value;
      });
      return value;
    }));

    Future<List<Map<String, dynamic>>>.delayed(const Duration(seconds: 1), () => Horse().findAll().then((value) {
      setState(() {
        users.addAll(value);
      });
      return value;
    }));
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(users.length, (index) {
              return Center(
                child: Text(users[index]['name'])
              ); 
            }),
            )
        ],
      ),
    );
  }
}