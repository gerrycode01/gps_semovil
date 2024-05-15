import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/news_firestore.dart';

import '../../app/core/design.dart';
import '../../user/models/news_model.dart';

class AdministratorAddNews extends StatefulWidget {
  const AdministratorAddNews({super.key});

  @override
  State<AdministratorAddNews> createState() => _AdministratorAddNewsState();
}

class _AdministratorAddNewsState extends State<AdministratorAddNews> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:[
          Design.campoTexto(titleController, "Titulo"),
          Design.campoTexto(descriptionController, "Descripcion"),
          Design.botonGreen("Subir noticia", () {
            NewsModel news = NewsModel(
              title: titleController.text,
              date: Timestamp.fromDate(DateTime.now()),
              description: descriptionController.text
            );
            addNew(news);

            //Para eliminar
            //deleteNew(news.id);

            //Para editar
            //updateNew(String news.id, news);
          })
        ]
      )
    );
  }
}
