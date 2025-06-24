import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_model.dart';

class AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> register(AuthModel authModel, String password) async {
    // Register ke Firebase Auth
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: authModel.email,
      password: password,
    );

    // Simpan ke collection users
    await _userCollection.doc(userCredential.user!.uid).set({
      'email': authModel.email,
      'name': authModel.name,
    });
  }
}