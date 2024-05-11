import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadFileToFirestorage(
    File file, String curp, String fileName) async {
  String url = '';
  Reference ref = storage.ref().child(curp).child(fileName);

  try {
    // Inicia la tarea de subida
    UploadTask uploadTask = ref.putFile(file);

    // Espera hasta que la subida haya sido completada
    TaskSnapshot snapshot = await uploadTask;
    // Cuando la subida es exitosa, obtiene la URL de descarga
    if (snapshot.state == TaskState.success) {
      url = await snapshot.ref.getDownloadURL();
      print("Upload is complete. URL: $url");
    } else {
      print("Upload failed with state: ${snapshot.state}");
      url = 'ERROR';
    }
  } catch (e) {
    print("Error during file upload: $e");
    url = 'ERROR';
  }

  return url;
}

Future<bool> deleteFileFromFirebaseStorage(String curp, String fileName) async {
  try {
    // Referencia al archivo que se desea eliminar
    Reference ref = storage.ref().child(curp).child(fileName);

    // Llamada al método delete para eliminar el archivo
    await ref.delete();
    print("Archivo eliminado correctamente.");
    return true;
  } catch (e) {
    // En caso de error, imprimirlo y devolver false
    print("Error al eliminar el archivo: $e");
    return false;
  }
}
