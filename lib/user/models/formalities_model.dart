import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class Formalities {
  final int idFormalities;
  final String driverLicenseType;
  final UserModel user;
  final Timestamp date;
  String ineDoc;
  String addressProofDoc;
  final bool firsTime;
  String? oldDriversLicense;
  String? theftLostCertificate;
  String? paidProofDoc;
  int status;
  UserModel? trafficOfficer;

  Formalities(
      {required this.idFormalities,
      required this.driverLicenseType,
      required this.user,
      required this.date,
      required this.ineDoc,
      required this.addressProofDoc,
      required this.firsTime,
      this.oldDriversLicense,
      this.theftLostCertificate,
      this.paidProofDoc,
      required this.status,
      this.trafficOfficer});

  factory Formalities.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Formalities(
        idFormalities: data?['idFormalities'],
        driverLicenseType: data?['driverLicenseType'],
        user: UserModel.fromMap(data?['user']),
        date: data?['date'],
        ineDoc: data?['ineDoc'],
        addressProofDoc: data?['addressProofDoc'],
        firsTime: data?['firsTime'],
        oldDriversLicense: data?['oldDriversLicense'],
        theftLostCertificate: data?['theftLostCertificate'],
        paidProofDoc: data?['paidProofDoc'],
        status: data?['status'],
        trafficOfficer: data?['trafficOfficer'] != null
            ? UserModel.fromMap(data?['trafficOfficer'])
            : null);
  }

  Map<String, dynamic> toJSON() {
    return {
      'idFormalities': idFormalities,
      'driverLicenseType': driverLicenseType,
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
      'date': date,
      'ineDoc': ineDoc,
      'addressProofDoc': addressProofDoc,
      'firsTime': firsTime,
      'oldDriversLicense': oldDriversLicense,
      'theftLostCertificate': theftLostCertificate,
      'paidProofDoc': paidProofDoc,
      'status': status,
      'trafficOfficer': {
        'curp': trafficOfficer?.curp ?? '',
        'names': trafficOfficer?.names ?? '',
        'lastname': trafficOfficer?.lastname ?? '',
        'email': trafficOfficer?.email ?? '',
        'rol': trafficOfficer?.rol ?? '',
      },
    };
  }
}
