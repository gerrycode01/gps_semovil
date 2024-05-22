import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_semovil/user/models/user_model.dart';

import '../../../../traffic_officer/models/fine-model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<UserModel?> getUserByPlate(String plate) async {
  try {
    final querySnapshot = await db
        .collection('user')
        .where('plates',
            arrayContains:
                plate) // Buscar si el array 'plates' contiene la placa especificada
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data();
      return UserModel.fromMap(userData);
    } else {
      print("No se encontro el usuario");
      return null;
    }
  } catch (e) {
    print("Error buscando usuario por placa: $e");
    return null;
  }
}

Future<void> fineUser(FineModel fine) async {
  try {
    await db
        .collection('fine')
        .add(fine.toJSON())
        .then((documentSnapshot) => print('Multa subida correctamente'));
  } catch (e) {
    print("Error al subir la multa: $e");
  }
}

Future<void> payFine(String? id) async {
  try{
    db.collection('fine').doc(id).update({'status': 'Atendido'});
    print("Pago realizado exitosamente");

  } catch (e) {
    print("Error finalizando reporte: $e");
  }
}


Future<List<FineModel>> getFinesByUser(String curp) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('fine')
        .where('user.curp',
            isEqualTo: curp) // Accediendo a la CURP dentro del mapa 'user'
        .get();

    return querySnapshot.docs
        .map((docSnapshot) => FineModel.fromFirestore(docSnapshot))
        .toList();
  } catch (e) {
    print("Error buscando multas por CURP de usuario: $e");
    return [];
  }
}
