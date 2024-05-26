import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/login.dart';
import 'package:gps_semovil/app/core/modules/components/circular_image.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cuenta',
          style: TextStyle(color: Design.paleYellow),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Design.paleYellow,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Design.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircularImage(
            userModel: widget.userModel,
            radius: 100.0,
          ),
          const SizedBox(height: 20),
          buildUserInfo(context, 'Nombre(s)', widget.userModel.names),
          buildUserInfo(context, 'Apellido Paterno', widget.userModel.lastname),
          buildUserInfo(context, 'Apellido Materno', widget.userModel.lastname2!),
          buildUserInfo(context, 'Número de Teléfono', widget.userModel.phone?? ""),
          buildUserInfo(context, 'Tipo de Sangre', widget.userModel.bloodtype?? ""),
          buildUserInfo(context, 'Correo Electrónico', widget.userModel.email?? ""),
          const SizedBox(height: 60),
          Design.botonRed("Cerrar sesión", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          })
        ],
      ),
    );
  }

  Widget buildUserInfo(BuildContext context, String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Design.teal),
      ),
      subtitle: Text(subtitle),
      leading: Icon(Icons.person,
          color: Theme.of(context).colorScheme.secondary),
      trailing: title == 'Nombre(s)' ? IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {},
      ) : null,
    );
  }
}
