import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static Future<bool> checkUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> registerUser(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña es muy débil.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('La cuenta ya está registrada.');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  static Future<bool> loginUser(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No existe el usuario proporcionado');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Contraseña incorrecta');
        return false;
      }
      return false;
    }
  }

  static Future<bool> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      print('Logout error');
      return false;
    }
  }
}
