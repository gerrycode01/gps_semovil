import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gps_semovil/app/core/modules/database/report_firestore.dart';
import 'package:gps_semovil/app/core/modules/database/user_firestore.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/report_model.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class AdministratorAsignReports extends StatefulWidget {
  const AdministratorAsignReports({super.key});

  @override
  State<AdministratorAsignReports> createState() => _AdministratorAsignReportsState();
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
        title: const Text('Reportes sin asignar', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
      ),
      body: ListView.builder(
        itemCount: _reportsList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Design.paleYellow,
            margin: EdgeInsets.all(8),
            elevation: 4,
            child: InkWell(
              onTap: () async {},
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Design.teal,
                          child: Icon(Icons.directions_car, color: Colors.white),
                        ),
                        Text("${_reportsList[index].reportType ?? ''}/${_reportsList[index].accidentType ?? ''}",
                            style: TextStyle(color: Design.seaGreen, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text("${_reportsList[index].description ?? ''}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text("${_reportsList[index].place}"),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Design.teal),
                        onPressed: () => _showAssignDialog(context, _reportsList[index]),
                        child: Text("Asignar",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAssignDialog(BuildContext context, ReportModel report) {
    TextEditingController officerController = TextEditingController();
    UserModel? officer;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Seleccione el oficial a asignar', style: TextStyle(color: Design.teal)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(controller: officerController, decoration: InputDecoration(label: Text("CURP del oficial"))),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    officer = await getUserByCURP(officerController.text);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Design.teal),
                  child: Text("Buscar",style: TextStyle(color: Colors.white),),
                ),
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
                if (officer != null) {
                  assignReport(report.id ?? '', officer!);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reporte asignado correctamente!'), backgroundColor: Colors.green),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void assignReport(String reportId, UserModel officer) {
    // Aquí iría el código para asignar el reporte al oficial.
    // Simulación de asignación:
    print("Asignando reporte $reportId al oficial ${officer.names}");
  }
}
