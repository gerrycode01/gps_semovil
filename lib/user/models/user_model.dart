import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? curp; //
  String? doccurp; //
  String? names; //
  String? lastname; //
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
      {this.curp,
      this.doccurp,
      this.names,
      this.lastname,
      this.lastname2,
      this.address,
      this.docaddress,
      this.email,
      this.phone,
      this.birthdate,
      this.bloodtype,
      this.rol,
      this.profilePhoto
      });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
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
}
