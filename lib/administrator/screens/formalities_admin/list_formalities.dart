import 'package:flutter/material.dart';
import 'package:gps_semovil/administrator/screens/formalities_admin/formalities_details_screen.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:intl/intl.dart'; // Importar para formatear fechas

class ListFormalities extends StatefulWidget {
  const ListFormalities({Key? key}) : super(key: key);

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
      ),
      body: ListView.builder(
        itemCount: formalities.length,
        itemBuilder: (BuildContext context, int index) {
          final f = formalities[index];
          return ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FormalitiesDetailScreen(formalities: f))),
            title: Text('ID: ${f.idFormalities} - ${f.driverLicenseType}'),
            subtitle: Text(
                'Precio: \$${f.price.toStringAsFixed(2)} - Fecha: ${DateFormat('dd/MM/yyyy').format(f.date.toDate())}'),
            trailing: Text('${Const.statusForm[f.status]}'),
          );
        },
      ),
    );
  }
}
