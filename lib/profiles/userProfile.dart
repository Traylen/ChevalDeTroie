import 'package:chevaldetroie/profiles/profileEdit.dart';
import 'package:flutter/material.dart';
import 'profileEdit.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        // Rendre le corps défilable
        child: Column(
          children: [
            const _TopPortion(), // Suppression de Expanded
            const SizedBox(
                height: 16), // Espace entre la partie bleue et la carte
            const _HorseCard(), // Ajout de la carte avec l'image
            const SizedBox(height: 16), // Espace avant la section des horaires
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Schedules",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'event',
                  elevation: 0,
                  backgroundColor: Colors.yellow,
                  label: const Text("Event"),
                ),
                const SizedBox(width: 16.0),
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'party',
                  elevation: 0,
                  backgroundColor: Colors.yellow,
                  label: const Text("Party"),
                ),
                const SizedBox(width: 16.0),
                FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'lesson',
                  elevation: 0,
                  backgroundColor: Colors.yellow,
                  label: const Text("Lesson"),
                ),
              ],
            ),
            const SizedBox(height: 16), // Espace en bas
          ],
        ),
      ),
    );
  }
}

class _TopPortion extends StatefulWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  State<_TopPortion> createState() => _TopPortionState();
}

class _TopPortionState extends State<_TopPortion> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 280,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xff0043ba), Color(0xff006df1)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        const Positioned(
          top: 40,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Rider",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.cake, color: Colors.white70, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "20 ans",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.phone,
                                  color: Colors.white70, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "+33 6 12 34 56 78",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.link, color: Colors.white70, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "Profile en ligne",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10, // Positionnement au bas du conteneur bleu
          left: MediaQuery.of(context).size.width * 0.35,
          right: MediaQuery.of(context).size.width * 0.35,
          child: Container(
            width: 140,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton.icon(
              onPressed: () {
                // page de modification`

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileEdit()),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              label: const Text(
                "Edit",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Classe pour la carte des chevaux
class _HorseCard extends StatelessWidget {
  const _HorseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage("https://ecurie-active.fr/"),
                )),
              )),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.10),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Column(
              children: [
                const Text(
                  "Mon/mes cheval/aux",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // acce page des chevaux
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Couleur du bouton
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Voir mes chevaux",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
