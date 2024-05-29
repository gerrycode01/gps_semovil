import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/storage.dart';
import 'package:gps_semovil/app/core/modules/select_image.dart';
import 'package:image_picker/image_picker.dart';
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
  String? reportType; // Tipo de reporte seleccionado
  String? selectedAccidentType; // Tipo de accidente seleccionado
  XFile? evidence;
  File? evidenceToUpload;

  bool _loading = false;
  bool evidenciaUp = false;

  final List<DropdownMenuItem<String>> reportTypes = [
    const DropdownMenuItem(
        value: "Transporte público", child: Text("Transporte público")),
    const DropdownMenuItem(
        value: "Accidente vial", child: Text("Accidente vial")),
  ];
  final List<DropdownMenuItem<String>> accidentTypes = [
    const DropdownMenuItem(
        value: "Accidente con peatones", child: Text("Accidente con peatones")),
    const DropdownMenuItem(
        value: "Accidente con ciclistas",
        child: Text("Accidente con ciclistas")),
    const DropdownMenuItem(
        value: "Accidente con transporte público",
        child: Text("Accidente con transporte público")),
  ];

  final descriptionController = TextEditingController();
  final placeController = TextEditingController();
  final routeController =
      TextEditingController(); // Solo para transporte público
  final GURBController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar Reporte',
          style: TextStyle(color: Colors.teal),
        ),
        centerTitle: true,
        foregroundColor: Design.paleYellow,
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
                  selectedAccidentType = null; // Reset when report type changes
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
              filePickerSection(),
              const SizedBox(height: 30),
              _loading
                  ? const CircularProgressIndicator()
                  : Design.botonGreen("Subir reporte", () async {
                      setState(() {
                        _loading = true;
                      });

                      ReportModel report = ReportModel(
                          reportType: reportType,
                          description: descriptionController.text,
                          date: Timestamp.fromDate(DateTime.now()),
                          place: placeController.text,
                          GURB: GURBController.text,
                          accidentType:
                              selectedAccidentType, // Use the dropdown selection
                          status: "Reportado",
                          user: widget.user.toSmallJSON(),
                          evidence: '');
                      String? id = await addReport(report);
                      String url = '';

                      if (evidenceToUpload != null && id != null) {
                        url = await uploadFileToFirestorage(
                            evidenceToUpload!, 'reportes', id);
                      }

                      if (url != 'ERROR') {
                        report.evidence = url;
                        await updateReport(report, id!);
                      }

                      Design.showSnackBarGood(
                          context, "REPORTE REGISTRADO", Colors.green);
                      Navigator.pop(context);

                      setState(() {
                        _loading = false;
                      });
                    })
            ],
          ],
        ),
      ),
    );
  }

  Widget filePickerSection() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.file_upload, color: Colors.white),
      label: evidenciaUp
          ? const Text('Evidencia subida')
          : const Text('Subir evidencia'),
      onPressed: _pickEvidence,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue, // Color del botón
      ),
    );
  }

  void _pickEvidence() async {
    final image = await getImage();
    if (image != null) {
      setState(() {
        evidenceToUpload = File(image.path);
        evidenciaUp = true;
      });
    }
  }
}
