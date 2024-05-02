import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TrafficOfficerHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TrafficOfficerHomePage extends StatefulWidget {
  const TrafficOfficerHomePage({super.key});

  @override
  State<TrafficOfficerHomePage> createState() => _TrafficOfficerHomePageState();
}

class _TrafficOfficerHomePageState extends State<TrafficOfficerHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
