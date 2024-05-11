import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gps_semovil/app/core/login.dart';
import 'package:gps_semovil/app/core/sign_up.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:gps_semovil/user/screens/user_home_page.dart';
import 'package:gps_semovil/firebase_options.dart';


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
        title: 'SEMOVIL - Tu aliado en tránsito',
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/sign_up': (context) => const SignUp(),
          '/user_homepage' : (context) => UserHomePage(
            userModel: ModalRoute.of(context)!.settings.arguments as UserModel,
          ),
        });
  }
}
