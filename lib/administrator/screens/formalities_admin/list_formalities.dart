import 'package:flutter/material.dart';
import 'package:gps_semovil/administrator/screens/formalities_admin/formalities_details_screen.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:intl/intl.dart'; // Importar para formatear fechas

class ListFormalities extends StatefulWidget {
  const ListFormalities({super.key});

  @override
  State<ListFormalities> createState() => _ListFormalitiesState();
}

class _ListFormalitiesState extends State<ListFormalities> {
  List<Formalities> formalities = [];

  @override
  void initState() {
    super.initState();
    loadFormalities();
  }

  void loadFormalities() async {
    List<Formalities> formalities = await getAllFormalities();
    setState(() {
      this.formalities = formalities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Trámites'),
        backgroundColor: Design.teal,
        centerTitle: true,
        foregroundColor: Design.paleYellow,
      ),
      body: ListView.builder(
        itemCount: formalities.length,
        itemBuilder: (BuildContext context, int index) {
          final f = formalities[index];
          return Card(
            elevation: 10,
            color: Design.teal,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading:
                  const Icon(Icons.person, size: 50, color: Design.paleYellow),
              title: Text(
                'ID: ${f.idFormalities} - ${f.driverLicenseType}',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Precio: \$${f.price.toStringAsFixed(2)} - Fecha: ${DateFormat('dd/MM/yyyy').format(f.date.toDate())}',
                style: TextStyle(color: Design.lightOrange),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Design.mintGreen,
                    ),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FormalitiesDetailScreen(formalities: f)))
                          .then((value) => loadFormalities());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
