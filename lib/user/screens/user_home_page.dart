import 'package:flutter/material.dart';
import 'package:gps_semovil/user/screens/%20formalities/options.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('HOME', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.person),
            onPressed: () {
              // Acciones del ícono de usuario
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
            ), // Mensaje de bienvenida grande y en negritas
            SizedBox(height: 20), // Espacio entre el texto de bienvenida y los íconos
            IconButtonRow(icon: Icons.assignment, color: Colors.blue, label: "Trámites", onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Options()));
            }),
            IconButtonRow(icon: Icons.report, color: Colors.red, label: "Reportes", onPressed: () {}),
            IconButtonRow(icon: Icons.payment, color: Colors.purple, label: "Pagos", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class IconButtonRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onPressed;

  const IconButtonRow({
    Key? key,
    required this.icon,
    required this.color,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 60, // Aumenta el tamaño del ícono
            icon: Icon(icon, color: color),
            onPressed: onPressed,
          ),
          Text(label, style: TextStyle(fontSize: 16, color: color)), // Etiqueta debajo del ícono
        ],
      ),
    );
  }
}
