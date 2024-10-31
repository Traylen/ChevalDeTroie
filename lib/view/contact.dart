import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
      return view(context);
  }

  Widget view(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
            return card(context);
        })
      ),
    );
  }

  Widget card(BuildContext context) {
      return Container(
            color: Colors.pink[50],
            // width: MediaQuery.of(context).size.width / 2,
            // height: MediaQuery.of(context).size.height / 2,
            child: const Card(
              child: Text('This is a card'),
            )
          );
  }

}