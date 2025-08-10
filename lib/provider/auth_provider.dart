
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../firebase_services/auth_services/google_auth_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  bool _loading = false;
  String? _errorMessage;
  Map<String, dynamic>? _userData;

  bool get loading => _loading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get userData => _userData;
  User? get firebaseUser => _auth.currentUser;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String username,
    required String language,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'username': username,
        'email': email,
        'language': language,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await fetchUserData(); // Ensure UI has user info immediately

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _setError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _setError('The account already exists for that email.');
      } else {
        _setError(e.message);
      }
      return false;
    } catch (e) {
      _setError('Something went wrong: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await fetchUserData();

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          _setError('No user found with this email');
          break;
        case 'wrong-password':
          _setError('Incorrect password');
          break;
        case 'invalid-email':
          _setError('Invalid email format');
          break;
        default:
          _setError('Login failed');
      }
      return false;
    } catch (_) {
      _setError('An unexpected error occurred');
      return false;
    } finally {
      _setLoading(false);
    }
  }


  Future<bool> loginWithGoogle() async {
    try {
      _setLoading(true);
      _setError(null);

      final user = await _googleAuthService.signInWithGoogle();

      if (user != null) {
        await fetchUserData();
        return true;
      }
      return false;
    } catch (e) {
      _setError('Failed to sign in with Google');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    if (email.isEmpty || !email.contains('@')) {
      return 'Please enter a valid email address';
    }

    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return 'Password reset email sent. Please check your inbox.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return 'No account found with this email';
      if (e.code == 'invalid-email') return 'Please enter a valid email address';
      return 'Failed to send reset email';
    } catch (_) {
      return 'An unexpected error occurred';
    }
  }


  Future<void> fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        _userData = doc.data();
        notifyListeners();
      }
    }
  }

  Future<void> logout() async {
    try {
      _setLoading(true);

      final providerId = _auth.currentUser?.providerData.first.providerId;

      if (providerId == 'google.com') {
        await GoogleAuthService().signOut();
      } else {
        await _auth.signOut();
      }

      _userData = null;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

}

