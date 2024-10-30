import 'package:chevaldetroie/model/rave.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Raveparty extends StatefulWidget {
  @override
  _RavepartyState createState() => _RavepartyState();
}

class _RavepartyState extends State<Raveparty> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOption1;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool? validate;

  final TextEditingController _PPController = TextEditingController();

  final List<String> _dropdownOptions1 = ['Apéro', 'Repas'];

  // Date picker function
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

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raveparty'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dropdown 1
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Thème de la soirée'),
                  value: _selectedOption1,
                  items: _dropdownOptions1.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOption1 = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Veuillez choisir une option' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _PPController,
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

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Rave()
                          .setTheme(_selectedOption1!)
                          .setPicture(_PPController.text)
                          .setDate(
                              DateFormat('yyyy-MM-dd').format(_selectedDate!))
                          .setValidate('False')
                          .insert();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Leçon ajoutée avec succès"),
                        ),
                      );
                    }
                  },
                  child: Text("Envoyer"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
