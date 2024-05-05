import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: 5, // Número de noticias, puedes modificar esto según la fuente de datos
        itemBuilder: (context, index) {
          return const Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Aquí se mostrará el logo
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.directions_car, color: Colors.white),
                      ),
                      Text('05/05/2024 14:00', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Título de la Noticia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Descripción breve de la noticia donde se explica el contenido principal...'
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
