import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../user/models/report_model.dart';
import '../../../../user/models/user_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<ReportModel>> getAllReports() async {
  try {
    final querySnapshot = await db.collection('report').get();
    print("Reportes obtenidos exitosamente");
    return querySnapshot.docs
        .map((docSnapshot) => ReportModel.fromFirestore(docSnapshot))
        .toList();
  } catch (e) {
    print("Error obteniendo lista de reportes: $e");
    return []; // Devuelve una lista vacía en caso de error
  }
}

Future<void> attendReport(UserModel model, String id) async {
  try {
    db.collection('report').doc(id).update({'status': 'Atendiendo'});
    db.collection('report').doc(id).update({'officer': model.toSmallJSON()});
    print("Reporte atendido exitosamente");
  } catch (e) {
    print("Error atendiendo reporte: $e");
  }
}

Future<void> finalizeReport(String id) async {
  try {
    db.collection('report').doc(id).update({'status': 'Atendido'});
    print("Reporte finalizado exitosamente");
  } catch (e) {
    print("Error finalizando reporte: $e");
  }
}

Future<String?> addReport(ReportModel report) async {
  try {
    DocumentReference docRef =
        await db.collection('report').add(report.toJSON());
    print('Reporte subido correctamente. Document ID: ${docRef.id}');
    return docRef.id;
  } catch (e) {
    print("Error al subir el reporte: $e");
    return 'ERROR';
  }
}

Future<void> updateReport(ReportModel reportModel, String id) async {
  await db.collection('report').doc(id).update(reportModel.toJSON());
}

Future<void> assignReport(String id, UserModel? officer) async {
  try {
    db.collection('report').doc(id).update({'officer': officer?.toSmallJSON()});
    print("Reporte asignado exitosamente");
  } catch (e) {
    print("Error asignando reporte: $e");
  }
}

Future<List<ReportModel>> getReportsByOfficer(String curp) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('officer.curp',
            isEqualTo: curp) // Accediendo a la CURP dentro del mapa 'officer'
        .get();

    return querySnapshot.docs
        .map((docSnapshot) => ReportModel.fromFirestore(docSnapshot))
        .toList();
  } catch (e) {
    print("Error buscando reportes por CURP del oficial: $e");
    return [];
  }
}

Future<List<ReportModel>> getReportsByUser(String curp) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('user.curp',
            isEqualTo: curp) // Accediendo a la CURP dentro del mapa 'user'
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs
        .map((docSnapshot) => ReportModel.fromFirestore(docSnapshot))
        .toList();
  } catch (e) {
    print("Error buscando reportes por CURP de usuario: $e");
    return [];
  }
}

Future<List<ReportModel>> getUnassignedReports() async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('report')
        .where('status', isEqualTo: 'Reportado')
        .where('officer',
            isNull: true) // Agregar condición para que el officer sea nulo
        .get();

    return querySnapshot.docs
        .map((docSnapshot) => ReportModel.fromFirestore(docSnapshot))
        .toList();
  } catch (e) {
    print("Error buscando reportes no asignados: $e");
    return [];
  }
}
