import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class FineModel {
  String? id;
  String? place;
  Timestamp? date;
  String? municipality;
  Map<String, dynamic>? user;
  Map<String, dynamic>? trafficOfficer;
  String? article1;
  String? justification1;
  String? article2;
  String? justification2;
  String? article3;
  String? justification3;
  String? status;

  FineModel({
    this.id,
    this.place,
    this.date,
    this.municipality,
    this.user,
    this.trafficOfficer,
    this.article1,
    this.justification1,
    this.article2,
    this.justification2,
    this.article3,
    this.justification3,
    this.status
  });

  factory FineModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return FineModel(
      id: snapshot.id,
      place: data?['place'],
      date: data?['date'],
      municipality: data?['municipality'],
      user: data?['user'],
      trafficOfficer: data?['trafficOfficer'],
      article1: data?['article1'],
      article2: data?['article2'],
      article3: data?['article3'],
      status: data?['status']
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'place': place,
      'date': date,
      'municipality':municipality,
      'user':user,
      'trafficOfficer': trafficOfficer,
      'article1':article1,
      'article2':article2,
      'article3':article3,
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
}