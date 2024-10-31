import 'package:flutter/material.dart';
import 'package:chevaldetroie/model/horse.dart';
import 'package:chevaldetroie/model/users.dart';
import 'addHorse.dart';
import 'editHorse.dart';

class HorsesPage extends StatefulWidget {
  final Users user;

  const HorsesPage({super.key, required this.user});

  @override
  _HorsesPageState createState() => _HorsesPageState();
}

class _HorsesPageState extends State<HorsesPage> {
  List<Horse> allHorses = [];

  @override
  void initState() {
    super.initState();
    _fetchHorses();
  }

  Future<void> _fetchHorses() async {
    // Fetch all horses from the database
    List<Map<String, dynamic>> horsesData = await Horse().findAll();
    allHorses = horsesData.map((data) => Horse()..data = data).toList();
    setState(() {});
  }

  Future<void> _updateDpHorse(String horseId) async {
    widget.user.setDP(horseId);
    widget.user.insert(); // Save changes to the database
    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Horses', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (allHorses.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: allHorses.map((horse) {
                  return _HorseCard(
                    horse: horse,
                    onTakeAsDp: () => _updateDpHorse(horse.getId() as String),
                    user: widget.user,
                  );
                }).toList(),
              ),
            const SizedBox(height: 20),
            // Floating action button to add a new horse
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddHorse(
                        userId: widget.user.getId(), // Pass current user ID
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Horse'),
                backgroundColor: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HorseCard extends StatelessWidget {
  final Horse horse;
  final VoidCallback onTakeAsDp;
  final Users user;

  const _HorseCard({
    Key? key,
    required this.horse,
    required this.onTakeAsDp,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOwner = horse.getOwner() == user.getId();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Horse photo
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              //Uncomment the below line and provide a proper URL for the image
              child: Image.network(
                horse.getPhoto(),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Horse details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    horse.getName(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Age: ${horse.getAge()}'),
                  Text('Breed: ${horse.getRace()}'),
                  Text('Sex: ${horse.getSexe()}'),
                  Text('Specialty: ${horse.getSpecialite()}'),
                ],
              ),
            ),
            // Button to set this horse as DP or edit
            isOwner
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HorseEditPage(horse: horse),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.yellow, // Different color for edit
                    ),
                    child: const Text(
                      'Edit Horse',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : ElevatedButton(
                    onPressed: onTakeAsDp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    child: const Text(
                      'Take as my DP',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
