import 'package:flutter/material.dart';
import 'package:gps_semovil/user/controllers/news_controller.dart';


class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();

}


class _NewsState extends State<News> {
  late List<News> _newsList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNewsList();
  }

  Future<void> loadNewsList() async{
    _newsList = await News_controller.getAllNews() as List<News>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _newsList.length, // Número de noticias, puedes modificar esto según la fuente de datos
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () async {},
              child: const Card(
                margin: const EdgeInsets.all(8),
                child: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          // Aquí se mostrará el logo
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child:
                                Icon(Icons.directions_car, color: Colors.white),
                          ),
                          Text('05/05/2024 14:00',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Título de la Noticia',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          'Descripción breve de la noticia donde se explica el contenido principal...'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('Leer más...',
                              style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
