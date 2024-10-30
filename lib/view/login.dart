import 'dart:convert';

import 'package:chevaldetroie/model/users.dart';
import 'package:chevaldetroie/profiles/profileEdit.dart';
import 'package:chevaldetroie/profiles/userProfile.dart';
import 'package:chevaldetroie/view/register.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _pswdController = TextEditingController();

final List<String> _labelText = [
  'Email',
  'Password',
];

class _FormPageState extends State<LoginPage> {
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
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
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Users login = Users();
                        await login.findFirstByField(
                            "email", _emailController.text);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text (login.getEmail())),
                        // );
                        if (login.getEmail() != "") {
                          var encode = utf8.encode(_pswdController.text);
                          var ash = sha256.convert(encode).toString();

                          if (login.getPassword() == ash) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Userprofile(test: login.getId())),
                            );
                          }
                          if (login.getPassword() != ash) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "L'email ou le mot de passe est incorrect !")),
                            );
                          }
                        }
                      }
                    },
                    child: const Text('Connection'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
