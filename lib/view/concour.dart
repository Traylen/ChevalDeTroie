import 'package:chevaldetroie/model/concour.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Concour extends StatefulWidget {
  const Concour({super.key});

  @override
  _ConcourState createState() => _ConcourState();
}

class _ConcourState extends State<Concour> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;

  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _PPController = TextEditingController();

  final List<String> _labelText = ['Name', 'Adresse', 'PPUrl'];

//datepicker pour pas oublier
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('concour'),
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
                  controller: _adresseController,
                  decoration: const InputDecoration(labelText: 'adresse'),
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
                  decoration: const InputDecoration(labelText: 'URL de photo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Date Picker
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Sélectionner une date',
                          hintText: _selectedDate != null
                              ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                              : 'Aucune date sélectionnée',
                        ),
                        readOnly: true,
                        onTap: () => _pickDate(context),
                        validator: (value) => _selectedDate == null
                            ? 'Veuillez choisir une date'
                            : null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _pickDate(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Competition()
                          .setName(_nameController.text)
                          .setAdresse(_adresseController.text)
                          .setDate(
                              DateFormat('yyyy-MM-dd').format(_selectedDate!))
                          .setPP(_PPController.text)
                          .insert();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Leçon ajoutée avec succès"),
                        ),
                      );
                    }
                  },
                  // concour()
                  // .setName(_selectedName)
                  // .setAdresse(_adresseController)
                  // .setPicture()
                  // .setDate(_selectedDate)
                  child: const Text('Envoyer'),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
