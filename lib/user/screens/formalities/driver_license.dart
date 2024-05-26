import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
import 'package:gps_semovil/app/core/modules/database/storage.dart';
import 'package:gps_semovil/app/core/modules/select_image.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:gps_semovil/user/screens/formalities/payment_screen.dart';

class DriverLicenseForm extends StatefulWidget {
  const DriverLicenseForm({super.key, required this.mode, required this.user});

  final UserModel user;
  final int mode;

  @override
  State<DriverLicenseForm> createState() => _DriverLicenseFormState();
}

class _DriverLicenseFormState extends State<DriverLicenseForm> {
  int mode = 0;
  bool ineUp = false;
  bool addressProofUp = false;
  bool oldLicenseUp = false;
  bool lostTheftCertificateUp = false;
  bool loading = false;

  String? selectedDriverLicensesType;
  double? selectedPrice;

  File? ineInPDF;
  File? addressProofInPDF;
  File? oldLicenseInPDF;
  File? lostThefCertificateInPDF;

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return driverLicensesTypes();
  }

  String processText = 'TRAMITAR LICENCIA DE CONDUCIR';
  String renewText = 'RENOVAR LICENCIA DE CONDUCIR';
  String recoverText = 'RENOVAR LICENCIA DE CONDUCIR';

  Widget driverLicensesTypes() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mode == 0
              ? processText
              : mode == 1
                  ? renewText
                  : renewText,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(40),
        children: [
          DropdownButton<String>(
              value: selectedDriverLicensesType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDriverLicensesType = newValue;
                  selectedPrice = getPrice(newValue!, mode);
                });
              },
              items: Const.driverLicensesTypes
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text('SELECCIONA EL TIPO DE LICENCIA')),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              selectedPrice == null
                  ? 'PRECIO DISPONIBLE AL SELECCIONAR TIPO DE LICENCIA'
                  : 'Precio: \$${selectedPrice!.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Text(ineUp == false ? 'INE' : 'INE LISTA'),
              IconButton(
                  onPressed: addIne,
                  icon: Icon(ineUp == false ? Icons.add : Icons.check))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(addressProofUp == false
                  ? 'COMPROBANTE DE DOMICILIO'
                  : 'COMPROBANTE DE DOMICILIO LISTO'),
              IconButton(
                  onPressed: addAddressProof,
                  icon: Icon(addressProofUp == false ? Icons.add : Icons.check))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          mode == 0
              ? const Row()
              : mode == 1
                  ? Row(
                      children: [
                        Text(oldLicenseUp == false
                            ? 'LICENCIA DE CONDUCIR ANTERIOR'
                            : 'LICENCIA DE CONDUCIR ANTERIOR LISTA'),
                        IconButton(
                            onPressed: addOldLicenses,
                            icon: Icon(oldLicenseUp == false
                                ? Icons.add
                                : Icons.check))
                      ],
                    )
                  : Row(
                      children: [
                        Text(lostTheftCertificateUp == false
                            ? 'CERTIFICADO DE PERDIDA O ROBO'
                            : 'CERTIFICADO DE PERDIDA O ROBO LISTO'),
                        IconButton(
                            onPressed: addAddressProof,
                            icon: Icon(lostTheftCertificateUp == false
                                ? Icons.add
                                : Icons.check))
                      ],
                    ),
          TextButton(
              onPressed: () {
                if (selectedDriverLicensesType == null) {
                  mensaje(
                      'SELECCIONE EL TIPO DE LICENCIA A TRAMITAR', Colors.red);
                  return;
                }
                if (!ineUp) {
                  mensaje('FALTA SUBIR INE', Colors.red);
                  return;
                }
                if (!addressProofUp) {
                  mensaje('FALTA SUBIR COMPROBANTE DE DOMICILIO', Colors.red);
                  return;
                }
                if (mode == 1) {
                  if (!oldLicenseUp) {
                    mensaje('ES NECESARIO SUBIR LICENCIA DE CONDUCIR ANTIGUA',
                        Colors.red);
                    return;
                  }
                }
                if (mode == 2) {
                  if (!lostTheftCertificateUp) {
                    mensaje('ES NECESARIO SUBIR CERTIFICADO DE PERDIDA O ROBO',
                        Colors.red);
                    return;
                  }
                }

                _loading();
              },
              child: loading == true
                  ? const CircularProgressIndicator()
                  : const Text('CONTINUAR')),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                //TODO: REGRESAR AL MENU PRINCIPAL YA LO HACE PERO NO DE FORMA CORRECTA
                Navigator.pushReplacementNamed(context, '/user_homepage',
                    arguments: widget.user);
              },
              child: const Text('CANCELAR'))
        ],
      ),
    );
  }

  void addIne() async {
    final pdf = await pickPDFFile();
    ineInPDF = File(pdf as String);

    if (ineInPDF != null) {
      setState(() {
        ineUp = true;
      });
    }
  }

  void addOldLicenses() async {
    final pdf = await pickPDFFile();
    oldLicenseInPDF = File(pdf as String);

    if (oldLicenseInPDF != null) {
      setState(() {
        oldLicenseUp = true;
      });
    }
  }

  void addAddressProof() async {
    final pdf = await pickPDFFile();
    addressProofInPDF = File(pdf as String);

    if (addressProofInPDF != null) {
      setState(() {
        addressProofUp = true;
      });
    }
  }

  void addLostThefCertificate() async {
    final pdf = await pickPDFFile();
    lostThefCertificateInPDF = File(pdf as String);

    if (lostThefCertificateInPDF != null) {
      setState(() {
        lostTheftCertificateUp = true;
      });
    }
  }

  void _loading() async {
    setState(() {
      loading = true;
    });

    //Subir tramites a firestorage
    String urlINE =
        await uploadFileToFirestorage(ineInPDF!, widget.user.curp, 'INE.pdf');
    String urlAddressProof = await uploadFileToFirestorage(
        addressProofInPDF!, widget.user.curp, 'address_proof.pdf');
    String? urlOldLicense;
    if (oldLicenseUp) {
      urlOldLicense = await uploadFileToFirestorage(
          oldLicenseInPDF!, widget.user.curp, 'old_license.pdf');
    }
    String? urlLostThefCertificate;
    if (lostTheftCertificateUp) {
      urlLostThefCertificate = await uploadFileToFirestorage(
          lostThefCertificateInPDF!,
          widget.user.curp,
          'thef_lost_certificate.pdf');
    }

    int idFormalities = await getNumberOfFormalities();

    Formalities formalities = Formalities(
        idFormalities: idFormalities + 1,
        driverLicenseType: selectedDriverLicensesType!,
        price: selectedPrice!,
        user: widget.user,
        date: Timestamp.fromDate(DateTime.now()),
        ineDoc: urlINE,
        addressProofDoc: urlAddressProof,
        firsTime: widget.mode == 0,
        oldDriversLicense: urlOldLicense,
        theftLostCertificate: urlLostThefCertificate,
        status: 0);

    await addFormalities(formalities);
    await incrementFormalitiesCount();

    mensaje('TRAMITE AGREGADO, REVISA TRAMITES PENDIENTES', Colors.green);
    //TODO: LLEVAR A LA VENTANA DE PAGO GENERADO
    Navigator.pushReplacementNamed(context, '/user_homepage',
        arguments: widget.user);

    setState(() {
      loading = false;
    });
  }

  void mensaje(String string, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(string),
      backgroundColor: color,
    ));
  }

  double getPrice(String licenseType, int mode) {
    switch (mode) {
      case 0:
        return Const.driverLicensesPrices[licenseType] ?? 0;
      case 1:
        return Const.driverLicensesPricesRenew[licenseType] ?? 0;
      case 2:
        return Const.driverLicensesPricesLostTheft[licenseType] ?? 0;
      default:
        return 0;
    }
  }
}
