import 'package:flutter/material.dart';

import '../../app/core/design.dart';
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

  String? previousStatus;

  @override
  void initState() {
    super.initState();
    loadReportsList();
  }

  Future<void> loadReportsList() async {
    try {
      List<ReportModel> reports = await getAllReports();
      setState(() {
        _reportsList = reports;
      });
    } catch (error) {
      print("Error cargando la lista de reportes: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reportes',style: TextStyle(color: Design.paleYellow),),
          backgroundColor: Design.teal,
          bottom: TabBar(
            labelColor: Design.paleYellow,
            dividerColor: Design.seaGreen,
            automaticIndicatorColorAdjustment: true,
            indicatorColor: Design.seaGreen,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'Reportado'),
              Tab(text: 'Atendiendo'),
              Tab(text: 'Atendido'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildReportList('Reportado'),
            buildReportList('Atendiendo'),
            buildReportList('Atendido'),
          ],
        ),
      ),
    );
  }

  Widget buildReportList(String status) {
    List<ReportModel> filteredReports = _reportsList.where((report) => report.status == status).toList();
    return ListView.builder(
      itemCount: filteredReports.length,
      itemBuilder: (context, index) {
        ReportModel report = filteredReports[index];
        return InkWell(
          onTap: () async {},
          child: Card(
            elevation: 5,
            color: Design.paleYellow,
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
                        backgroundColor: Colors.teal
                        ,
                        child: Icon(Icons.directions_car, color: Colors.white),
                      ),
                      Text(
                        "${report.formattedDate()}",
                        style: TextStyle(color: Design.teal),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${report.accidentType ?? ''}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("${report.description}"),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [attendButton(report)],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget attendButton(ReportModel report) {
    if (report.status == "Reportado") {
      return Design.botonGreen("Atender", () {
        attendReport(widget.trafficOfficer, report.id ?? '');
        loadReportsList();
      });
    }
    if (report.status == "Atendiendo") {
      return Design.botonRed("Finalizar", () {
        finalizeReport(report.id ?? '');
        loadReportsList();
      });
    } else {
      return Design.textoConIcono(texto: "Finalizado", icono: Icons.check, color: Design.teal);
    }
  }
}
