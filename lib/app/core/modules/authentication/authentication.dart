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

  static Future<String?> getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    } else {
      return user.email;
    }
  }

  static Future<bool> registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña es muy débil: ${e.message}');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('La cuenta ya está registrada: ${e.message}');
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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No existe el usuario proporcionado: ${e.message}');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Contraseña incorrecta: ${e.message}');
        return false;
      }
      return false;
    }
  }

  static Future<bool> signOutUser() async {
    try {
      FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      print('Error al cerrar sesión: ${e.message}');
      return false;
    }
  }

  static Future<bool> resetPassword(String email) async {
    try {
     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      print('Error al enviar el correo electrónico de restablecimiento de contraseña: ${e.message}');
      return false;
    }
  }


}
