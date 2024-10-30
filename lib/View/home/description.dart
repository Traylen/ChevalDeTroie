import 'package:chevaldetroie/model/rave.dart';
import 'package:chevaldetroie/model/users.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Description extends StatefulWidget {
  final id;
  final id_user;
  const Description({super.key, required this.id, required this.id_user});

  @override
  State<Description> createState() => _DescriptionState();
}

Rave rave = Rave();
Users user = Users();
final TextEditingController _messageController = TextEditingController();

class _DescriptionState extends State<Description> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      backgroundColor: const Color(0xffe3eaf1),
      body: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  rave.edtiRave(widget.id, widget.id_user, "participants");
                });
              },
              child: const Text("Participer")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: const Text("Back")),
          FutureBuilder(
              future: rave.findById(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  Rave data = snapshot.data!;
                  var participants = data.getParticipants() ?? "none";
                  return SizedBox(
                    height: 300,
                    width: 500,
                    child: ListView.builder(
                        itemCount: data.getLengthParticipants(),
                        itemBuilder: (context, index) {
                          return Text(participants[index] ??
                              "Aucun Particpants à ce tournoi");
                        }),
                  );
                }
              }),
          const Text("Le Super Chat"),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _messageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez remplir ce champ';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                        minimumSize:
                            WidgetStateProperty.all(const Size(380, 45)),
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 44)),
                      ),
                      onPressed: () {
                        setState(() {
                          rave.edtiRave(widget.id, _messageController.text,
                              "commentaire");
                        });
                      },
                      child: const Text('Envoyer')),
                  FutureBuilder(
                      future: rave.findById(widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          Rave data = snapshot.data!;
                          return SizedBox(
                            height: 300,
                            width: 500,
                            child: ListView.builder(
                              itemCount: data.getLengthCommentaire(),
                              itemBuilder: (context, index) {
                                return Text(data.getCommentaire()[index] ??
                                    "Aucun commentaire à ce tournoi");
                              },
                            ),
                          );
                        }
                      })
                ],
              ))
        ],
      )),
    );
  }
}
