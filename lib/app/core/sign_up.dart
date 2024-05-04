import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'modules/authentication/authentication.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool termsAccepted = false;
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwController = TextEditingController();
  bool _passwordVisible = false;
  final _dateController = TextEditingController();
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
            const SizedBox(height: 10,),
            TextFormField(
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
              controller: _dateController,
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
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // Formato que prefieras
                  _dateController.text = formattedDate; // Setea el texto del campo con la fecha
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
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
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange[100],
                hintText: 'Tipo de sangre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
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
              controller: userController,
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
              controller: passwController,
              obscureText: !_passwordVisible,
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
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwController,
              obscureText: !_passwordVisible,
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
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
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
              width: double.infinity, // Asegura que el botón se expanda para llenar el ancho
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Color de fondo
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Color del texto
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: termsAccepted ? () async {
                  try {
                    await Authentication.registerUser(userController.text, passwController.text);
                    // Muestra el SnackBar en caso de éxito
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Registro exitoso!'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        )
                    );
                    // Cierra la ventana después de mostrar el SnackBar
                    Navigator.pop(context);
                  } catch (e) {
                    // Muestra el SnackBar en caso de error
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error al registrar: $e'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        )
                    );
                  }
                } : null, // Deshabilita el botón si los términos no están aceptados
                child: const Text('Registrarse'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
