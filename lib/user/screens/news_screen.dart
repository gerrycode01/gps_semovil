import 'package:flutter/material.dart';
import 'package:gps_semovil/user/controllers/news_controller.dart';
import 'package:gps_semovil/user/models/news_model.dart';


class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();

}


class _NewsState extends State<News> {
  List<NewsModel> _newsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNewsList();
  }

  Future<void> loadNewsList() async{
    try {
      List<NewsModel> news = await News_controller.getAllNews();
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
        title: const Text('Noticias'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () async {},
              child: Card(
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
                            backgroundColor: Colors.blue,
                            child:
                                Icon(Icons.directions_car, color: Colors.white),
                          ),
                          Text("${_newsList[index].formattedDate()}",
                              style: TextStyle(color: Colors.grey)
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
