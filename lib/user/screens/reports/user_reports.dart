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
  List<ReportModel> _reportsList = []; // Esta lista debería ser cargada desde una base de datos

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  void loadReports() async {
    try {
      List<ReportModel> news = await getReportsByUser(widget.user.curp);
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
      ),
      body: ListView.builder(
        itemCount: _reportsList.length,
        itemBuilder: (context, index) {
          ReportModel report = _reportsList[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: ListTile(
           //   leading: Image.network(report.evidence?? "", width: 50, height: 50, fit: BoxFit.cover),
              title: Text(report.reportType?? ""),
              subtitle: Text(report.description?? ""),
              isThreeLine: true,
              trailing: Text(report.status?? ""),
              onTap: () {
                // Aquí puedes implementar una acción al tocar cada reporte, por ejemplo, mostrar detalles
              },
            ),
          );
        },
      ),
    );
  }
}
