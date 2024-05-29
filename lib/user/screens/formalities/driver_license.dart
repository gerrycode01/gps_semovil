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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mode == 0
              ? 'TRAMITAR LICENCIA DE CONDUCIR'
              : 'RENOVAR LICENCIA DE CONDUCIR',
          style: const TextStyle(color: Design.paleYellow),
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
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.transparent)),
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
                  hint: const Text('SELECCIONA EL TIPO DE LICENCIA',
                      style: TextStyle(color: Colors.black)),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  dropdownColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              selectedPrice == null
                  ? 'PRECIO DISPONIBLE AL SELECCIONAR TIPO DE LICENCIA'
                  : 'Precio: \$${selectedPrice!.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Design.brightRed),
            ),
            const SizedBox(height: 20),
            documentUploadSection('INE', ineUp, addIne),
            documentUploadSection(
                'COMPROBANTE DE DOMICILIO', addressProofUp, addAddressProof),
            if (widget.mode != 0)
              documentUploadSection(
                  widget.mode == 1
                      ? 'LICENCIA DE CONDUCIR ANTERIOR'
                      : 'CERTIFICADO DE PERDIDA O ROBO',
                  widget.mode == 1 ? oldLicenseUp : lostTheftCertificateUp,
                  widget.mode == 1 ? addOldLicenses : addLostThefCertificate),
            actionButton('CONTINUAR', _loading),
            const SizedBox(height: 10),
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
          icon: Icon(uploaded ? Icons.check_circle : Icons.file_upload,
              color: Design.mintGreen),
        ),
      ],
    );
  }

  Widget actionButton(String text, Function onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Design.teal,
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: loading && text == 'CONTINUAR'
          ? const CircularProgressIndicator(color: Design.paleYellow)
          : Text(text),
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

  Future<void> _loading() async {
    if (!validSubmission()) return;
    setState(() {
      loading = true;
    });

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

    Design.showSnackBarGood(
        context, 'TRAMITE AGREGADO, REVISA TRAMITES PENDIENTES', Colors.green);
    //TODO: CORREGIR LA INTERACTIVIDAD CON LAS VENTANAS
    Navigator.pushReplacementNamed(context, '/user_homepage',
        arguments: widget.user);

    setState(() {
      loading = false;
    });
  }

  bool validSubmission() {
    if (selectedDriverLicensesType == null ||
        !ineUp ||
        !addressProofUp ||
        (widget.mode == 1 && !oldLicenseUp) ||
        (widget.mode == 2 && !lostTheftCertificateUp)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Por favor, completa todos los campos necesarios.',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Design.brightRed));
      return false;
    }
    return true;
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
