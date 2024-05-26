import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
        title: const Text('Pago de Trámite', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
      ),
      body: AnimationLimiter(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                paymentInfoTile(),
                const SizedBox(height: 20),
                paymentProofSection(),
                const SizedBox(height: 20),
                loading ? const CircularProgressIndicator() : submitPaymentButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentInfoTile() {
    return ListTile(
      title: Text('Tipo de Licencia: ${widget.formalities.driverLicenseType}', style: TextStyle(color: Design.paleYellow)),
      subtitle: Text('Precio: \$${widget.formalities.price.toStringAsFixed(2)}', style: TextStyle(color: Design.lightOrange)),
      tileColor: Design.seaGreen,
    );
  }

  Widget paymentProofSection() {
    return paymentProofPDF == null
        ? ElevatedButton.icon(
      icon: const Icon(Icons.cloud_upload, color: Colors.white),
      label: const Text('Subir Comprobante de Pago'),
      onPressed: () => _pickPaymentProof(),
      style: ElevatedButton.styleFrom(
        foregroundColor: Design.paleYellow, backgroundColor: Design.teal, // button text color
      ),
    )
        : Column(
      children: [
        const Text('Comprobante de Pago Cargado', style: TextStyle(color: Colors.green)),
        ElevatedButton.icon(
          icon: const Icon(Icons.replay, color: Colors.white),
          label: const Text('Reemplazar Comprobante'),
          onPressed: () => _pickPaymentProof(),
          style: ElevatedButton.styleFrom(backgroundColor: Design.teal),
        ),
      ],
    );
  }

  Widget submitPaymentButton() {
    return ElevatedButton(
      onPressed: paymentProofPDF == null ? null : _submitPayment,
      child: const Text('Enviar Pago', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Design.paleYellow, backgroundColor: Design.teal, // button text color
      ),
    );
  }

  void _pickPaymentProof() async {
    final pdf = await pickPDFFile();
    if (pdf != null) {
      setState(() {
        paymentProofPDF = File(pdf);
      });
    }
  }

  void _submitPayment() async {
    if (paymentProofPDF == null) {
      Design.showSnackBarGood(context, 'FALTA SUBIR COMPROBANTE DE PAGO', Colors.red);
      return;
    }
    setState(() {
      loading = true;
    });
    String url = await uploadFileToFirestorage(paymentProofPDF!, widget.formalities.user.curp, 'payment_proof.pdf');
    widget.formalities.paidProofDoc = url;
    widget.formalities.status = 1; // Cambiar estado a 'EN REVISION'.

    await updateFormalities(widget.formalities);

    setState(() {
      loading = false;
    });

    Navigator.pop(context);
  }
}
