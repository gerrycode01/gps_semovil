import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/user_model.dart';

import 'modules/authentication/authentication.dart';
import 'modules/database/constants.dart';
import 'modules/database/user_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('Registrate',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Design.teal, // Adjust the color to match your theme
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
            const SizedBox(
              height: 10,
            ),
            Design.campoTexto(lastnameController, "Apellido Paterno"),
            const SizedBox(height: 10),
            Design.campoTexto(lastname2Controller, "Apellido Materno"),
            const SizedBox(height: 10),
            Design.campoFecha(
                context, birthdateController, 'Fecha de nacimiento'),
            const SizedBox(height: 10),
            Design.campoTexto(curpController, "CURP"),
            const SizedBox(height: 10),
            Design.campoTexto(phoneController, "Telefono"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.orange[100], // Fondo naranja claro
                borderRadius: BorderRadius.circular(30), // Bordes redondeados
                border: Border.all(
                    color: Colors.transparent), // Sin bordes visibles
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedBloodType,
                  // Valor actual seleccionado
                  isExpanded: true,
                  // Expande el dropdown a todo el ancho del contenedor
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  // Icono del dropdown
                  iconSize: 24,
                  // Tamaño del icono
                  elevation: 16,
                  // Elevación para sombra (opcional)
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  // Estilo del texto dentro del dropdown
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBloodType =
                          newValue; // Cambia el valor seleccionado
                    });
                  },
                  items: Const.bloodtypes
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          value), // Muestra cada tipo de sangre como opción
                    );
                  }).toList(),
                  hint: const Text('Selecciona un tipo de sangre',
                      style: TextStyle(
                          color: Colors
                              .black)), // Texto de pista cuando no hay nada seleccionado
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Domicilio',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Design.teal),
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
            const SizedBox(height: 10), // Espacio entre las filas
            Design.campoTexto(address3Controller, "Colonia"),
            const SizedBox(height: 10),
            Design.campoTexto(address4Controller, "Localidad"),
            const SizedBox(height: 20),
            const Text(
              'Cuenta',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Design.teal),
            ),
            Design.campoTexto(emailController, "Correo electronico"),
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
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
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
                  icon: Icon(
                    passwordVisible2 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible2 = !passwordVisible2;
                    });
                  },
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: termsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      termsAccepted = value!;
                    });
                  },
                ),
                const Text('Acepto términos y condiciones'),
              ],
            ),

            SizedBox(
              width: double.infinity,
              // Asegura que el botón se expanda para llenar el ancho
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Design.teal
                  ), // Color de fondo
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Color del texto
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(8.0),
                ),
                onPressed: termsAccepted
                    ? () async {
                        try {
                          registrarse();
                        } catch (e) {
                          // Muestra el SnackBar en caso de error
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error al registrar: $e'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    : null,
                // Deshabilita el botón si los términos no están aceptados
                child: const Text('Registrarse'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registrarse() async {
    await Authentication.registerUser(
            emailController.text, passwordController.text)
        .then((value) async {
      if (!value) {
        print('ERROR AL REGISTRAR USUARIO');
        return;
      }
      UserModel userModel = UserModel(
          curp: curpController.text,
          doccurp: '',
          names: nameController.text,
          lastname: lastnameController.text,
          lastname2: lastname2Controller.text,
          address:
              '${address1Controller.text} ${address2Controller.text}, ${address3Controller.text}, ${address4Controller.text}',
          docaddress: '',
          email: emailController.text,
          phone: phoneController.text,
          birthdate: birthdateController.text,
          bloodtype: selectedBloodType,
          rol: 'user',
          profilePhoto: '');

      await addUser(userModel).then((_) {
        // Muestra el SnackBar en caso de éxito
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Registro exitoso!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        )); // Cierra la ventana después de mostrar el SnackBar
        Navigator.pop(context);
      });
    });
  }
}
