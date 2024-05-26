import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:gps_semovil/user/screens/formalities/payment_screen.dart';

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
            String formalitiesType = getFormalitiesType(formalities[index]);
            return ListTile(
              title: Text(
                  '${formalities[index].driverLicenseType} - ${Const.statusForm[formalities[index].status]} \n$formalitiesType'),
              trailing: formalities[index].status == 0
                  ? IconButton(
                      icon: const Icon(Icons.paid),
                      onPressed: () {
                        //TODO: LLEVAR A LA PANTALLA DE PAGO
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => PaymentScreen(
                                        formalities: formalities[index])))
                            .then((value) => setState(() {
                                  cargarDatos();
                                }));
                      },
                    )
                  : null,
            );
          }),
    );
  }

  String getFormalitiesType(Formalities formalities) {
    if (formalities.firsTime) {
      return 'TRAMITE DE LICENCIA';
    }
    if (formalities.oldDriversLicense != null) {
      return 'RENOVACIÓN DE LICENCIA';
    }
    if (formalities.theftLostCertificate != null) {
      return 'RECUPERACIÓN DE LICENCIA';
    }
    return '';
  }
}
