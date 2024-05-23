import 'package:flutter/material.dart';
import 'package:gps_semovil/administrator/screens/administrator_add_news.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/news_model.dart';

import '../../app/core/modules/database/news_firestore.dart';

class AdministratorNews extends StatefulWidget {
  const AdministratorNews({super.key});

  @override
  State<AdministratorNews> createState() => _AdministratorNewsState();
}



class _AdministratorNewsState extends State<AdministratorNews> {
  List<NewsModel> _newsList = [];

  @override
  void initState() {
    super.initState();
    loadNewsList();
  }

  Future<void> loadNewsList() async{
    try {
      List<NewsModel> news = await getAllNews();
      setState(() {
        _newsList = news;
      });
    } catch (error) {
      print("Error cargando la lista de noticias: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias', style: TextStyle(color: Design.paleYellow),),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Design.paleYellow,),
            onPressed: () {
              // Aquí puedes colocar la lógica para navegar a la página de añadir noticias
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdministratorAddNews()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _newsList.length, // Number of news items
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Column(
              children: [
                Ink.image(
                  image: AssetImage('assets/news${index % 4 + 1}.jpg'), // Example image asset
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_newsList[index].formattedDate()}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),Text(
                        "${_newsList[index].title ?? ''}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${_newsList[index].description}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    Design.botonGreen("MAS DETALLES", () {

                    })
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
