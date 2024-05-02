import 'package:flutter/material.dart';

class ScreenAdministrador extends StatelessWidget {
  const ScreenAdministrador({super.key});

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
    return const Placeholder();
  }
}
