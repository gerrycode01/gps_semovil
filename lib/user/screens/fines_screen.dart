import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';

import '../../app/core/modules/database/fines_firestore.dart';
import '../../traffic_officer/models/fine-model.dart';
import '../models/user_model.dart';

class FinesScreen extends StatefulWidget {
  final UserModel user;

  const FinesScreen({super.key, required this.user});

  @override
  State<FinesScreen> createState() => _FinesScreenState();
}

class _FinesScreenState extends State<FinesScreen> {
  List<FineModel> _finesList = [];

  @override
  void initState() {
    super.initState();
    loadFines();
  }

  void loadFines() async {
    try {
      List<FineModel> fines = await getFinesByUser(widget.user.curp);
      setState(() {
        _finesList = fines;
      });

      print(_finesList.length);
    } catch (error) {
      print("Error cargando la lista de reportes: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Design.teal,
          title: Text(
            'Tus pagos',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: Design.paleYellow,
            dividerColor: Design.seaGreen,
            automaticIndicatorColorAdjustment: true,
            indicatorColor: Design.seaGreen,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'Pendientes'),
              Tab(text: 'Historial'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildFineList('Pendiente'),
            buildFineList('Atendido'),
          ],
        ),
      ),
    );
  }

  Widget buildFineList(String status) {
    List<FineModel> filteredFines =
        _finesList.where((fine) => fine.status == status).toList();
    return ListView.builder(
      itemCount: filteredFines.length,
      itemBuilder: (context, index) {
        FineModel fine = filteredFines[index];
        return Card(
          color: Design.paleYellow,
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: ListTile(
            trailing: Text(fine.formattedDate(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    "${fine.articles} - ${fine.justifications}" ?? "",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            title: Text("${fine.place}",
                style: TextStyle(fontStyle: FontStyle.italic)),
            onTap: () {
              _showPaymentDialog(context, fine);
            },
          ),
        );
      },
    );
  }

  void _showPaymentDialog(BuildContext context, FineModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('¿Deseas pagar?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
            ),
            TextButton(
              child: Text('Pagar'),
              onPressed: () {
                if (model.status == 'Pendiente') {
                  payFine(model.id);
                  Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                  setState(() {
                    loadFines();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
