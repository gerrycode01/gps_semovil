import 'package:flutter/material.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:intl/intl.dart';

import 'modules/authentication/authentication.dart';
import 'modules/database/constantes.dart';
import 'modules/database/firestore.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate'),
        centerTitle: true,
        backgroundColor: Colors.green, // Adjust the color to match your theme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos personales',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Nombre(s)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: lastnameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Apellido paterno',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: lastname2Controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Apellido materno',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: birthdateController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Fecha de nacimiento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              readOnly: true,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd')
                      .format(pickedDate); // Formato que prefieras
                  birthdateController.text =
                      formattedDate; // Setea el texto del campo con la fecha
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: curpController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'CURP',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Telefono',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedBloodType,
              items: Const.bloodtypes.map((String bloodType) {
                return DropdownMenuItem<String>(
                  value: bloodType,
                  child: Text(bloodType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedBloodType = newValue;
                });
              },
              hint: const Text('Selecciona un tipo de sangre'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Domicilio',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: address1Controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.orange[100],
                      hintText: 'Calle',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: address2Controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.orange[100],
                      hintText: 'No',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Espacio entre las filas
            TextFormField(
              controller: address3Controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Colonia',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: address4Controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Localidad',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Cuenta',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Correo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
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
                      Colors.green), // Color de fondo
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Color del texto
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
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
          bloodtype: selectedBloodType);

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
