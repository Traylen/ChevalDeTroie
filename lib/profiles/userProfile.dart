import 'package:chevaldetroie/model/users.dart';
import 'package:flutter/material.dart';
import 'profileEdit.dart';
import 'horseManagement/myHorsesPage.dart';
import '../view/login.dart';

class Userprofile extends StatefulWidget {
  final test;
  const Userprofile({super.key, required this.test});
  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  Users? _user; // Nullable user to hold the fetched user data

  @override
  void initState() {
    super.initState();
    print(widget.test);
    _fetchUserData(); // Fetch user data when the widget initializes
  }

  Future<void> _fetchUserData() async {
    // Replace with the actual user ID you want to fetch
    final userId = widget.test;
    _user = await Users().findById(userId); // Fetch user by ID
    setState(() {}); // Update the UI with the fetched user data
  }

  void _logout() {
    // Logique de déconnexion
    // Vous pouvez également supprimer les données de session ou utiliser un package de gestion de l'état
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginPage()), // Remplacez par votre page de connexion
              FormPage()), // Remplacez par votre page de connexion
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      // Show a loading indicator while fetching data
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
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
        child: Column(
          children: [
            _TopPortion(user: _user!), // Pass the fetched user to _TopPortion
            const SizedBox(height: 16),
            _HorseCard(user: _user!),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  final Users user;

  const _TopPortion({Key? key, required this.user}) : super(key: key);

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
        Positioned(
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
                    backgroundImage: NetworkImage(user.getPhoto()),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.getName(),
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Rider",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.cake,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            "${user.getAge()} ans",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.phone,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            user.getPhone(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
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
        ),
        Positioned(
          bottom: 10,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileEdit(kiwi: user.getId())), // Pass the user ID
                );
              },
              icon: const Icon(Icons.edit, color: Colors.black),
              label: const Text("Edit",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }
}

// Classe pour la carte des chevaux
class _HorseCard extends StatelessWidget {
  final Users user;
  const _HorseCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://ecurie-active.fr/"),
                  fit: BoxFit.cover,
                ),
              ),
              height: 200,
            ),
          ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HorsesPage(
                                user: user,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Voir les chevaux",
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
