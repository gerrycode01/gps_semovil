import 'package:flutter/material.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class CircularImage extends StatelessWidget {
  final UserModel userModel;
  final double radius;

  const CircularImage({super.key, required this.userModel, this.radius = 20.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(
            "Imagen tocada"); // Aquí puedes añadir la lógica que necesites ejecutar al tocar la imagen
      },
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.orange, // Color de fondo cuando no hay imagen
          backgroundImage: userModel.profilePhoto!.isNotEmpty
              ? NetworkImage(userModel.profilePhoto!)
              : null,
          child: userModel.profilePhoto!.isEmpty
              ? Icon(Icons.person, size: radius)
              : null, // Muestra un icono si no hay imagen
        ),
    );
  }
}
