import 'package:flutter/material.dart';
import 'package:gps_semovil/administrator/screens/administrator_asign_reports.dart';
import 'package:gps_semovil/administrator/screens/administrator_news.dart';
import 'package:gps_semovil/administrator/screens/traffic_officer_admin/administrator_trafic_oficer_home.dart';
import 'package:gps_semovil/app/core/login.dart';
import 'package:gps_semovil/user/models/user_model.dart';

import '../../app/core/design.dart';
import 'formalities_admin/list_formalities.dart';

class AdministradorHomePage extends StatelessWidget {
  final UserModel admin;

  const AdministradorHomePage({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdministratorHomePage(),
    );
  }
}

class AdministratorHomePage extends StatefulWidget {
  const AdministratorHomePage({super.key});

  @override
  State<AdministratorHomePage> createState() => _AdministratorHomePageState();
}

class _AdministratorHomePageState extends State<AdministratorHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    NewsPage(), // Placeholder widget for News
    ReportsPage(), // Placeholder widget for Reports
    PaymentsPage(), // Placeholder widget for Payments
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador',
            style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
        centerTitle: true,
        foregroundColor: Design.paleYellow,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Admin Name",
                  style: TextStyle(color: Design.paleYellow)),
              accountEmail: Text("admin@example.com",
                  style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0, color: Design.seaGreen),
                ),
              ),
              decoration: BoxDecoration(
                color: Design.teal,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.note_alt_sharp),
              title: const Text('Tramites'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (b) => const ListFormalities()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.traffic),
              title: const Text('Tránsitos'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeAdminTraficOfficer()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervisor_account),
              title: const Text('Usuarios'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdministratorNews()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Reportes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AdministratorAsignReports()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Pagos'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const Login()));
              },
            ),
          ],
        ),
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_sharp),
            label: 'Tramites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pagos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Placeholder widgets for each page
class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Noticias Más Actuales"));
  }
}

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Reportes de Usuarios"));
  }
}

class PaymentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Pagos Más Actuales"));
  }
}
