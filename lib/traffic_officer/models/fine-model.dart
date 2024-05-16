import 'package:cloud_firestore/cloud_firestore.dart';

class FineModel {
  String? id;
  String? place;
  Timestamp? date;
  String? municipality;
  Map<String, dynamic>? user;
  Map<String, dynamic>? trafficOfficer;
  String? article1;
  String? article2;
  String? article3;


  FineModel({
    this.id,
    this.place,
    this.date,
    this.municipality,
    this.user,
    this.trafficOfficer,
    this.article1,
    this.article2,
    this.article3
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
}