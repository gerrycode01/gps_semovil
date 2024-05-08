import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/login.dart';

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
            icon: const Icon(Icons.settings, color: Colors.white,),
            onPressed: () {

            },
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          InkWell(
            onTap: () {
              // Aquí colocas lo que deseas que ocurra cuando se toque la imagen
              print('Imagen clickeada');
            },
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red,
              // Si tienes una URL de imagen, usa Image.network()
              // Si tienes una imagen local, usa Image.asset()
              // Ejemplo usando Image.network():
              child: Image.network(
                'https://example.com/your-image.jpg',
                fit: BoxFit.cover,
              ),
            ),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Login()));
            },
            child: const Text('Cerrar sesion'),
          ),
        ],
      ),
    );
  }
}
