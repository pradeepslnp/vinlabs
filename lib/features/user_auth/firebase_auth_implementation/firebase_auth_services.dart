import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../global/common/toast.dart';

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(
            message: 'The email address is already in use.', isthis: true);
      } else {
        showToast(message: 'An error occurred: ${e.code}', isthis: false);
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    firebaseFirestore = FirebaseFirestore.instance;
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      var update = {"email": email, "password": password};
      await firebaseFirestore.collection('User').doc().set(update);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.', isthis: false);
      } else {
        showToast(message: 'An error occurred: ${e.code}', isthis: false);
      }
    }
    return null;
  }
}
