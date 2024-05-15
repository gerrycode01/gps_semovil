import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../app/core/design.dart';
import '../../../app/core/modules/database/report_firestore.dart';
import '../../models/report_model.dart';
import '../../models/user_model.dart';

class UserAddReports extends StatefulWidget {
  final UserModel user;
  const UserAddReports({super.key, required this.user});

  @override
  State<UserAddReports> createState() => _UserAddReportsState();
}

class _UserAddReportsState extends State<UserAddReports> {

  final reportTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final placeController = TextEditingController();
  final routeController = TextEditingController();  // Solo para transporte público
  final GURBController = TextEditingController();
  final evidenceController = TextEditingController();
  final accidentTypeController = TextEditingController();  // Solo para accidente vial
  String? reportType;  // Tipo de reporte seleccionado

  List<DropdownMenuItem<String>> reportTypes = [
    DropdownMenuItem(value: "Transporte público", child: Text("Transporte público")),
    DropdownMenuItem(value: "Accidente vial", child: Text("Accidente vial")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Reporte'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              value: reportType,
              items: reportTypes,
              onChanged: (String? value) {
                setState(() {
                  reportType = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: "Tipo de reporte",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Design.campoTexto(descriptionController, "Descripción"),
            const SizedBox(height: 20),
            Design.campoTexto(placeController, "Ubicación"),
            const SizedBox(height: 20),
            if (reportType == "Transporte público") ...[
              Design.campoTexto(routeController, "Ruta"),
              const SizedBox(height: 20),
              Design.campoTexto(GURBController, "GURB (opcional)"),
              const SizedBox(height: 20),
            ],
            if (reportType == "Accidente vial") ...[
              Design.campoTexto(accidentTypeController, "Tipo de accidente"),
              const SizedBox(height: 20),
            ],
            Design.campoTexto(evidenceController, "Evidencia (opcional)"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed:(){
                ReportModel report = ReportModel(
                  reportType: reportType,
                  description: descriptionController.text,
                  date: Timestamp.fromDate(DateTime.now()),
                  place: placeController.text,
                  GURB: GURBController.text,
                  evidence: evidenceController.text,
                  accidentType: accidentTypeController.text,
                  status: "Reportado",
                  user: widget.user.toSmallJSON(),
                );
                addReport(report);
              },
              child: Text("Subir reporte"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
