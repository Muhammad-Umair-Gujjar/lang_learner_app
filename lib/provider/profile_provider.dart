
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<DocumentSnapshot>? _subscription;
  StreamSubscription<User?>? _authSubscription;

  String _currentLanguage = 'Italian';
  String? _email;
  String? _userName;

  String get currentLanguage => _currentLanguage;
  String? get userName => _userName;
  String? get email => _email;

  ProfileProvider() {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authSubscription = _auth.authStateChanges().listen((user) {
      _subscription?.cancel();

      _email = null;
      _userName = null;
      _currentLanguage = 'Italian';
      notifyListeners();

      if (user != null) {
        _email = user.email;
        _subscription = _firestore
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          final data = snapshot.data();
          if (data != null) {
            _currentLanguage = data['language'] ?? 'Italian';
            _userName = data['username'];
            notifyListeners();
          }
        });
      }
    });
  }

  Future<void> updateUserLanguage(String newLanguage) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'language': newLanguage,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
      _currentLanguage = newLanguage;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }
}
