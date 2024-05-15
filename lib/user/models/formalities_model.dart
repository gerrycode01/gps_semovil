import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class Formalities {
  final UserModel user;
  String ineDoc;
  String addressProofDoc;
  final bool modeCero;
  String? paidProofDoc;
  String? previousDriversLicense;
  String? thefLostCertificate;
  int status;
  UserModel? trafficOfficer;

  Formalities(
      {required this.user,
      required this.ineDoc,
      required this.addressProofDoc,
      required this.modeCero,
      this.paidProofDoc,
      this.previousDriversLicense,
      this.thefLostCertificate,
      required this.status,
      this.trafficOfficer});

  factory Formalities.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Formalities(
        user: UserModel.fromMap(data?['user']),
        ineDoc: data?['ineDoc'],
        paidProofDoc: data?['paidProofDoc'],
        previousDriversLicense: data?['previousDriversLicense'],
        thefLostCertificate: data?['thefLostCertificate'],
        modeCero: data?['modeCero'],
        addressProofDoc: data?['addressProofDoc'],
        status: data?['status'],
        trafficOfficer: data?['trafficOfficer'] != null
            ? UserModel.fromMap(data!['trafficOfficer'])
            : null);
  }

  Map<String, dynamic> toJSON() {
    return {
      'user': {
        'curp': user.curp,
        'doccurp': user.doccurp,
        'names': user.names,
        'lastname': user.lastname,
        'lastname2': user.lastname2,
        'address': user.address,
        'docaddress': user.docaddress,
        'email': user.email,
        'phone': user.phone,
        'birthdate': user.birthdate,
        'bloodtype': user.bloodtype,
        'rol': user.rol,
        'profilePhoto': user.profilePhoto,
      },
      'ineDoc': ineDoc,
      'addressProofDoc': addressProofDoc,
      'modeCero': modeCero,
      'paidProofDoc': paidProofDoc,
      'previousDriversLicense': previousDriversLicense,
      'thefLostCertificate': thefLostCertificate,
      'status': status,
      'trafficOfficer': {
        'trafficOfficer': trafficOfficer?.curp ?? '',
        'email': trafficOfficer?.email ?? '',
        'rol': trafficOfficer?.rol ?? '',
      },
    };
  }
}
