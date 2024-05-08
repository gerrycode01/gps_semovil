import 'package:flutter/material.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:gps_semovil/user/screens/%20formalities/options.dart';
import 'package:gps_semovil/user/screens/news/news.dart';
import 'package:gps_semovil/user/screens/user_settings.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key, required this.userModel});

  final UserModel userModel;

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserSettings(
                            userModel: widget.userModel,
                          ))).then((value) => setState(() {}));
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Bienvenido',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: <Widget>[
                IconActionButton(
                    icon: Icons.assignment,
                    color: Colors.blue,
                    label: "Trámites",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Options()));
                    }),
                IconActionButton(
                    icon: Icons.report,
                    color: Colors.red,
                    label: "Reportes",
                    onPressed: () {}),
                IconActionButton(
                    icon: Icons.payment,
                    color: Colors.purple,
                    label: "Pagos",
                    onPressed: () {}),
                IconActionButton(
                    icon: Icons.newspaper,
                    color: Colors.orange,
                    label: "Noticias",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const News()));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onPressed;

  const IconActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: 60,
          icon: Icon(icon, color: color),
          onPressed: onPressed,
        ),
        Text(label, style: TextStyle(fontSize: 16, color: color)),
      ],
    );
  }
}
