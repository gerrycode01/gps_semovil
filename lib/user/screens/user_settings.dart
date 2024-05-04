import 'package:flutter/material.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Acción al presionar el ícono de configuración
              print('Configuración presionada');
            },
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.red,
            child: const Text('Imagen', style: TextStyle(color: Colors.white)), // Reemplazar con Image.network() o Image.asset() si tienes una imagen
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Nombre(s)'),
            subtitle: const Text('Juan Carlos'),
            leading: Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
          ),
          ListTile(
            title: const Text('Apellido Paterno'),
            subtitle: const Text('Díaz'),
            leading: Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
          ),
          ListTile(
            title: const Text('Apellido Materno'),
            subtitle: const Text('Moreno'),
            leading: Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(

            icon: const Icon(Icons.credit_card),
            label: const Text('Licencia digital'),
            onPressed: () {
              // Acción para Licencia digital
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Color de fondo
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Color del texto
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton.icon(
            icon: const Icon(Icons.payment),
            label: const Text('Formas de pago'),
            onPressed: () {
              // Acción para Formas de pago
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Color de fondo
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Color del texto
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.red,
              minimumSize: Size(double.infinity, 50),
            ),
            onPressed: () {
              // Acción para eliminar cuenta
            },
            child: const Text('Eliminar cuenta'),
          ),
        ],
      ),
    );
  }
}
