import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
import 'package:gps_semovil/app/core/modules/database/storage.dart';
import 'package:gps_semovil/app/core/modules/select_image.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class DriverLicenseForm extends StatefulWidget {
  const DriverLicenseForm({super.key, required this.mode, required this.user});

  final UserModel user;
  final int mode;

  @override
  State<DriverLicenseForm> createState() => _DriverLicenseFormState();
}

class _DriverLicenseFormState extends State<DriverLicenseForm> {
  bool ineUp = false;
  bool addressProofUp = false;
  bool oldLicenseUp = false;
  bool lostTheftCertificateUp = false;
  bool loading = false;

  String? selectedDriverLicensesType;

  File? ineInPDF;
  File? addressProofInPDF;
  File? oldLicenseInPDF;
  File? lostThefCertificateInPDF;

  @override
  Widget build(BuildContext context) {
    return dinamico();
  }

  Widget dinamico() {
    switch (widget.mode) {
      case 1:
        {
          return driverLicensesTypesRenew();
        }
      case 2:
        {
          return driverLicensesLostThef();
        }
      default:
        {
          return driverLicensesTypes();
        }
    }
  }

  Widget driverLicensesTypesRenew() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RENOVAR LICENCIA DE CONDUCIR',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          Row(
            children: [
              Text(ineUp == false ? 'SUBE TU INE' : 'INE ARRIBA'),
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
                  ? 'SUBE TU COMPROBANTE DE DOMICILIO'
                  : 'COMPROBANTE DE DOMICILIO'),
              IconButton(
                  onPressed: addAddressProof,
                  icon: Icon(addressProofUp == false ? Icons.add : Icons.check))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(oldLicenseUp == false
                  ? 'SUBE TU LICENCIA DE CONDUCIR ANTERIOR'
                  : 'LICENCIA DE CONDUCIR ANTERIOR'),
              IconButton(
                  onPressed: addOldLicenses,
                  icon: Icon(oldLicenseUp == false ? Icons.add : Icons.check))
            ],
          ),
          TextButton(
              onPressed: () {
                //TODO: VALIDACIONES DE FORMA CORRECTA
                if(selectedDriverLicensesType == null) return;
                if (!ineUp || !addressProofUp || !oldLicenseUp) return;

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
                //TODO: REGRESAR AL MENU PRINCIPAL
                Navigator.pushReplacementNamed(context, '/user_homepage',
                    arguments: widget.user);
              },
              child: const Text('CANCELAR'))
        ],
      ),
    );
  }

  Widget driverLicensesLostThef() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RECUPERAR LICENCIA DE CONDUCIR',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          Row(
            children: [
              Text(ineUp == false ? 'SUBE TU INE' : 'INE ARRIBA'),
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
                  ? 'SUBE TU COMPROBANTE DE DOMICILIO'
                  : 'COMPROBANTE DE DOMICILIO'),
              IconButton(
                  onPressed: addAddressProof,
                  icon: Icon(addressProofUp == false ? Icons.add : Icons.check))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(lostTheftCertificateUp == false
                  ? 'SUBE TU CERTIFICADO DE PERDIDA O ROBO'
                  : 'CERTIFICADO DE PERDIDA O ROBO'),
              IconButton(
                  onPressed: addAddressProof,
                  icon: Icon(
                      lostTheftCertificateUp == false ? Icons.add : Icons.check))
            ],
          ),
          TextButton(
              onPressed: () {
                //TODO: VALIDACIONES DE FORMA CORRECTA
                if(selectedDriverLicensesType == null) return;
                if (!ineUp || !addressProofUp || !lostTheftCertificateUp) return;

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
                //TODO: REGRESAR AL MENU PRINCIPAL
                Navigator.pushReplacementNamed(context, '/user_homepage',
                    arguments: widget.user);
              },
              child: const Text('CANCELAR'))
        ],
      ),
    );
  }

  Widget driverLicensesTypes() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRAMITAR LICENCIA DE CONDUCIR',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          Row(
            children: [
              Text(ineUp == false ? 'SUBE TU INE' : 'INE ARRIBA'),
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
                  ? 'SUBE TU COMPROBANTE DE DOMICILIO'
                  : 'COMPROBANTE DE DOMICILIO'),
              IconButton(
                  onPressed: addAddressProof,
                  icon: Icon(addressProofUp == false ? Icons.add : Icons.check))
            ],
          ),
          TextButton(
              onPressed: () {
                //TODO: VALIDACIONES DE FORMA CORRECTA
                if(selectedDriverLicensesType == null) return;
                if (!ineUp || !addressProofUp) return;
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
                //TODO: REGRESAR AL MENU PRINCIPAL
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

    //Subir formalities a firestorage
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
        idFormalities: idFormalities+1,
        driverLicenseType: selectedDriverLicensesType!,
        user: widget.user,
        date: Timestamp.fromDate(DateTime.now()),
        ineDoc: urlINE,
        addressProofDoc: urlAddressProof,
        firsTime: widget.mode == 0,
        oldDriversLicense: urlOldLicense,
        theftLostCertificate: urlLostThefCertificate,
        status: 0);

    await addFormalities(formalities);

    setState(() {
      loading = false;
    });
  }
}
