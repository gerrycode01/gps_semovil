import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

class News_controller {

  static Future<List<NewsModel>> getAllNews() async{
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      final querySnapshot = await db.collection('news').get();
      print("Operación completada exitosamente");
      return querySnapshot.docs
          .map((docSnapshot) => NewsModel.fromFirestore(docSnapshot))
          .toList();
    } catch (e) {
      print("Error obteniendo lista de noticias: $e");
      return []; // Devuelve una lista vacía en caso de error
    }
  }



}
