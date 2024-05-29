import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../user/models/news_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<NewsModel>> getAllNews() async {
  try {
    // Suponiendo que el campo de fecha en los documentos se llama 'date'
    final querySnapshot = await db.collection('news')
        .orderBy('date', descending: true) // Ordena por el campo 'date' de manera descendente
        .get();
    print("Operación completada exitosamente");
    return querySnapshot.docs
        .map((docSnapshot) => NewsModel.fromFirestore(docSnapshot))
        .toList();
  } catch (e) {
    print("Error obteniendo lista de noticias: $e");
    return []; // Devuelve una lista vacía en caso de error
  }
}

Future<void> addNew(NewsModel news) async{
  try{
    await db.collection('news').add(news.toJSON()).then((documentSnapshot) => print('Noticia subida correctamente'));
  } catch (e) {
    print ("Error al subir la noticia: $e");
  }
}

Future<void> updateNew(NewsModel news) async {
  try {
    final ref = db.collection('news').doc(news.id);
    await ref.update(news.toJSON());
    print("Noticia actualizada correctamente");
  } catch (e) {
    print("Error actualizando noticia: $e");
  }
}

Future<void> deleteNew(String? id) async{
  try{
    final ref = db.collection('news').doc(id);
    await ref.delete();
    print("Noticia eliminada correctamente");
  }
  catch (e) {
    print("Error actualizando noticia: $e");
  }
}







