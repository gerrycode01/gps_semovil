import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_semovil/user/models/user_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<UserModel> getUser(String email) async {
  final ref = db.collection('user').doc(email).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel userModel, _) => userModel.toJSON(),
      );
  final docSnap = await ref.get();
  final user = docSnap.data(); // Convert to City object
  if (user != null) {
    print(user.email);
    return user;
  } else {
    print("No such document.");
    return UserModel(curp: '', email: '', rol: '', names: '', lastname: '');
  }
}

Future<UserModel?> getUserByCURP(String curp) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance.collection('user')
        .where('curp', isEqualTo: curp)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Obtén el primer documento de la consulta
      final docSnapshot = querySnapshot.docs.first;
      print(docSnapshot.toString());
      // Devuelve el modelo del primer usuario utilizando el método fromFirestore
      return UserModel.fromFirestore(docSnapshot, null); // Aquí el segundo argumento puede ser null o alguna SnapshotOptions si lo tienes configurado
    } else {
      // Si no se encuentran documentos, devuelve null
      print("No se encontró el usuario");
      return null;
    }
  } catch (e) {
    print("Error buscando usuario por CURP: $e");
    return null;
  }
}

Future<void> addUser(UserModel userModel) async {
  await db.collection('user').doc(userModel.email).set(userModel.toJSON());
}

Future<void> updateUser(UserModel userModel) async {
  try {
    final ref = FirebaseFirestore.instance.collection('user').doc(userModel.email);
    await ref.update(userModel.toJSON());
    print("Usuario actualizado correctamente");
  } catch (e) {
    print("Error actualizando usuario: $e");
    throw Exception('Error al actualizar usuario: $e');
  }
}
Future<List<UserModel>> getTrafficOfficers() async {
  try {
    final querySnapshot = await db.collection('user')
        .where('rol', isEqualTo: 'traffic_officer')
        .get();

    print("Número de oficiales encontrados: ${querySnapshot.docs.length}");  // Imprimir número de documentos obtenidos

    List<UserModel> officers = [];
    for (var doc in querySnapshot.docs) {
      print("Datos de oficial: ${doc.data()}");  // Imprimir datos de cada oficial
      officers.add(UserModel.fromFirestore(doc, null));
    }
    return officers;
  } catch (e) {
    print("Error al obtener los oficiales de tránsito: $e");
    return [];
  }
}

