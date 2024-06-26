import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/login.dart';
import 'package:gps_semovil/app/core/modules/components/circular_image.dart';
import 'package:gps_semovil/traffic_officer/screens/traffic-officer_fines.dart';
import 'package:gps_semovil/traffic_officer/screens/traffic-officer_news.dart';
import 'package:gps_semovil/traffic_officer/screens/traffic-officer_reports.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class TrafficOfficerHomePage extends StatefulWidget {
  final UserModel trafficOfficer;

  const TrafficOfficerHomePage({super.key, required this.trafficOfficer});

  @override
  State<TrafficOfficerHomePage> createState() => _TrafficOfficerHomePageState();
}

class _TrafficOfficerHomePageState extends State<TrafficOfficerHomePage> {
  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Design.teal,
        title: const Text(
          'Inicio',
          style: TextStyle(color: Design.paleYellow),
        ),
        centerTitle: true,
        foregroundColor: Design.paleYellow,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName:
                  Text(widget.trafficOfficer.names), // Nombre del usuario
              accountEmail:
                  Text(widget.trafficOfficer.lastname), // Email del usuario
              currentAccountPicture: CircleAvatar(
                backgroundColor: Design.seaGreen,
                child: Text(
                  widget.trafficOfficer.names[0], // Primera letra del nombre
                  style:
                      const TextStyle(fontSize: 40.0, color: Design.paleYellow),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.teal, // Cambia al color que prefieras
              ),
            ),
            ListTile(
              leading: const Icon(Icons.newspaper, color: Colors.blue),
              title: const Text(
                'Noticias',
                style: TextStyle(color: Design.teal),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewsScreenOfficer()));
                // Cerrar el drawer
                // Navegación a Noticias
              },
            ),
            ListTile(
              leading: const Icon(Icons.report, color: Colors.green),
              title: const Text(
                'Reportes',
                style: TextStyle(color: Design.teal),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrafficOfficerReports(
                            trafficOfficer: widget.trafficOfficer)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.orange),
              title: const Text(
                'Multas',
                style: TextStyle(color: Design.teal),
              ),
              onTap: () {
                // Cerrar el drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrafficOfficerFines(
                            trafficOfficer: widget.trafficOfficer)));
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.door_back_door_outlined, color: Colors.red),
              title: const Text(
                'Cerrar sesion',
                style: TextStyle(color: Design.teal),
              ),
              onTap: () {
                // Cerrar el drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CircularImage(
              userModel: widget.trafficOfficer,
              radius: isLargeScreen
                  ? 150.0
                  : 100.0, // Mayor tamaño en pantallas grandes
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.trafficOfficer.names,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ' ${widget.trafficOfficer.lastname}',
                  // Asegúrate de ajustar según los datos
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Oficial de tránsito',
                  // Asegúrate de ajustar según el rol o título
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
