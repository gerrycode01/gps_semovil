import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
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
          backgroundColor: Design.teal,
          title: Text('Tus reportes',style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
              color: Colors.white,
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
        return reportCard(report);
      },
    );
  }

  Widget reportCard(ReportModel report) {
    return InkWell(
      onTap: () => showDialogForReport(report),
      child: Card(
        elevation: 10,
        color: Design.seaGreen,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 200, // Altura fija para la imagen
              width: double.infinity, // Asume el ancho completo del contenedor
              child: Image.asset(
                'assets/images/choque.jpg',
                fit: BoxFit.cover, // Cubre el tamaño del box manteniendo la relación de aspecto
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(report.reportType ?? "Sin tipo", style: TextStyle(fontWeight: FontWeight.bold, color: Design.paleYellow, fontSize: 30)),
                  Text(report.description ?? "Sin descripción", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDialogForReport(ReportModel report) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Detalles del Reporte', style: TextStyle(color: Design.teal)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Tipo: ${report.reportType}'),
                Text('Descripción: ${report.description}'),
                Text('Fecha: ${report.formattedDate()}'),
                Text('Estado: ${report.status}'),
                Text('GURB: ${report.GURB}'),
                Text('Tipo de Accidente: ${report.accidentType}'),
              ],
            ),
          ),
          actions: [
            Design.botonRed("Cerrar", () {
              Navigator.pop(context);
            })
          ],
        );
      },
    );
  }
}
