import 'package:bson/src/classes/object_id.dart';
import 'package:flutter/material.dart';
import 'package:chevaldetroie/model/horse.dart';
import 'package:chevaldetroie/model/users.dart';

class AddHorse extends StatefulWidget {
  final userId;
  const AddHorse({Key? key, required this.userId, required ObjectId ownerId})
      : super(key: key);

  @override
  _AddHorseState createState() => _AddHorseState();
}

class _AddHorseState extends State<AddHorse> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _robeController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _sexeController = TextEditingController();
  final TextEditingController _specialiteController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();

  Future<void> _addHorse() async {
    var userId = widget.userId;
    Users owner = await Users().findById(userId);

    Horse newHorse = Horse()
      ..setName(_nameController.text)
      ..setAge(int.tryParse(_ageController.text) ?? 0)
      ..setRobe(_robeController.text)
      ..setRace(_raceController.text)
      ..setSexe(_sexeController.text)
      ..setSpecialite(_specialiteController.text)
      ..setPhoto(_photoController.text)
      ..setOwner(owner);

    newHorse.insert();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Horse added successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Horse"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Horse Name"),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),
            TextField(
              controller: _robeController,
              decoration: const InputDecoration(labelText: "Robe"),
            ),
            TextField(
              controller: _raceController,
              decoration: const InputDecoration(labelText: "Race"),
            ),
            TextField(
              controller: _sexeController,
              decoration: const InputDecoration(labelText: "Sexe"),
            ),
            TextField(
              controller: _specialiteController,
              decoration: const InputDecoration(labelText: "Specialty"),
            ),
            TextField(
              controller: _photoController,
              decoration: const InputDecoration(labelText: "Photo URL"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addHorse,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              child: const Text(
                "Add Horse",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _robeController.dispose();
    _raceController.dispose();
    _sexeController.dispose();
    _specialiteController.dispose();
    _photoController.dispose();
    super.dispose();
  }
}
