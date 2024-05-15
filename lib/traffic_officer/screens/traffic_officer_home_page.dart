import 'package:flutter/material.dart';
import 'package:gps_semovil/traffic_officer/screens/traffic-officer_reports.dart';
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
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TrafficOfficerReports(
                      trafficOfficer: widget.trafficOfficer,
                    ))).then((value) => setState(() {}));
          },
          child: Text("Reportes"),)
        ]
      ),
    );
  }
}
