import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/profile_model.dart';

class ProfileRemoteDatasource {
  final _collection = FirebaseFirestore.instance.collection('users');

  Future<void> addProfile(ProfileModel profile) async {
    await _collection.add(profile.toMap());
  }

  Future<ProfileModel?> getCurrentUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await _collection.doc(user.uid).get();
    if (!doc.exists) return null;

    return ProfileModel.fromMap(doc.id, doc.data()!);
  }
}
