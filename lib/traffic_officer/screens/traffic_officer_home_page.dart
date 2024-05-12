import 'package:flutter/material.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class TrafficOfficerHomePage extends StatefulWidget {
  const TrafficOfficerHomePage({super.key, required this.trafficOfficer});

  final UserModel trafficOfficer;

  @override
  State<TrafficOfficerHomePage> createState() => _TrafficOfficerHomePageState();
}

class _TrafficOfficerHomePageState extends State<TrafficOfficerHomePage> {
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.red,
    );
  }
}
