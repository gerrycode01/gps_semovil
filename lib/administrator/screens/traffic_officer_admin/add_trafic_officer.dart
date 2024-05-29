import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/user_model.dart';

import '../../../app/core/modules/authentication/authentication.dart';
import '../../../app/core/modules/database/constants.dart';
import '../../../app/core/modules/database/user_firestore.dart';

class AddTrafficOfficer extends StatefulWidget {
  const AddTrafficOfficer({super.key});

  @override
  State<AddTrafficOfficer> createState() => _AddTrafficOfficerState();
}

class _AddTrafficOfficerState extends State<AddTrafficOfficer> {
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final lastname2Controller = TextEditingController();
  final birthdateController = TextEditingController();
  final curpController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedBloodType;
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final address3Controller = TextEditingController();
  final address4Controller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  bool passwordVisible = false;
  bool passwordVisible2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Registrar Oficial', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Design.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos personales',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Design.teal),
            ),
            const SizedBox(height: 10),
            Design.campoTexto(nameController, "Nombre(s)"),
            const SizedBox(height: 10),
            Design.campoTexto(lastnameController, "Apellido Paterno"),
            const SizedBox(height: 10),
            Design.campoTexto(lastname2Controller, "Apellido Materno"),
            const SizedBox(height: 10),
            Design.campoFecha(context, birthdateController, 'Fecha de nacimiento'),
            const SizedBox(height: 10),
            Design.campoTexto(curpController, "CURP"),
            const SizedBox(height: 10),
            Design.campoTexto(phoneController, "Teléfono"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedBloodType,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBloodType = newValue;
                    });
                  },
                  items: Const.bloodtypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: const Text('Selecciona un tipo de sangre', style: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Domicilio',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Design.teal),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Design.campoTexto(address1Controller, "Calle"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Design.campoTexto(address2Controller, "No."),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Design.campoTexto(address3Controller, "Colonia"),
            const SizedBox(height: 10),
            Design.campoTexto(address4Controller, "Localidad"),
            const SizedBox(height: 20),
            const Text(
              'Cuenta',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Design.teal),
            ),
            Design.campoTexto(emailController, "Correo electrónico"),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: password2Controller,
              obscureText: !passwordVisible2,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Confirmar contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible2 ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      passwordVisible2 = !passwordVisible2;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Design.teal),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(8.0),
                ),
                onPressed: () async {
                  try {
                    await registrarse();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error al registrar: $e'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: const Text('Registrarse'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registrarse() async {
    if (passwordController.text != password2Controller.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Las contraseñas no coinciden'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (curpController.text.isEmpty || emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('CURP y correo electrónico son obligatorios'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    var userCredential = await Authentication.registerUser(emailController.text, passwordController.text);
    if (userCredential != null) {
      UserModel userModel = UserModel(
        curp: curpController.text,
        doccurp: '',
        names: nameController.text,
        lastname: lastnameController.text,
        lastname2: lastname2Controller.text,
        address: '${address1Controller.text} ${address2Controller.text}, ${address3Controller.text}, ${address4Controller.text}',
        docaddress: '',
        email: emailController.text,
        phone: phoneController.text,
        birthdate: birthdateController.text,
        bloodtype: selectedBloodType,
        rol: 'traffic_officer',
        profilePhoto: '',
      );

      await addUser(userModel);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registro exitoso!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context);
    } else {
      throw Exception('Failed to create a Firebase user');
    }
  }
}
