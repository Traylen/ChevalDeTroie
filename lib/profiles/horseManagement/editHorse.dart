import 'package:flutter/material.dart';
import 'package:chevaldetroie/model/horse.dart';

class HorseEditPage extends StatefulWidget {
  final Horse horse;

  const HorseEditPage({Key? key, required this.horse}) : super(key: key);

  @override
  _HorseEditPageState createState() => _HorseEditPageState();
}

class _HorseEditPageState extends State<HorseEditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _robeController;
  late TextEditingController _raceController;
  late TextEditingController _sexeController;
  late TextEditingController _specialiteController;
  late TextEditingController _photoController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.horse.getName());
    _ageController =
        TextEditingController(text: widget.horse.getAge().toString());
    _robeController = TextEditingController(text: widget.horse.getRobe());
    _raceController =
        TextEditingController(text: widget.horse.getRace().toString());
    _sexeController = TextEditingController(text: widget.horse.getSexe());
    _specialiteController =
        TextEditingController(text: widget.horse.getSpecialite());
    _photoController = TextEditingController(text: widget.horse.getPhoto());
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

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      widget.horse
          .setName(_nameController.text)
          .setAge(int.parse(_ageController.text))
          .setRobe(_robeController.text)
          .setRace(_raceController.text)
          .setSexe(_sexeController.text)
          .setSpecialite(_specialiteController.text)
          .setPhoto(_photoController.text);

      // Save to the database (assuming Horse has an update method)
      await widget.horse.update();

      Navigator.pop(context, widget.horse); // Return to the previous page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Horse"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the horse's name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the horse's age";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid number for age";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _robeController,
                decoration: const InputDecoration(labelText: "Robe"),
              ),
              TextFormField(
                controller: _raceController,
                decoration: const InputDecoration(labelText: "Race"),
              ),
              TextFormField(
                controller: _sexeController,
                decoration: const InputDecoration(labelText: "Sex"),
              ),
              TextFormField(
                controller: _specialiteController,
                decoration: const InputDecoration(labelText: "Specialty"),
              ),
              TextFormField(
                controller: _photoController,
                decoration: const InputDecoration(labelText: "Photo URL"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
