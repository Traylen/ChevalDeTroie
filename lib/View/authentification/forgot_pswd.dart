import 'dart:convert';

import 'package:chevaldetroie/model/users.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _pswdController = TextEditingController();
final TextEditingController _confirmpswdController = TextEditingController();


final List<String> _labelText = [
  'Name'
      'Email',
  'Password',
  'PPUrl'
];

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  String? validEmail(value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return !regex.hasMatch(value) && value != null
        ? 'Enter valid Email Please'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3eaf1),
      appBar: AppBar(
        backgroundColor: const Color(0xffe3eaf1),
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
                    decoration: InputDecoration(
                      labelText: 'Email',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFa1a1a1),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF396ce7),
                          )),
                    ),
                    validator: validEmail),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: _pswdController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFa1a1a1),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF396ce7),
                        )),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty && value.length < 5) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _confirmpswdController,
                  decoration: InputDecoration(
                    labelText: 'Confirm your Password',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFa1a1a1),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF396ce7),
                        )),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty && value.length < 5) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    // minimumSize: ,
                    minimumSize: WidgetStateProperty.all(const Size(200, 40)),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 44)),
                  ),
                  onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Users login = Users();
                        await login.findFirstByField(
                            "email", _emailController.text);
                        if (_pswdController.text==_confirmpswdController.text){
                          if (login.getEmail() != "") {
                            var encode = utf8.encode(_confirmpswdController.text);
                            var ash = sha256.convert(encode).toString();

                            if (login.getPassword() == ash) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
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
                    }
                  },
                  child: const Text('Changer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
