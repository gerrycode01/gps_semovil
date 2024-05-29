import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/news_model.dart';
import 'package:gps_semovil/app/core/modules/database/news_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsModel> _newsList = [];

  @override
  void initState() {
    super.initState();
    loadNewsList();
  }

  Future<void> loadNewsList() async {
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
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 1200 ? 4 : width > 900 ? 3 : width > 600 ? 2 : 1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Design.paleYellow,
        title: const Text('Noticias', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
      ),
      body: AnimationLimiter(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: _newsList.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: crossAxisCount,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: newsCard(_newsList[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget newsCard(NewsModel news) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Design.seaGreen,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Design.teal,
                    child: Icon(Icons.directions_car, color: Colors.white),
                  ),
                  Text(news.formattedDate(), style: TextStyle(color: Design.lightOrange)),
                ],
              ),
              SizedBox(height: 10),
              Text(
                news.title ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 10),
              Text(
                news.description ?? "",
                style: TextStyle(
                    fontSize: 14,
                    color: Design.paleYellow
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
