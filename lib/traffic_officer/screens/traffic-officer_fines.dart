import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/user/models/user_model.dart';

import '../../app/core/design.dart';
import '../../app/core/modules/database/fines_firestore.dart';
import '../models/fine-model.dart';

class TrafficOfficerFines extends StatefulWidget {
  TrafficOfficerFines({super.key, required this.trafficOfficer});
  final UserModel trafficOfficer;

  @override
  State<TrafficOfficerFines> createState() => _TrafficOfficerFinesState();
}

class _TrafficOfficerFinesState extends State<TrafficOfficerFines> {
  UserModel? user;
  TextEditingController platesController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  List<TextEditingController> articleControllers = [TextEditingController()];
  List<TextEditingController> justificationControllers = [TextEditingController()];

  List<String> municipalities = ["Tepic", "Xalisco", "Bahía de Banderas", "Compostela", "San Blas", "Santiago Ixcuintla"];
  String? selectedMunicipality;

  void addArticle() {
    setState(() {
      articleControllers.add(TextEditingController());
      justificationControllers.add(TextEditingController());
    });
  }

  void removeArticle(int index) {
    if (articleControllers.length > 1) {
      setState(() {
        articleControllers.removeAt(index);
        justificationControllers.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Design.teal,
        title: Text('Registro de Multas', style: TextStyle(color: Design.paleYellow)),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Row(
            children: [
              Expanded(
                child: Design.campoTexto(platesController, "Buscar por placas"),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Design.teal),
                onPressed: () async {
                  user = await getUserByPlate(platesController.text);
                  setState(() {});
                },
              ),
            ],
          ),
          if (user != null) ...[
            Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                color: Design.teal,
                elevation: 10,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email, color:Design.paleYellow),
                      title: Text("${user?.email}",style: TextStyle(color: Colors.white),),
                      subtitle: Text("Correo electrónico",style: TextStyle(color: Design.lightOrange),),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.person, color: Design.paleYellow),
                      title: Text("${user?.names}",style: TextStyle(color: Colors.white),),
                      subtitle: Text("Nombre",style: TextStyle(color: Design.lightOrange),),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.person_outline, color: Design.paleYellow),
                      title: Text("${user?.lastname}",style: TextStyle(color: Colors.white),),
                      subtitle: Text("Apellido",style: TextStyle(color: Design.lightOrange),),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.directions_car, color: Design.paleYellow),
                      title: Text("${platesController.text}",style: TextStyle(color: Colors.white),),
                      subtitle: Text("Placa del vehículo",style: TextStyle(color: Design.lightOrange),),
                    ),
                  ],
                ),
              ),
            ),SizedBox(height: 10),
            Text(
              'Datos necesarios para la multa',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Design.teal),
            ),
            Row(
              children: [
                Expanded(
                  child: Design.campoTexto(placeController, "Dirección de la infracción"),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedMunicipality,
                    onChanged: (newValue) {
                      setState(() {
                        selectedMunicipality = newValue;
                      });
                    },
                    items: municipalities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text('Selecciona un municipio'),
                  ),
                ),
              ],
            ),SizedBox(height: 10),
            ...List.generate(articleControllers.length, (index) {
              return Row(
                children: [
                  Expanded(
                    child: Design.campoTexto(articleControllers[index], "Fundamento legal o artículos infringidos"),
                  ),
                  Expanded(
                    child: Design.campoTexto(justificationControllers[index], "Descripcion o justificacion de la infracción"),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: addArticle,
                  ),
                  if (articleControllers.length > 1)
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => removeArticle(index),
                    ),
                ],
              );
            }),
            ElevatedButton(
              onPressed: () {
                FineModel fine = FineModel(
                    place: placeController.text,
                    date: Timestamp.fromDate(DateTime.now()),
                    municipality: selectedMunicipality,
                    user: user?.toSmallJSON(),
                    trafficOfficer: widget.trafficOfficer.toSmallJSON(),
                    article1: articleControllers[0].text,
                    justification1: justificationControllers[0].text,
                    article2: articleControllers.length > 1 ? articleControllers[1].text : "",
                    justification2: justificationControllers.length > 1 ? justificationControllers[1].text : "",
                    article3: articleControllers.length > 2 ? articleControllers[2].text : "",
                    justification3: justificationControllers.length > 2 ? justificationControllers[2].text : "",
                    status: 'Pendiente'
                );

                fineUser(fine);
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Design.teal)),
              child: Text('Subir multa', style: TextStyle(color: Colors.white)),
            )
          ],

        ],
      ),
    );
  }
}
