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
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Design.campoTexto(placeController, "Dirección de la infracción"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: DropdownButtonHideUnderline(
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
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          hint: Text('Selecciona un municipio', style: const TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),SizedBox(height: 10),
            ...List.generate(articleControllers.length, (index) {
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(5),
                      child: Design.campoTexto(articleControllers[index], "Fundamento legal o artículos infringidos"),
                    )
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(5),
                      child: Design.campoTexto(justificationControllers[index], "Descripcion o justificacion de la infracción"),
                    )
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
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                List<String> articles = articleControllers.map((c) => c.text).toList();
                List<String> justifications = justificationControllers.map((c) => c.text).toList();

                FineModel fine = FineModel(
                    place: placeController.text,
                    date: Timestamp.fromDate(DateTime.now()),
                    municipality: selectedMunicipality,
                    user: user?.toSmallJSON(),
                    trafficOfficer: widget.trafficOfficer.toSmallJSON(),
                    articles: articles,
                    justifications: justifications,
                    status: 'Pendiente'
                );

                fineUser(fine);
                Navigator.pop(context);
                Design.showSnackBarGood(context, "Multa registrada correctamente",Colors.green);
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
