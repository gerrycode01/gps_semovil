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
  void initState() {
    // TODO: implement initState
    super.initState();
    //cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta',style: TextStyle(color: Design.paleYellow),),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Design.paleYellow,
            ),
            onPressed: () {

            },
          ),
        ],
        backgroundColor: Design.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircularImage(
            userModel: widget.userModel, // Reemplaza con tu URL de imagen
            radius: 100.0, // Tamaño del círculo
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Nombre(s)',style: TextStyle(color: Design.teal),),
            subtitle: Text(widget.userModel.names!),
            leading: Icon(Icons.person,
                color: Theme.of(context).colorScheme.secondary),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                widget.userModel.doccurp = '';
              },
            ),
          ),
          ListTile(
            title: const Text('Apellido Paterno',style: TextStyle(color: Design.teal),),
            subtitle: Text(widget.userModel.lastname!),
            leading: Icon(Icons.person,
                color: Theme.of(context).colorScheme.secondary),
          ),
          ListTile(
            title: const Text('Apellido Materno',style: TextStyle(color: Design.teal),),
            subtitle: Text(widget.userModel.lastname2!),
            leading: Icon(Icons.person,
                color: Theme.of(context).colorScheme.secondary),
          ),
          const SizedBox(height: 60),
          Design.botonRed("Cerrar sesión", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          })
        ],
      ),
    );
  }
}
