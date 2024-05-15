import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/report_firestore.dart';
import '../../models/report_model.dart';
import '../../models/user_model.dart';
import 'user_add_reports.dart';

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tus reportes'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserAddReports(user: widget.user),
                  ),
                ).then((_) => loadReports());
              },
              icon: Icon(Icons.add),
            ),
          ],
          bottom: TabBar(
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
        return Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: ListTile(

            title: Text(report.reportType ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(report.description ?? ""),
            isThreeLine: true,
            trailing: Text(report.accidentType ?? "", style: TextStyle(fontStyle: FontStyle.italic)),
            onTap: () {
              // Aquí puedes implementar una acción al tocar cada reporte, por ejemplo, mostrar detalles
            },
          ),
        );
      },
    );
  }

  Color getColorByStatus(String? status) {
    switch (status) {
      case 'Reportado':
        return Colors.red;
      case 'Atendiendo':
        return Colors.orange;
      case 'Atendido':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
