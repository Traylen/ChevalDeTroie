import 'package:flutter/material.dart';
import 'package:chevaldetroie/model/rave.dart';

class RaveValidationPage extends StatefulWidget {
  final String raveId;

  RaveValidationPage({required this.raveId});

  @override
  _RaveValidationPageState createState() => _RaveValidationPageState();
}

class _RaveValidationPageState extends State<RaveValidationPage> {
  Rave _rave = Rave();
  bool isLoading = true;
  bool? isValidated;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadRaveData();
  }

  Future<void> _loadRaveData() async {
    try {
      await _rave.findById(widget.raveId);
      setState(() {
        isValidated = _rave.getValidate();
        isLoading = false;
      });
    } catch (e) {
      print('Erreur lors du chargement des données : $e');
      setState(() {
        errorMessage = 'Erreur lors du chargement des données.';
        isLoading = false;
      });
    }
  }

  Future<void> _toggleValidation() async {
    setState(() {
      isLoading = true;
    });

    try {
      bool newValidationState = !isValidated!;
      _rave.setValidate(newValidationState);
      await _rave.update();
      setState(() {
        isValidated = newValidationState;
      });
    } catch (e) {
      print('Erreur lors de la mise à jour de la validation : $e');
      setState(() {
        errorMessage = 'Erreur lors de la mise à jour de la validation.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Validation Rave"),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : errorMessage != null
                ? Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Thème: ${_rave.getTheme()}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Validation: ${isValidated! ? "Validé" : "Non validé"}",
                        style: TextStyle(
                          fontSize: 20,
                          color: isValidated! ? Colors.green : Colors.red,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _toggleValidation,
                        child: Text(
                          isValidated! ? "Annuler la validation" : "Valider",
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
