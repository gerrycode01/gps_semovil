import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<int> getNumberOfFormalities() async {
  try {
    // Referencia al documento específico
    DocumentReference docRef = db.collection('counting').doc('formalities');

    // Obtener el documento
    DocumentSnapshot docSnapshot = await docRef.get();

    // Verificar si el documento existe y tiene el campo deseado
    if (docSnapshot.exists && docSnapshot.data() != null) {
      // Extraer el campo que contiene el número de formalidades
      int numberOfFormalities = docSnapshot.get('total');
      return numberOfFormalities;
    } else {
      // Manejar el caso en que el documento no existe o falta el campo
      print("Documento no encontrado o campo 'total' ausente");
      return 0; // Retornar cero o manejar según el caso de uso
    }
  } catch (e) {
    // Manejo de errores, por ejemplo, permisos insuficientes, problemas de red, etc.
    print("Error al obtener el número de formalidades: $e");
    return 0; // Retornar cero o manejar según el caso de uso
  }
}

Future<void> addFormalities(Formalities formalities) async {
  await db
      .collection('formalities')
      .doc(formalities.idFormalities.toString())
      .set(formalities.toJSON());
}
