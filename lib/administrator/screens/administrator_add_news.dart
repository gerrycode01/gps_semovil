import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/modules/database/news_firestore.dart';
import 'package:gps_semovil/user/models/news_model.dart';

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
      appBar: AppBar(
        title: Text('Añadir Noticia', style: TextStyle(color: Design.paleYellow)),
        centerTitle: true,
        foregroundColor: Design.paleYellow,
        backgroundColor: Design.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detalles de la Noticia', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Design.teal)),
            const SizedBox(height: 20),
            Design.campoTexto(titleController, "Título de la Noticia"),
            const SizedBox(height: 20),
            Design.campoTexto(descriptionController, "Descripción"),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  NewsModel news = NewsModel(
                    title: titleController.text,
                    date: Timestamp.fromDate(DateTime.now()),
                    description: descriptionController.text,
                  );
                  addNew(news);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Noticia añadida correctamente"),
                        backgroundColor: Design.teal,
                      )
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Design.paleYellow, backgroundColor: Design.teal, // text color
                ),
                child: Text('Subir Noticia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
