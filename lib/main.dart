import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:gps_semovil/login.dart';
import 'package:gps_semovil/registrarse.dart';
import 'package:gps_semovil/usuario/principal.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MaterialApp',
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/registrar': (context) => const Registrar(),
          '/home/usuario' : (context) => const UsuarioPage()
        });
  }
}
