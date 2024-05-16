import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/user/models/user_model.dart';

import '../../app/core/design.dart';
import '../../app/core/modules/database/fines_firestore.dart';
import '../models/fine-model.dart';

class TrafficOfficerFines extends StatefulWidget {
  TrafficOfficerFines({super.key, required  this.trafficOfficer});
  UserModel trafficOfficer;


  @override
  State<TrafficOfficerFines> createState() => _TrafficOfficerFinesState();
}

class _TrafficOfficerFinesState extends State<TrafficOfficerFines> {

  UserModel? user;

  TextEditingController platesController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController municipalityController = TextEditingController();
  TextEditingController article1Controller = TextEditingController();
  TextEditingController justification1Controller = TextEditingController();
  TextEditingController article2Controller = TextEditingController();
  TextEditingController justification2Controller = TextEditingController();
  TextEditingController article3Controller = TextEditingController();
  TextEditingController justification3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("Buscar por placas"),
          Design.campoTexto(platesController, "Buscar"),
          Design.botonGreen("Buscar", () async {
            user = await getUserByPlate(platesController.text);
            print(user?.email);
          }),
          Text("Datos del usuario"),
          /* Aquí pones todos los campos de texto del usuario, ocupas
            user.nombre, user.email, etc. etc., cuando presione buscar
            que se rellenen automaticamente
          */

          Text("Datos de la multa"),
          Design.campoTexto(placeController, "Dirección de la infracción"),
          Design.campoTexto(municipalityController, "Municipio"),
          Design.campoTexto(article1Controller, "Fundamento legal o artículos infringidos"),
          Design.campoTexto(justification3Controller, "Descripcion o justificacion de la infracción"),
          Design.campoTexto(article2Controller, "Fundamento legal o artículos infringidos"),
          Design.campoTexto(justification3Controller, "Descripcion o justificacion de la infracción"),
          Design.campoTexto(article3Controller, "Fundamento legal o artículos infringidos"),
          Design.campoTexto(justification3Controller, "Descripcion o justificacion de la infracción"),

          Design.botonGreen("Subir multa", () {
            FineModel fine = FineModel(
              place: placeController.text,
              date: Timestamp.fromDate(DateTime.now()),
              municipality: municipalityController.text,
              user: user?.toSmallJSON(),
              trafficOfficer: widget.trafficOfficer.toSmallJSON(),
              article1: article1Controller.text,
              justification1: justification1Controller.text,
              article2: article2Controller.text,
              justification2: justification1Controller.text,
              article3: article3Controller.text,
              justification3: justification1Controller.text,
              status: 'Pendiente'
            );

            fineUser(fine);
          })

        ],
      )
    );
  }
}
