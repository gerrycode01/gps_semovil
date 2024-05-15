
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../user/models/report_model.dart';
import '../../../../user/models/user_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


Future<List<ReportModel>> getAllReports() async{
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

Future<void> attendReport(UserModel model, String id) async{
  try{
    db.collection('report').doc(id).update({'status': 'Atendiendo'});
    db.collection('report').doc(id).update({'officer': model.toSmallJSON()});
    print("Reporte atendido exitosamente");

  } catch (e) {
    print("Error atendiendo reporte: $e");
  }
}

Future<void> finalizeReport(String id) async {
  try{
    db.collection('report').doc(id).update({'status': 'Atendido'});
    print("Reporte finalizado exitosamente");

  } catch (e) {
    print("Error finalizando reporte: $e");
  }
}

Future<void> addReport(ReportModel report) async {
  try{
    await db.collection('report').add(report.toJSON()).then((documentSnapshot) => print('Reporte subido correctamente'));
  } catch (e) {
    print ("Error al subir el reporte: $e");
  }
}

Future<List<ReportModel>> getReportsByUser(String curp) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance.collection('report')
        .where('user.curp', isEqualTo: curp) // Accediendo a la CURP dentro del mapa 'user'
        .get();

    return querySnapshot.docs
        .map((docSnapshot) => ReportModel.fromFirestore(docSnapshot))
        .toList();
  } catch (e) {
    print("Error buscando reportes por CURP de usuario: $e");
    return [];
  }
}