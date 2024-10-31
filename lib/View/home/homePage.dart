//import 'package:chevaldetroie/model/courses.dart';
import 'package:chevaldetroie/profiles/userProfile.dart';
import 'package:chevaldetroie/view/home/calendar.dart';
import 'package:chevaldetroie/view/home/createForm.dart';
import 'package:chevaldetroie/view/home/description.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  late final List routes = [
    const Home2(),
    const Calendar(),
    const ChooseFormPage(),
    const Userprofile(
      test: null,
    ),
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
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //children: <Widget>[
                //   TextButton(
                //       // onPressed: () async {
                //       //   Courses users = Courses();
                //       //   await users.getAllCourses();
                //       // },
                //       child: const Text("Test")),
                //   const Text("John Doe"),
                //   const CircleAvatar(
                //     backgroundImage: NetworkImage(""),
                //   )
                // ]
              ),
            ),
            // const SearchBar(
            //   leading: Icon(Icons.search),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // TextButton(onPressed: () {}, child: const Text("")),
                  TextButton(onPressed: () {}, child: const Text("Lesson")),
                  TextButton(onPressed: () {}, child: const Text("RaveParty")),
                  TextButton(
                      onPressed: () {}, child: const Text("Competition")),
                  TextButton(
                      onPressed: () {}, child: const Text("Cavalier/Cheval"))
                ],
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Description()),
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
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://equipedia.ifce.fr/fileadmin/_processed_/d/0/csm_ecurie-faitage-ventile_fa970cb09c.jpg"),
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
                                  borderRadius: BorderRadius.circular(12),
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
                        const Positioned(
                            bottom: 15,
                            left: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title Exemple",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24)),
                                Text("San Francisco, USA",
                                    style: TextStyle(color: Colors.white)),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://static.vecteezy.com/system/resources/previews/005/129/844/non_2x/profile-user-icon-isolated-on-white-background-eps10-free-vector.jpg"),
                                      ),
                                    ),
                                    Text("Randal Ford",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ],
                            ))
                      ]),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
