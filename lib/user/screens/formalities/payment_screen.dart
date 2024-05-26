import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
import 'package:gps_semovil/app/core/modules/select_image.dart';
import 'package:gps_semovil/app/core/modules/database/storage.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.formalities});

  final Formalities formalities;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  File? paymentProofPDF;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago de Trámite'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: Text(
                  'Tipo de Licencia: ${widget.formalities.driverLicenseType}'),
              subtitle: Text(
                  'Precio: \$${widget.formalities.price.toStringAsFixed(2)}'),
            ),
            ListTile(
              title: Text(
                  'Fecha de Solicitud: ${widget.formalities.date.toDate().toString()}'),
              subtitle: Text('CURP: ${widget.formalities.user.curp}'),
            ),
            const SizedBox(height: 20),
            paymentProofPDF == null
                ? ElevatedButton.icon(
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('Subir Comprobante de Pago'),
                    onPressed: () => _pickPaymentProof(),
                  )
                : Column(
                    children: [
                      const Text('Comprobante de Pago Cargado',
                          style: TextStyle(color: Colors.green)),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.replay),
                        label: const Text('Reemplazar Comprobante'),
                        onPressed: () => _pickPaymentProof(),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: paymentProofPDF == null ? null : _submitPayment,
                    child: const Text('Enviar Pago'),
                  ),
          ],
        ),
      ),
    );
  }

  void _pickPaymentProof() async {
    final pdf =
        await pickPDFFile();
    setState(() {
      paymentProofPDF = File(pdf!);
    });
  }

  void _submitPayment() async {
    if (paymentProofPDF == null) {
      Design.showSnackBarGood(context, 'FALTA SUBIR COMPROBANTE DE PAGO', Colors.red);
      return;

    }
    setState(() {
      loading = true;
    });
    String url = await uploadFileToFirestorage(
        paymentProofPDF!, widget.formalities.user.curp, 'payment_proof.pdf');
    widget.formalities.paidProofDoc = url;
    widget.formalities.status = 1; // Cambiar estado a 'EN REVISION'.

    await updateFormalities(widget.formalities);

    setState(() {
      loading = false;
    });

    Navigator.pop(
        context);
  }
}
