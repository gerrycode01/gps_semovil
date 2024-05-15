import 'package:flutter/material.dart';

import '../../app/core/modules/database/report_firestore.dart';
import '../../user/models/report_model.dart';
import '../../user/models/user_model.dart';


class TrafficOfficerReports extends StatefulWidget {
  const TrafficOfficerReports({super.key, required this.trafficOfficer});

  final UserModel trafficOfficer;

  @override
  State<TrafficOfficerReports> createState() => _TrafficOfficerReportsState();

}


class _TrafficOfficerReportsState extends State<TrafficOfficerReports> {
  List<ReportModel> _reportsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNewsList();
  }

  Future<void> loadNewsList() async{
    try {
      List<ReportModel> news = await getAllReports();
      setState(() {
        _reportsList = news;
      });
    } catch (error) {
      print("Error cargando la lista de noticias: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _reportsList.length,
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
                          Text("${_reportsList[index].formattedDate()}",
                              style: TextStyle(color: Colors.grey)
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${_reportsList[index].accidentType ?? ''}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("${_reportsList[index].description}"),
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
