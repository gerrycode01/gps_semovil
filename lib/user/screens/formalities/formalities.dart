import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:gps_semovil/user/screens/formalities/payment_screen.dart';

class ScreenFormalities extends StatefulWidget {
  final UserModel user;
  const ScreenFormalities({super.key, required this.user});

  @override
  State<ScreenFormalities> createState() => _ScreenFormalitiesState();
}

class _ScreenFormalitiesState extends State<ScreenFormalities> {
  List<Formalities> formalities = [];

  @override
  void initState() {
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
        title: const Text('Trámites', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
        centerTitle: true,
        foregroundColor: Design.paleYellow,
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: formalities.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: formalitiesCard(formalities[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget formalitiesCard(Formalities formalities) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Design.seaGreen,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          '${formalities.driverLicenseType} - ${formalities.firsTime ? "Nuevo" : "Renovación"}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          getFormalitiesType(formalities),
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        trailing: formalities.status == 0 ? IconButton(
          icon: const Icon(Icons.payment, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => PaymentScreen(formalities: formalities)
                )
            ).then((value) => cargarDatos());
          },
        ) : Icon(Icons.check, color: Colors.green[200]),
      ),
    );
  }

  String getFormalitiesType(Formalities formalities) {
    if (formalities.firsTime) {
      return 'Trámite de licencia';
    }
    if (formalities.oldDriversLicense != null) {
      return 'Renovación de licencia';
    }
    if (formalities.theftLostCertificate != null) {
      return 'Recuperación de licencia';
    }
    return 'Sin especificar';
  }
}
