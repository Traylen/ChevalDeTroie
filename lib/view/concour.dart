import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Concour extends StatefulWidget {
  @override
  _ConcourState createState() => _ConcourState();
}

class _ConcourState extends State<Concour> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOption1;
  String? _selectedOption2;
  DateTime? _selectedDate;

  final List<String> _dropdownOptions1 = ['Manege', 'Carriere'];
  final List<String> _dropdownOptions2 = [
    'dressage',
    'Saut d ostacle',
    'Endurance'
  ];
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
        title: Text('horselesson'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'nom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'adresse'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'URL de photo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez remplir ce champ';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

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
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _pickDate(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Option 1: $_selectedOption1\n'
                              'Option 2: $_selectedOption2\n'
                              'Date: ${_selectedDate != null ? DateFormat('dd/MM/yyyy').format(_selectedDate!) : 'Non sélectionnée'}'),
                        ),
                      );
                    }
                  },
                  child: Text('Envoyer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
