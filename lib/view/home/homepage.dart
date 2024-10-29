import 'package:chevaldetroie/view/home/description.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3eaf1),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(), // a voir
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text("John Doe"),
                      ElevatedButton(onPressed: () {
                          Navigator.pushNamed(context, '/register');
                      }, 
                      child: const CircleAvatar(
                          backgroundImage: NetworkImage(""),
                        )
                      )
                    ]),
              ),
              // const SearchBar(
              //   leading: Icon(Icons.search),
              // ),
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
                                          style:
                                              TextStyle(color: Colors.white)),
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
      ),
      bottomNavigationBar: const GNav(
          backgroundColor: Color(0xfff2f4f6),
          activeColor: Color(0xFF080808),
          color: Color(0xffa3a5a9),
          gap: 7,
          // tabBackgroundColor: Colors.yellow,
          tabs: [
            GButton(icon: Icons.home),
            GButton(icon: Icons.notifications),
            GButton(icon: Icons.add),
            GButton(icon: Icons.settings),
          ]),
    );
  }
}
