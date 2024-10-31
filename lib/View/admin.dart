import 'package:flutter/material.dart';
import 'package:chevaldetroie/model/rave.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Rave> _unvalidatedRaves = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUnvalidatedRaves();
  }

  // Fonction pour charger les raves non validées
  Future<void> _loadUnvalidatedRaves() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Rave> raves = await Rave().findUnvalidatedRaves();
      setState(() {
        _unvalidatedRaves = raves;
        _isLoading = false;
      });
    } catch (e) {
      print('Erreur lors du chargement des raves non validées : $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleValidation(Rave rave) async {
    setState(() {
      _isLoading = true;
    });
    try {
      rave.setValidate(true);
      await rave.update();
      _loadUnvalidatedRaves();
    } catch (e) {
      print('Erreur lors de la mise à jour de la validation : $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Valider les raves'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _unvalidatedRaves.length,
              itemBuilder: (context, index) {
                Rave rave = _unvalidatedRaves[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text("Thème: ${rave.getTheme()}"),
                    subtitle: Text("Date: ${rave.getDate()}"),
                    trailing: ElevatedButton(
                      onPressed: () => _toggleValidation(rave),
                      child: Text("Valider"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
