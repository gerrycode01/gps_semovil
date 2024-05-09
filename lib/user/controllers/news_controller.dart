import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

class News_controller {

  static Future<void> getAllNews() async{
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('news');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // querySnapshot.docs
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  }



}
