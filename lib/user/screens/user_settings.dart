import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/login.dart';
import 'package:gps_semovil/app/core/modules/components/circular_image.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class UserSettings extends StatefulWidget {
  final UserModel userModel;
  const UserSettings({super.key, required this.userModel});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 600; // Considera 600px como el breakpoint para una pantalla grande
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Design.paleYellow,
        title: Text('Cuenta', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Design.paleYellow),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: AnimationLimiter(
        child: ListView(
          padding: EdgeInsets.all(isLargeScreen ? 40 : 20), // Mayor padding en pantallas grandes
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              CircularImage(
                userModel: widget.userModel,
                radius: isLargeScreen ? 150.0 : 100.0, // Mayor tamaño en pantallas grandes
              ),
              const SizedBox(height: 20),
              userInfoCard('Nombre(s)', widget.userModel.names, Icons.person),
              userInfoCard('Apellido Paterno', widget.userModel.lastname, Icons.person_outline),
              userInfoCard('Apellido Materno', widget.userModel.lastname2!, Icons.person_outline),
              userInfoCard('Número de Teléfono', widget.userModel.phone ?? "", Icons.phone),
              userInfoCard('Tipo de Sangre', widget.userModel.bloodtype ?? "", Icons.bloodtype),
              userInfoCard('Correo Electrónico', widget.userModel.email ?? "", Icons.email),
              SizedBox(height: 10,),
              logoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget userInfoCard(String title, String value, IconData icon) {
    return Card(
      color: Design.seaGreen,
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width > 600 ? 100 : 8), // Menos margen en pantallas más anchas
      child: ListTile(
        leading: Icon(icon, color: Design.paleYellow),
        title: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(value, style: TextStyle(fontSize: 18, color: Design.lightOrange)),
      ),
    );
  }

  Widget logoutButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Login()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        ),
        child: Text('Cerrar sesión', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
