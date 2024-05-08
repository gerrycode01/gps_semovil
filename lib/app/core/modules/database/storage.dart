import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadFileToFirestorage(
    File file, String curp, String fileName) async {
  String url = '';
  Reference ref = storage.ref().child(curp).child(fileName);

  final uploadTask = ref.putFile(file);

  uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
    switch (taskSnapshot.state) {
      case TaskState.running:
        final progress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        print("Upload is $progress% complete.");
        break;
      case TaskState.paused:
        print("Upload is paused.");
        break;
      case TaskState.canceled:
        print("Upload was canceled");
        break;
      case TaskState.error:
        url = 'ERROR';
        // Handle unsuccessful uploads
        break;
      case TaskState.success:
        url = await taskSnapshot.ref.getDownloadURL();
        // Handle successful uploads on complete
        // ...
        break;
    }
  });
  return url;
}
