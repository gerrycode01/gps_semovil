import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? curp;
  final String? names;
  final String? lastname;
  final String? lastname2;
  final String? email;
  final String? phone;
  final String? borndate;
  final String? blood_type;

  UserModel(
      {this.id,
      this.curp,
      this.names,
      this.lastname,
      this.lastname2,
      this.email,
      this.phone,
      this.borndate,
      this.blood_type
      });

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      id: snapshot['id'],
      curp: snapshot['curp'],
      names: snapshot['names'],
      lastname: snapshot['lastname'],
      lastname2: snapshot['lastname2'],
      email: snapshot['email'],
      phone: snapshot['phone'],
      borndate: snapshot['borndate'],
      blood_type: snapshot['blood_type'],

    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'curp': curp,
      'names': names,
      'lastname': lastname,
      'lastname2': lastname2,
      'email': email,
      'phone': phone,
      'borndate': borndate,
      'blood_type': blood_type,
    };
  }
}
