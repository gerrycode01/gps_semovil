import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app/core/design.dart';
import '../../app/core/modules/database/firestore.dart';
import '../models/report_model.dart';
import '../models/user_model.dart';

class UserAddReports extends StatefulWidget {
  const UserAddReports({super.key, required this.user});

  final UserModel user;

  @override
  State<UserAddReports> createState() => _UserAddReportsState();
}

class _UserAddReportsState extends State<UserAddReports> {
  final reportTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final placeController = TextEditingController();
  final GURBController = TextEditingController();
  final evidenceController = TextEditingController();
  final accidentTypeController = TextEditingController();
  final statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
      ),
      body: ListView(
        children:[
          Text("Ventana agregar"),
          Design.campoTexto(reportTypeController, "Tipo de reporte"),
          Design.campoTexto(descriptionController, "Descripcion"),
          Design.campoTexto(dateController, "Fecha"),
          Design.campoTexto(placeController, "Lugar"),
          Design.campoTexto(GURBController, "GURB"),
          Design.campoTexto(evidenceController, "Link de la foto creo"),
          Design.campoTexto(accidentTypeController, "Tipo de accidente"),
          Design.campoTexto(statusController, "Status"),
          Text("Evidencia"),
          IconButton(onPressed: (){}, icon: Icon(Icons.image)),
          ElevatedButton(onPressed: (){

            ReportModel report = ReportModel(
                reportType: reportTypeController.text,
                description: descriptionController.text,
                date: Timestamp.fromDate(DateTime.parse(dateController.text)),
                place: placeController.text,
                GURB: GURBController.text,
                evidence: evidenceController.text,
                accidentType: accidentTypeController.text,
                status: statusController.text,
                user: widget.user.toJSON(),
            );
            addReport(report);
          }, child: Text("Subir reporte"))
        ]
      )
    );
  }
}
