import 'package:cloud_firestore/cloud_firestore.dart';

class News_controller{


  static Future<void> getAllNews() async{
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('collection');
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _collectionRef.get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      print(allData);
  }


}