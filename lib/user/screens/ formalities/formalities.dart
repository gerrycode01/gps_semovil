import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class ScreenFormalities extends StatefulWidget {
  const ScreenFormalities({super.key, required this.user});

  final UserModel user;

  @override
  State<ScreenFormalities> createState() => _ScreenFormalitiesState();
}

class _ScreenFormalitiesState extends State<ScreenFormalities> {
  List<Formalities> formalities = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarDatos();
  }

  void cargarDatos() async {
    List<Formalities> temporalFormalities = await getAllFormalities();
    setState(() {
      formalities = temporalFormalities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRAMITES'),
      ),
      body: ListView.builder(
          itemCount: formalities.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${formalities[index].driverLicenseType} - ${Const.statusForm[formalities[index].status]}'),
              trailing: formalities[index].status == 0
                  ? IconButton(
                      icon: const Icon(Icons.paid),
                      onPressed: () {
                        //TODO: LLEVAR A LA PANTALLA DE PAGO
                      },
                    )
                  : null,
            );
          }),
    );
  }
}
