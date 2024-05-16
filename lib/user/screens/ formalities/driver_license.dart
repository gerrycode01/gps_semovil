import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';
import 'package:gps_semovil/app/core/modules/select_image.dart';
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
  bool thefLostCertificateUp = false;

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
              Text(thefLostCertificateUp == false
                  ? 'SUBE TU CERTIFICADO DE PERDIDA O ROBO'
                  : 'CERTIFICADO DE PERDIDA O ROBO'),
              IconButton(
                  onPressed: addAddressProof,
                  icon: Icon(
                      thefLostCertificateUp == false ? Icons.add : Icons.check))
            ],
          ),
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
          TextButton(onPressed: () {}, child: const Text('CONTINUAR')),
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
    //TODO: METODO PARA AGREGAR INE
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
        thefLostCertificateUp = true;
      });
    }
  }
}
