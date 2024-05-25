import 'package:flutter/material.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class PaymentInformation extends StatefulWidget {
  const PaymentInformation({super.key, required this.formalities});

  final Formalities formalities;

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.formalities.idFormalities.toString())),
      body: ListView(
        padding: const EdgeInsets.all(40),
        children: [
          const Text('INFORMACION DE PAGO'),
          const SizedBox(height: 20),
          Text(widget.formalities.driverLicenseType),
          TextButton(onPressed: (){

          }, child: const Text('PAGAR'))
        ],
      ),
    );
  }
}
