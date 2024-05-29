import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:intl/intl.dart';

import '../../app/core/modules/database/user_firestore.dart';

class ChangeUserData extends StatefulWidget {
  final UserModel userModel;
  const ChangeUserData({super.key, required this.userModel});

  @override
  State<ChangeUserData> createState() => _ChangeUserDataState();
}

class _ChangeUserDataState extends State<ChangeUserData> {
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _lastname2Controller = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _streetNoController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namesController.text = widget.userModel.names;
    _lastnameController.text = widget.userModel.lastname;
    _lastname2Controller.text = widget.userModel.lastname2 ?? "";
    _phoneController.text = widget.userModel.phone ?? "";
    _birthdateController.text = widget.userModel.birthdate ?? "";
    _curpController.text = widget.userModel.curp;
    _streetController.text = widget.userModel.address ?? "";
    _streetNoController.text =
        ""; // Supongamos que tienes esta información separada
    _neighborhoodController.text =
        ""; // Supongamos que tienes esta información separada
    _localityController.text =
        ""; // Supongamos que tienes esta información separada
    _bloodTypeController.text = widget.userModel.bloodtype ?? "";
    _emailController.text = widget.userModel.email ?? "";
    // No inicializamos los campos de contraseña por razones de seguridad
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualiza tus datos'),
        centerTitle: true,
        foregroundColor: Design.paleYellow,
        backgroundColor: Design.teal, // Adjust the color to match your theme
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
              controller: _namesController,
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
              controller: _lastnameController,
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
              controller: _lastname2Controller,
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
              controller: _birthdateController,
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
                  _birthdateController.text =
                      formattedDate; // Setea el texto del campo con la fecha
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _curpController,
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
              controller: _phoneController,
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
              controller: _bloodTypeController,
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
                    controller: _streetController,
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
                    controller: _streetNoController,
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
              controller: _neighborhoodController,
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
              controller: _localityController,
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
              controller: _emailController,
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
            SizedBox(
                width: double
                    .infinity, // Asegura que el botón se expanda para llenar el ancho
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed:
                      _updateUserData, // Asegura que esta función es llamada aquí
                  child: Text('Guardar cambios'),
                )),
          ],
        ),
      ),
    );
  }

  void _updateUserData() async {
    if (!_validateInputs()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor revisa los campos ingresados")),
      );
      return;
    }

    try {
      UserModel updatedUser = UserModel(
        curp: _curpController.text,
        names: _namesController.text,
        lastname: _lastnameController.text,
        lastname2: _lastname2Controller.text,
        email: _emailController.text,
        phone: _phoneController.text,
        birthdate: _birthdateController.text,
        rol: 'user', // Asume un rol o gestiónalo como necesites
      );

      await updateUser(updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Datos actualizados con éxito")),
      );
      Navigator.pop(context); // Opcional, dependiendo de la UX deseada
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al actualizar los datos: $e")),
      );
    }
  }

  bool _validateInputs() {
    // Aquí puedes añadir más validaciones según sea necesario
    return _namesController.text.isNotEmpty &&
        _lastnameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _curpController.text.isNotEmpty;
  }
}
