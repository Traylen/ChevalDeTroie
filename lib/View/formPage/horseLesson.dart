import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Horselesson extends StatefulWidget {
  const Horselesson({super.key});

  @override
  _HorselessonState createState() => _HorselessonState();
}

class _HorselessonState extends State<Horselesson> {
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
        title: const Text('horselesson'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dropdown 1
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'prendre un terrain'),
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
                const SizedBox(height: 20),

                // Dropdown 2
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'type de lesson'),
                  value: _selectedOption2,
                  items: _dropdownOptions2.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOption2 = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Veuillez choisir une option' : null,
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Option 1: $_selectedOption1\n'
                              'Option 2: $_selectedOption2\n'
                              'Date: ${_selectedDate != null ? DateFormat('dd/MM/yyyy').format(_selectedDate!) : 'Non sélectionnée'}'),
                        ),
                      );
                    }
                  },
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
