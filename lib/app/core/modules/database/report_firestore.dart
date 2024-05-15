
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../user/models/report_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


Future<List<ReportModel>> getAllReports() async{
try {
final querySnapshot = await db.collection('report').get();
print("Operación completada exitosamente");
return querySnapshot.docs
    .map((docSnapshot) => ReportModel.fromFirestore(docSnapshot))
    .toList();
} catch (e) {
print("Error obteniendo lista de reportes: $e");
return []; // Devuelve una lista vacía en caso de error
}
}