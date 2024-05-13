import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReportModel {
  String? reportType;
  String? description;
  Timestamp? date;
  String? place;
  String? evidence;
  // Reporte al transporte público
  String? GURB;
  // Accidente vial
  String? accidentType;
  String? status;
  Map<String, dynamic>? user;
  Map<String, dynamic>? officer;


  ReportModel(
      {this.reportType,
      this.description,
      this.date,
      this.place,
      this.GURB,
      this.evidence,
      this.accidentType,
      this.status,
      this.user,
      this.officer});

  factory ReportModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ReportModel(
      reportType: data?['title'],
      description: data?['description'],
      date: data?['date'],
      place: data?['place'],
      GURB: data?['GURB'],
      evidence: data?['evidence'],
      accidentType: data?['accidentType'],
      status: data?['status'],
      user: data?['user'],
      officer: data?['officer']
    );
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

  Map<String, dynamic> toJSON() {
    return {
      'reportType': reportType,
      'description': description,
      'date': date,
      'place': place,
      'evidence': evidence,
      'GURB': GURB,
      'accidentType': accidentType,
      'status': status,
      'user': user,
      'officer': officer,
    };
  }


}
