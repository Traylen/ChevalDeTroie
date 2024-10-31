import 'package:flutter/material.dart';
import 'package:chevaldetroie/model/database.dart';
import 'package:chevaldetroie/model/users.dart';

class ProfileEdit extends StatefulWidget {
  final kiwi; // Pass the user ID to the profile edit page
  const ProfileEdit({super.key, required this.kiwi});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  //Load user data from the database

  Future<void> _loadUserData() async {
    Users user = await Users().findById(widget.kiwi);
    _nameController.text = user.getName();
    _ageController.text = user.getAge().toString();
    _phoneController.text = user.getPhone();
  }

  // Update user information in the database
  Future<void> _updateUserData() async {
    Users user = Users()
      ..setName(_nameController.text)
      ..setAge(int.tryParse(_ageController.text) ?? 0)
      ..setPhone(_phoneController.text);

    Database().add(user.collection, user.data); // Save changes
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Modifications sauvegardées !")),
    );
    Navigator.pop(context); // Return to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Editer le Profil",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nom",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: "Âge",
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Numéro de Téléphone",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _updateUserData, // Update user information
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Button color
                ),
                child: const Text("Sauvegarder"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
