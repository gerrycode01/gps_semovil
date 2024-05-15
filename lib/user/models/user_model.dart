import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String curp; //
  String? doccurp; //
  String names; //
  String lastname; //
  String? lastname2; //
  String? address; //
  String? docaddress; //
  final String? email;
  String? phone; //
  String? birthdate; //
  String? bloodtype; //
  final String? rol; //
  String? profilePhoto; //

  UserModel(
      {required this.curp,
      this.doccurp,
      required this.names,
      required this.lastname,
      this.lastname2,
      this.address,
      this.docaddress,
      required this.email,
      this.phone,
      this.birthdate,
      this.bloodtype,
      required this.rol,
      this.profilePhoto});

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data?['rol'] == 'user') {
      return UserModel(
        curp: data?['curp'],
        doccurp: data?['doccurp'],
        names: data?['names'],
        lastname: data?['lastname'],
        lastname2: data?['lastname2'],
        address: data?['address'],
        docaddress: data?['docaddress'],
        email: data?['email'],
        phone: data?['phone'],
        birthdate: data?['birthdate'],
        bloodtype: data?['bloodtype'],
        rol: data?['rol'],
        profilePhoto: data?['profilePhoto'],
      );
    } else {
      return UserModel(
          curp: data?['curp'],
          email: data?['email'],
          rol: data?['rol'],
          names: data?['names'],
          lastname: data?['lastname']);
    }
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        curp: map['curp'],
        email: map['email'],
        rol: map['rol'],
        names: map['names'],
        lastname: map['lastname']);
  }

  Map<String, dynamic> toJSON() {
    return {
      'curp': curp,
      'doccurp': doccurp,
      'names': names,
      'lastname': lastname,
      'lastname2': lastname2,
      'address': address,
      'docaddress': docaddress,
      'email': email,
      'phone': phone,
      'birthdate': birthdate,
      'bloodtype': bloodtype,
      'rol': rol,
      'profilePhoto': profilePhoto,
    };
  }

  Map<String, dynamic> toSmallJSON() {
    return {
      'curp': curp,
      'names': names,
      'lastname': lastname,
      'lastname2': lastname2,
      'rol': rol,
    };
  }
}
