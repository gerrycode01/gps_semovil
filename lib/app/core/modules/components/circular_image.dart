import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/firestore.dart';
import 'package:gps_semovil/app/core/modules/database/storage.dart';
import 'package:gps_semovil/app/core/modules/select_image.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class CircularImage extends StatefulWidget {
  final UserModel userModel;
  final double radius;

  const CircularImage({super.key, required this.userModel, this.radius = 20.0});

  @override
  State<CircularImage> createState() => _CircularImageState();
}

class _CircularImageState extends State<CircularImage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: acciones,
      child: SizedBox(
        width: widget.radius * 2, // Ancho del contenedor
        height: widget.radius * 2, // Altura del contenedor
        child: _loading
            ? const CircularProgressIndicator()
            : CircleAvatar(
                radius: widget.radius,
                backgroundColor:
                    Colors.orange, // Color de fondo cuando no hay imagen
                backgroundImage: widget.userModel.profilePhoto!.isNotEmpty
                    ? NetworkImage(widget.userModel.profilePhoto!)
                    : null,
                child: widget.userModel.profilePhoto!.isEmpty
                    ? Icon(Icons.person, size: widget.radius)
                    : null, // Muestra un icono si no hay imagen
              ),
      ),
    );
  }

  void acciones() async {
    final image = await getImage();
    final imageToUpload = File(image!.path);

    setState(() {
      _loading = true;
    });

    final url = await uploadFileToFirestorage(
        imageToUpload, widget.userModel.curp!, 'profilePhoto');
    widget.userModel.profilePhoto = url;
    if (url != 'ERROR') {
      await updateUser(widget.userModel);
    }

    setState(() {
      _loading = false;
    });
  }
}
