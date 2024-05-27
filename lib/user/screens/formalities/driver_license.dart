import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
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
  double? selectedPrice;

  File? ineInPDF;
  File? addressProofInPDF;
  File? oldLicenseInPDF;
  File? lostThefCertificateInPDF;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mode == 0
              ? 'TRAMITAR LICENCIA DE CONDUCIR'
              : 'RENOVAR LICENCIA DE CONDUCIR',
          style: TextStyle(color: Design.paleYellow),
        ),
        centerTitle: true,
        backgroundColor: Design.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.orange[100],  // Un color suave para el fondo
                  borderRadius: BorderRadius.circular(30),  // Bordes redondeados
                  border: Border.all(color: Colors.transparent)  // Borde transparente
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDriverLicensesType,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDriverLicensesType = newValue;
                      selectedPrice = getPrice(newValue!, widget.mode);
                    });
                  },
                  items: Const.driverLicensesTypes
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text('SELECCIONA EL TIPO DE LICENCIA', style: TextStyle(color: Colors.black)), // Texto del hint con estilo personalizado
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black), // Icono con color personalizado
                  iconSize: 24,  // Tamaño del ícono
                  elevation: 16,  // Elevación del menú dropdown
                  style: const TextStyle(color: Colors.black, fontSize: 16), // Estilo del texto de los items
                  dropdownColor: Colors.white,  // Color de fondo del menú dropdown
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              selectedPrice == null
                  ? 'PRECIO DISPONIBLE AL SELECCIONAR TIPO DE LICENCIA'
                  : 'Precio: \$${selectedPrice!.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Design.brightRed),
            ),
            SizedBox(height: 20),
            documentUploadSection('INE', ineUp, addIne),
            documentUploadSection('COMPROBANTE DE DOMICILIO', addressProofUp, addAddressProof),
            if (widget.mode != 0) documentUploadSection(
                widget.mode == 1 ? 'LICENCIA DE CONDUCIR ANTERIOR' : 'CERTIFICADO DE PERDIDA O ROBO',
                widget.mode == 1 ? oldLicenseUp : lostTheftCertificateUp,
                widget.mode == 1 ? addOldLicenses : addLostThefCertificate
            ),
            actionButton('CONTINUAR', _loading),
            SizedBox(height: 10),
            actionButton('CANCELAR', () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget documentUploadSection(String title, bool uploaded, Function onTap) {
    return Row(
      children: [
        Expanded(child: Text(uploaded ? '$title LISTO' : title)),
        IconButton(
          onPressed: () => onTap(),
          icon: Icon(uploaded ? Icons.check_circle : Icons.file_upload, color: Design.mintGreen),
        ),
      ],
    );
  }

  Widget actionButton(String text, Function onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: loading && text == 'CONTINUAR'
          ? CircularProgressIndicator(color: Design.paleYellow)
          : Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Design.teal,
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }

  void addIne() async {
    final pdf = await pickPDFFile();
    if (pdf != null) {
      setState(() {
        ineInPDF = File(pdf);
        ineUp = true;
      });
    }
  }

  void addAddressProof() async {
    final pdf = await pickPDFFile();
    if (pdf != null) {
      setState(() {
        addressProofInPDF = File(pdf);
        addressProofUp = true;
      });
    }
  }

  void addOldLicenses() async {
    final pdf = await pickPDFFile();
    if (pdf != null) {
      setState(() {
        oldLicenseInPDF = File(pdf);
        oldLicenseUp = true;
      });
    }
  }

  void addLostThefCertificate() async {
    final pdf = await pickPDFFile();
    if (pdf != null) {
      setState(() {
        lostThefCertificateInPDF = File(pdf);
        lostTheftCertificateUp = true;
      });
    }
  }

  void _loading() {
    if (!validSubmission()) return;
    setState(() {
      loading = true;
    });

    // Aquí iría el código para subir los archivos y actualizar la base de datos.

    Navigator.pop(context);
  }

  bool validSubmission() {
    if (selectedDriverLicensesType == null || !ineUp || !addressProofUp || (widget.mode == 1 && !oldLicenseUp) || (widget.mode == 2 && !lostTheftCertificateUp)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, completa todos los campos necesarios.', style: TextStyle(color: Colors.white)), backgroundColor: Design.brightRed));
      return false;
    }
    return true;
  }

  double getPrice(String licenseType, int mode) {
    // Esta función debería buscar el precio adecuado basándose en el tipo de licencia y el modo.
    return 100.0; // Valor de ejemplo
  }
}
