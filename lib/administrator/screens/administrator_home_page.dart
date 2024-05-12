import 'package:flutter/material.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class AdministradorHomePage extends StatelessWidget {
  const AdministradorHomePage({super.key, required this.admin});

  final UserModel admin;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADMINISTRADOR'),
      ),
    );
  }
}
