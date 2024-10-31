import 'dart:convert';

import 'package:chevaldetroie/model/users.dart';
import 'package:chevaldetroie/view/authentification/forgot_pswd.dart';
import 'package:chevaldetroie/view/authentification/register.dart';
import 'package:chevaldetroie/view/register.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _pswdController = TextEditingController();

final List<String> _labelText = [
  'Email',
  'Password',
];

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3eaf1),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffe3eaf1),
      //   title: const Text('Formulaire'),
      // ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo_proj.png"))),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
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
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xff0263e0)),
                      minimumSize: WidgetStateProperty.all(const Size(380, 45)),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(horizontal: 44)),
                    ),
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
                                  builder: (context) => const RegisterPage()),
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
                    child: const Text(
                      'Log In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );}, child: Text("Forgot Password")),

                ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                      // minimumSize: ,
                      minimumSize: WidgetStateProperty.all(const Size(380, 45)),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(horizontal: 44)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                    child: const Text('Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
