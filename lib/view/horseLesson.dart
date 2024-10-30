import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Horselesson extends StatefulWidget {
  @override
  _HorselessonState createState() => _HorselessonState();
}

class _HorselessonState extends State<Horselesson> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOption1;
  String? _selectedOption2;
  String? _selectedOption3;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final TextEditingController _PPController = TextEditingController();

  final List<String> _dropdownOptions1 = ['Manège', 'Carrière'];
  final List<String> _dropdownOptions2 = [
    'Dressage',
    'Saut d’obstacle',
    'Endurance'
  ];
  final List<String> _dropdownOptions3 = ['0:30', '1:00', '1:30', '2:00'];

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
        title: Text('Horselesson'),
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
                  decoration:
                      InputDecoration(labelText: 'Sélectionner un terrain'),
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

                // Dropdown 2
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Type de leçon'),
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
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Durée'),
                  value: _selectedOption3,
                  items: _dropdownOptions3.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOption3 = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Veuillez choisir une option' : null,
                ),

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

                // Time Picker
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Sélectionner une heure',
                          hintText: _selectedTime != null
                              ? _selectedTime!.format(context)
                              : 'Aucune heure sélectionnée',
                        ),
                        readOnly: true,
                        onTap: () => _pickTime(context),
                        validator: (value) => _selectedTime == null
                            ? 'Veuillez choisir une heure'
                            : null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () => _pickTime(context),
                    ),
                  ],
                ),

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
                  // Lessons()
                  // .setTerrain(_selectedOption1)
                  // .setType(_selectedOption2)
                  // .setDate(_selectedDate)
                  // .setTime(_selectedTime)
                  // .setDuree(_selectedOption3)
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
