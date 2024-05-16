import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';

class DriverLicenseForm extends StatefulWidget {
  const DriverLicenseForm({super.key, required this.mode});

  final int mode;

  @override
  State<DriverLicenseForm> createState() => _DriverLicenseFormState();
}

class _DriverLicenseFormState extends State<DriverLicenseForm> {
  bool ineUp = false;
  bool addressProofUp = false;
  bool previousDriversLicense = false;
  bool thefLostCertificate = false;
  String? selectedDriverLicensesType;

  @override
  Widget build(BuildContext context) {
    return dinamico();
  }

  Widget dinamico() {
    switch (widget.mode) {
      case 1:
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'RENOVAR LICENCIA DE CONDUCIR',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                        onPressed: () {
                          //TODO: METODO PARA AGREGAR INE
                        },
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
                        onPressed: () {
                          //TODO: METODO PARA AGREGAR COMPROBANTE DE DOMICILIO
                        },
                        icon: Icon(
                            addressProofUp == false ? Icons.add : Icons.check))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(previousDriversLicense == false
                        ? 'SUBE TU LICENCIA DE CONDUCIR ANTERIOR'
                        : 'LICENCIA DE CONDUCIR ANTERIOR'),
                    IconButton(
                        onPressed: () {
                          //TODO: METODO PARA AGREGAR LICENCIA DE CONDUCIR ANTERIOR
                        },
                        icon: Icon(previousDriversLicense == false
                            ? Icons.add
                            : Icons.check))
                  ],
                ),
              ],
            ),
          );
        }
      case 2:
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'RECUPERAR LICENCIA DE CONDUCIR',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                        onPressed: () {
                          //TODO: METODO PARA AGREGAR INE
                        },
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
                        onPressed: () {
                          //TODO: METODO PARA AGREGAR COMPROBANTE DE DOMICILIO
                        },
                        icon: Icon(
                            addressProofUp == false ? Icons.add : Icons.check))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(thefLostCertificate == false
                        ? 'SUBE TU CERTIFICADO DE PERDIDA O ROBO'
                        : 'CERTIFICADO DE PERDIDA O ROBO'),
                    IconButton(
                        onPressed: () {
                          //TODO: METODO PARA AGREGAR CERTIFICADO DE PERDIDA O ROBO
                        },
                        icon: Icon(thefLostCertificate == false
                            ? Icons.add
                            : Icons.check))
                  ],
                ),
              ],
            ),
          );
        }
      default:
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'TRAMITAR LICENCIA DE CONDUCIR',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                        onPressed: () {
                          //TODO: METODO PARA AGREGAR INE
                        },
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
                        onPressed: () {
                          //TODO: METODO PARA AGREGAR COMPROBANTE DE DOMICILIO
                        },
                        icon: Icon(
                            addressProofUp == false ? Icons.add : Icons.check))
                  ],
                ),
              ],
            ),
          );
        }
    }
  }
}
