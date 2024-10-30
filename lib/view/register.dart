import 'dart:convert';

import 'package:chevaldetroie/model/users.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _pswdController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _PPController = TextEditingController();

final List<String> _labelText = [
  'Name'
      'Email',
  'Password',
  'PPUrl'
];

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'nom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _pswdController,
                  decoration: const InputDecoration(labelText: 'mot de passe'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _PPController,
                  decoration: const InputDecoration(
                      labelText: 'Url photo de profil sale pd'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 79),
                  child: ElevatedButton(
                      onPressed: () {
                        var encode = utf8.encode(_pswdController.text);
                        var ash = sha256.convert(encode).toString();
                        Users()
                            .setName(_nameController.text)
                            .setEmail(_emailController.text)
                            .setPassword(ash)
                            .setPhoto(_PPController.text)
                            .insert();
                      },
                      child: const Text("Envoyer")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
