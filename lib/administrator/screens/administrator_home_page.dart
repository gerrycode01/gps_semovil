import 'package:flutter/material.dart';
import 'package:gps_semovil/administrator/screens/administrator_asign_reports.dart';
import 'package:gps_semovil/administrator/screens/administrator_news.dart';
import 'package:gps_semovil/user/models/user_model.dart';

import '../../app/core/design.dart';

class AdministradorHomePage extends StatelessWidget {
  final UserModel admin;

  const AdministradorHomePage({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  List<Widget> _pages = [
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
        title: const Text('Administrador', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
        centerTitle: true,
        foregroundColor: Design.paleYellow,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Admin Name", style: TextStyle(color: Design.paleYellow)),
              accountEmail: Text("admin@example.com", style: TextStyle(color: Colors.white)),
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
            ),ListTile(
              leading: Icon(Icons.note_alt_sharp),
              title: Text('Tramites'),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.traffic),
              title: Text('Tránsitos'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.supervisor_account),
              title: Text('Usuarios'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.newspaper),
              title: Text('Noticias'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdministratorNews()));
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text('Reportes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdministratorAsignReports()));
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Pagos'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar sesión'),
              onTap: () {},
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
    return Center(child: Text("Noticias Más Actuales"));
  }
}

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Reportes de Usuarios"));
  }
}

class PaymentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Pagos Más Actuales"));
  }
}
