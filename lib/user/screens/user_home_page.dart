import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:gps_semovil/user/screens/%20formalities/options.dart';
import 'package:gps_semovil/user/screens/fines/fines_screen.dart';
import 'package:gps_semovil/user/screens/news_screen.dart';
import 'package:gps_semovil/user/screens/reports/user_reports.dart';
import 'package:gps_semovil/user/screens/user_settings.dart';

class UserHomePage extends StatefulWidget {
  final UserModel user;
  const UserHomePage({super.key, required this.user});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Design.teal,
        title: const Text('Bienvenido', style: TextStyle(color: Design.paleYellow)),
        actions: [
          IconButton(
            color: Design.paleYellow,
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserSettings(
                        userModel: widget.user,
                      ))).then((value) => setState(() {}));
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/secre11.png"),
          SizedBox(
            height: 30,
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
                    color: Design.teal,
                    label: "Trámites",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Options(user: widget.user,)));
                    }),
                IconActionButton(
                    icon: Icons.report,
                    color: Design.teal,
                    label: "Reportes",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserReports(
                                user: widget.user,
                              ))).then((value) => setState(() {}));
                    }),
                IconActionButton(
                    icon: Icons.payment,
                    color: Design.teal,
                    label: "Pagos",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FinesScreen(
                                user: widget.user,
                              ))).then((value) => setState(() {}));
                    }),
                IconActionButton(
                    icon: Icons.newspaper,
                    color: Design.teal,
                    label: "Noticias",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewsScreen()));
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
