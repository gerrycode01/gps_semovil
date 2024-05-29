import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app/core/design.dart';
import '../../app/core/modules/database/news_firestore.dart';
import '../../user/models/news_model.dart';
import 'administrator_news.dart';

class EditNews extends StatefulWidget {
  final NewsModel news;

  const EditNews({super.key, required this.news});


  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {


  @override
  Widget build(BuildContext context) {

    TextEditingController titleController = TextEditingController();
    titleController.text = widget.news.title ?? '';
    print(widget.news.title);
    TextEditingController descriptionController = TextEditingController();
    descriptionController.text = widget.news.description ?? '';
    TextEditingController fecha = TextEditingController();

    return Scaffold(
      body: ListView(
        children: [
          Design.campoTexto(titleController, "Título de la Noticia"),
          const SizedBox(height: 20),
          Design.campoTexto(descriptionController, "Descripción"),
          const SizedBox(height: 40),
          Design.campoFecha(context, fecha, widget.news.formattedDate()),
          Center(
            child: ElevatedButton(
              onPressed: () {
                widget.news.title = titleController.text;
                DateTime parsedDate = DateFormat('dd/MM/yyyy HH:mm').parse(fecha.text);
                widget.news.date = Timestamp.fromDate(parsedDate);
                widget.news.description = descriptionController.text;
                updateNew(widget.news);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Noticia actualizada correctamente"),
                      backgroundColor: Design.teal,
                    )
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdministratorNews()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Design.paleYellow, backgroundColor: Design.teal, // text color
              ),
              child: Text('Actualizar Noticia'),
            ),
          ),
          Design.botonRed("Eliminar noticia", () {
            deleteNew(widget.news.id);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Noticia eliminada correctamente"),
                  backgroundColor: Design.teal,
                )
            );
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdministratorNews()));
          })
        ],
      ),
    );
  }
}
