import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/news_model.dart';

import '../../app/core/modules/database/news_firestore.dart';


class NewsScreenOfficer extends StatefulWidget {
  const NewsScreenOfficer({super.key});

  @override
  State<NewsScreenOfficer> createState() => _NewsScreenOfficerState();

}


class _NewsScreenOfficerState extends State<NewsScreenOfficer> {
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
        centerTitle: true,
        foregroundColor: Design.paleYellow,
        title: const Text('Noticias', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,

      ),
      body: ListView.builder(
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () async {},
              child: Card(
                color: Design.paleYellow,
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Design.teal,
                            child:
                            Icon(Icons.directions_car, color: Colors.white),
                          ),
                          Text("${_newsList[index].formattedDate()}",
                              style: TextStyle(color: Design.seaGreen)
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${_newsList[index].title ?? ''}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("${_newsList[index].description}"),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Leer más...',
                              style: TextStyle(color: Design.teal)),
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
