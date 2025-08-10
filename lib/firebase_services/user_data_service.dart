
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final UserDataService _instance = UserDataService._internal();
  factory UserDataService() => _instance;
  UserDataService._internal();


  Stream<Map<String, dynamic>?> get currentUserData {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(null);

    return _firestore.collection('users').doc(user.uid).snapshots().map(
            (snapshot) => snapshot.data()
    );
  }

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final snapshot = await _firestore.collection('users').doc(user.uid).get();
    return snapshot.data();
  }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Not authenticated");

    await _firestore.collection('users').doc(user.uid).update(data);
  }

  Future<void> updateLanguage(String language) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Not authenticated");

    await _firestore.collection('users').doc(user.uid).update({
      'language': language,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }
}