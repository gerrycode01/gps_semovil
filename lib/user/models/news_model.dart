import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NewsModel{
   String? id;
   String? title;
   String? description;
   Timestamp? date;

  NewsModel({
    this.id,
    this.title,
    this.description,
    this.date
  });


  Map<String, dynamic> toJSON() {
    return {
      'title':title,
      'description':description,
      'date':date
    };
  }


  // Método para formatear el campo de fecha como una cadena legible
  String formattedDate() {
    if (date != null) {
      // Convierte el Timestamp en un objeto DateTime
      DateTime dateTime = date!.toDate();
      // Formatea la fecha y hora como una cadena legible
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    } else {
      return 'Fecha no disponible';
    }
  }

  factory NewsModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return NewsModel(
      id: snapshot.id,
      title: data?['title'],
      description: data?['description'],
      date: data?['date'],
    );
  }

}