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
  String? reportType;  // Tipo de reporte seleccionado
  String? selectedAccidentType;  // Tipo de accidente seleccionado

  final List<DropdownMenuItem<String>> reportTypes = [
    DropdownMenuItem(value: "Transporte público", child: Text("Transporte público")),
    DropdownMenuItem(value: "Accidente vial", child: Text("Accidente vial")),
  ];
  final List<DropdownMenuItem<String>> accidentTypes = [
    DropdownMenuItem(value: "Accidente con peatones", child: Text("Accidente con peatones")),
    DropdownMenuItem(value: "Accidente con ciclistas", child: Text("Accidente con ciclistas")),
    DropdownMenuItem(value: "Accidente con transporte público", child: Text("Accidente con transporte público")),
  ];

  final descriptionController = TextEditingController();
  final placeController = TextEditingController();
  final routeController = TextEditingController();  // Solo para transporte público
  final GURBController = TextEditingController();
  final evidenceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Reporte',style: TextStyle(color: Colors.teal),),
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
                  selectedAccidentType = null;  // Reset when report type changes
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
            if (reportType != null) ...[
              Design.campoTexto(descriptionController, "Descripción"),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: selectedAccidentType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAccidentType = newValue;
                  });
                },
                items: accidentTypes,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.orange[100],
                  hintText: "Tipo de accidente",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
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
                // Since we're using Dropdown for accident type, no need for another Text Field here
                const SizedBox(height: 20),
              ],
              Design.campoTexto(evidenceController, "Evidencia (opcional)"),
              const SizedBox(height: 30),
              Design.botonGreen("Subir reporte", () {
                ReportModel report = ReportModel(
                  reportType: reportType,
                  description: descriptionController.text,
                  date: Timestamp.fromDate(DateTime.now()),
                  place: placeController.text,
                  GURB: GURBController.text,
                  evidence: evidenceController.text,
                  accidentType: selectedAccidentType, // Use the dropdown selection
                  status: "Reportado",
                  user: widget.user.toSmallJSON(),
                );
                addReport(report);
                Design.showSnackBarGood(context, "REPORTE REGISTRADO");
                Navigator.pop(context);
              })
            ],
          ],
        ),
      ),
    );
  }
}
