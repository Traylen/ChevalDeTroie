import 'package:chevaldetroie/model/concour.dart';
import 'package:chevaldetroie/model/lesson.dart';
import 'package:chevaldetroie/model/rave.dart';
import 'package:chevaldetroie/model/users.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Description extends StatefulWidget {
  final id;
  final id_user;
  final type;
  final data;
  const Description(
      {super.key,
      required this.id,
      required this.id_user,
      required this.type,
      this.data});

  @override
  State<Description> createState() => _DescriptionState();
}

Rave rave = Rave();
Competition competition = Competition();
Lessons lessons = Lessons();
Users user = Users();
final TextEditingController _messageController = TextEditingController();

class _DescriptionState extends State<Description> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3eaf1),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (widget.type == "rave") {
                          rave.edtiRave(
                              widget.id, widget.id_user, "participants");
                        } else if (widget.type == "competition") {
                          // ajouter un ici la request
                          competition.edtiRave(
                              widget.id, widget.id_user, "participants");
                        } else {
                          lessons.edtiRave(
                              widget.id, widget.id_user, "participants");
                        }
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
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Personne participants au tournoi",
                style: TextStyle(fontSize: 18),
              ),
            ),
            FutureBuilder(
                future: widget.type == "rave"
                    ? rave.findById(widget.id)
                    : widget.type == "competition"
                        ? competition.findById(widget.id)
                        : lessons.findById(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    dynamic data;
                    if (widget.type == "rave") {
                      data = snapshot.data! as Rave;
                    } else if (widget.type == "competition") {
                      data = snapshot.data! as Competition;
                    } else {
                      data = snapshot.data! as Lessons;
                    }
                    var participants = data.getParticipants() ?? "none";
                    return SizedBox(
                      height: 300,
                      width: 500,
                      child: ListView.builder(
                          itemCount: data.getLengthParticipants(),
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(participants[index] ??
                                    "Aucun Particpants à ce tournoi"),
                              ),
                            );
                          }),
                    );
                  }
                }),
            (widget.type == "rave"
                ? Form(
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
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
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
                                rave.edtiRave(widget.id,
                                    _messageController.text, "commentaire");
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
                                      return Text(
                                          data.getCommentaire()[index] ??
                                              "Aucun commentaire à ce tournoi");
                                    },
                                  ),
                                );
                              }
                            })
                      ],
                    ))
                : const Text('')),
          ],
        ),
      )),
    );
  }
}
