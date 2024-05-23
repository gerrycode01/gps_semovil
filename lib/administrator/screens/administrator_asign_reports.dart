import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/report_firestore.dart';
import 'package:gps_semovil/app/core/modules/database/user_firestore.dart';

import '../../app/core/design.dart';
import '../../user/models/report_model.dart';
import '../../user/models/user_model.dart';

class AdministratorAsignReports extends StatefulWidget {
  const AdministratorAsignReports({super.key});

  @override
  State<AdministratorAsignReports> createState() =>
      _AdministratorAsignReportsState();
}

class _AdministratorAsignReportsState extends State<AdministratorAsignReports> {
  List<ReportModel> _reportsList = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  Future<void> loadReports() async {
    try {
      List<ReportModel> reports = await getUnassignedReports();
      setState(() {
        _reportsList = reports;
      });
    } catch (error) {
      print("Error cargando la lista de reportes: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reportes sin asignar',
            style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
      ),
      body: ListView.builder(
        itemCount: _reportsList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () async {},
              child: Card(
                color: Design.paleYellow,
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Design.teal,
                            child:
                                Icon(Icons.directions_car, color: Colors.white),
                          ),
                          Text(
                              "${_reportsList[index].reportType ?? ''}/"
                              "${_reportsList[index].accidentType ?? ''}",
                              style: TextStyle(color: Design.seaGreen)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${_reportsList[index].description ?? ''}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("${_reportsList[index].place}"),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Design.botonGreen("Asignar", () {
                          _showAssignDialog(context, _reportsList[index]);
                        })],
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  void _showAssignDialog(BuildContext context, ReportModel report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController officerController = TextEditingController();
        UserModel? officer = UserModel(curp: '', names: '', lastname: '', email: '', rol: '');
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Seleccione el oficial a asignar', style: TextStyle(color: Design.teal)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(controller: officerController, decoration: InputDecoration(label: Text("CURP del oficial")),),
                Design.botonGreen("Buscar", () async {
                  officer = await getUserByCURP(officerController.text);
                })
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.redAccent)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Confirmar', style: TextStyle(color: Design.teal)),
              onPressed: () {
                if (officer != null)
                assignReport(report.id ?? '', officer);
                Navigator.of(context).pop();
                setState(() {
                  loadReports();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
