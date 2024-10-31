import 'package:chevaldetroie/model/concour.dart';
import 'package:chevaldetroie/model/lesson.dart';
import 'package:chevaldetroie/model/rave.dart';
import 'package:chevaldetroie/model/users.dart';
import 'package:chevaldetroie/profiles/userProfile.dart';
import 'package:chevaldetroie/view/home/calendar.dart';
import 'package:chevaldetroie/view/home/createForm.dart';
import 'package:chevaldetroie/view/home/description.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  final userId;
  // dsl mais trop flm
  final username;
  const HomePage({super.key, required this.userId, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  late final List routes = [
    Home2(
      userId: widget.userId,
      username: widget.username,
    ),
    const Calendar(),
    const ChooseFormPage(),
    const Userprofile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3eaf1),
      body: routes[_index],
      bottomNavigationBar: GNav(
          selectedIndex: _index,
          backgroundColor: const Color(0xfff2f4f6),
          activeColor: const Color(0xFF080808),
          color: const Color(0xffa3a5a9),
          onTabChange: (index) => setState(() => _index = index),
          gap: 7,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(icon: Icons.calendar_month, text: "Calendar"),
            GButton(
              icon: Icons.add,
              text: "Form",
            ),
            GButton(
              icon: Icons.settings,
              text: "Settings",
            ),
          ]),
    );
  }
}

class Home2 extends StatefulWidget {
  final userId;
  final username;

  const Home2({super.key, required this.userId, required this.username});

  @override
  State<Home2> createState() => _Home2State();
}

Lessons lessons = Lessons();
Rave raveParty = Rave();
Competition competition = Competition();
Users user = Users();
// var test = lessons.getAll().then((result) => print(result));

var allFilters = lessons.getAll();
var allFilte = "lessons";
void filter(filters, stringFilter) {
  allFilters = filters;
  allFilte = stringFilter;
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(), // a voir
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenue",
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          "Sur",
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          "ChevalDeTroie",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    FutureBuilder(
                        future: user.findById(widget.userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            Users data = snapshot.data!;
                            return Row(
                              children: [
                                Text(data.getName()),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://i.pinimg.com/236x/7f/43/03/7f4303ad3716465ed058ed44a6f64369.jpg"),
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // TextButton(onPressed: () {}, child: const Text("")),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          filter(lessons.getAll(), "lessons");
                        });
                      },
                      child: const Text("Lesson")),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          filter(raveParty.getAll(), "rave");
                        });
                      },
                      child: const Text("RaveParty")),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          filter(competition.getAll(), "competition");
                        });
                      },
                      child: const Text("Competition")),
                ],
              ),
            ),
            FutureBuilder(
                future: allFilters,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<Map<String, dynamic>> data = snapshot.data!;
                    if (data.isEmpty) {
                      return const Text("Mange un Kiwi et reviens Demain");
                    }
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => {
                              setState(() {
                                allFilte == "rave"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Description(
                                                  id: data[index]["_id"],
                                                  id_user: widget.username,
                                                  type: "rave",
                                                )),
                                      )
                                    : allFilte == "competition"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Description(
                                                      id: data[index]["_id"],
                                                      id_user: widget.username,
                                                      type: "competition",
                                                    )),
                                          )
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Description(
                                                      id: data[index]["_id"],
                                                      id_user: widget.username,
                                                      type: "lessons",
                                                    )),
                                          );
                              })
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(children: [
                                Container(
                                  height: 175,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(data[index]
                                              ["picture"] ??
                                          "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 1,
                                    width: 379,
                                    child: Container(
                                      height: 175,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomRight,
                                              colors: [
                                                Colors.black.withOpacity(.9),
                                                Colors.black.withOpacity(.6),
                                                Colors.black.withOpacity(.4),
                                                Colors.black.withOpacity(.2),
                                                Colors.black.withOpacity(.1)
                                              ])),
                                    )),
                                Positioned(
                                    bottom: 15,
                                    left: 12,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            data[index]["type"] ??
                                                data[index]["theme"] ??
                                                data[index]["name"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24)),
                                        Text(data[index]["terrain"] ?? "",
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        Row(
                                          children: [
                                            Text("Date: " + data[index]["date"],
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ))
                              ]),
                            ),
                          );
                        });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
