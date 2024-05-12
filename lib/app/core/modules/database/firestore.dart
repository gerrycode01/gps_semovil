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
    return UserModel(curp: '', email: '', rol: '');
  }
}

Future<void> addUser(UserModel userModel) async {
  await db.collection('user').doc(userModel.email).set(userModel.toJSON());
}

Future<void> updateUser(UserModel userModel) async {
  try {
    final ref = db.collection('user').doc(userModel.email);
    await ref.update(userModel.toJSON());
    print("Usuario actualizado correctamente");
  } catch (e) {
    print("Error actualizando usuario: $e");
  }
}
