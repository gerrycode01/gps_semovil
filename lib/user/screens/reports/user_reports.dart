import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/modules/database/report_firestore.dart';
import 'package:gps_semovil/user/models/report_model.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:gps_semovil/user/screens/reports/user_add_reports.dart';

class UserReports extends StatefulWidget {
  final UserModel user;

  const UserReports({super.key, required this.user});

  @override
  State<UserReports> createState() => _UserReportsState();
}

class _UserReportsState extends State<UserReports> {
  List<ReportModel> _reportsList = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  void loadReports() async {
    try {
      List<ReportModel> reports = await getReportsByUser(widget.user.curp);
      setState(() {
        _reportsList = reports;
      });
    } catch (error) {
      print("Error cargando la lista de reportes: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size
    var size = MediaQuery.of(context).size;
    final bool isWideScreen = size.width > 600;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Design.paleYellow,
          backgroundColor: Design.teal,
          title: Text('Tus reportes', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserAddReports(user: widget.user),
                  ),
                ).then((_) => loadReports());
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Design.paleYellow,
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
            buildReportList('Reportado', isWideScreen),
            buildReportList('Atendiendo', isWideScreen),
            buildReportList('Atendido', isWideScreen),
          ],
        ),
      ),
    );
  }

  Widget buildReportList(String status, bool isWideScreen) {
    List<ReportModel> filteredReports = _reportsList.where((report) => report.status == status).toList();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWideScreen ? 3 : 1,
        childAspectRatio: isWideScreen ? 1 : 3,
      ),
      itemCount: filteredReports.length,
      itemBuilder: (context, index) {
        return reportCard(filteredReports[index], isWideScreen);
      },
    );
  }

  Widget reportCard(ReportModel report, bool isWideScreen) {
    return Card(
      elevation: 10,
      color: Design.seaGreen,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: isWideScreen ? 100 : 50, // Adjust height based on screen size
            width: double.infinity,
            child: Image.asset(
              'assets/images/choque.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(report.reportType ?? "Sin tipo", style: TextStyle(fontWeight: FontWeight.bold, color: Design.paleYellow, fontSize: isWideScreen ? 24 : 16)),
                SizedBox(height: 10),
                Text(report.description ?? "Sin descripción", style: TextStyle(color: Colors.white, fontSize: isWideScreen ? 18 : 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
