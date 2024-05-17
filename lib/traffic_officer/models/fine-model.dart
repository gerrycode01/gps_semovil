import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FineModel {
  String? id;
  String? place;
  Timestamp? date;
  String? municipality;
  Map<String, dynamic>? user;
  Map<String, dynamic>? trafficOfficer;
  List<String>? articles;  // Lista para los artículos
  List<String>? justifications;  // Lista para las justificaciones
  String? status;

  FineModel({
    this.id,
    this.place,
    this.date,
    this.municipality,
    this.user,
    this.trafficOfficer,
    this.articles,
    this.justifications,
    this.status,
  });

  Map<String, dynamic> toJSON() {
    return {
      'place': place,
      'date': date,
      'municipality': municipality,
      'user': user,
      'trafficOfficer': trafficOfficer,
      'articles': articles,  // Guardar lista de artículos
      'justifications': justifications,  // Guardar lista de justificaciones
      'status': status
    };
  }

  factory FineModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    return FineModel(
      id: snapshot.id,
      place: data?['place'],
      date: data?['date'],
      municipality: data?['municipality'],
      user: data?['user'],
      trafficOfficer: data?['trafficOfficer'],
      articles: List<String>.from(data?['articles'] ?? []),
      justifications: List<String>.from(data?['justifications'] ?? []),
      status: data?['status'],
    );
  }

  String formattedDate() {
    if (date != null) {
      DateTime dateTime = date!.toDate();
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    } else {
      return 'Fecha no disponible';
    }
  }
}
