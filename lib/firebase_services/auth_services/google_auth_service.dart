import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with Google credentials
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      // Check if it's a new user
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // Save user data to Firestore for new users
        await _saveUserToFirestore(userCredential.user!);
      }

      return userCredential.user;
    } catch (e) {
      print('Google sign-in error: $e');
      return null;
    }
  }

  Future<void> _saveUserToFirestore(User user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'username': user.displayName,
      'photoURL': user.photoURL,
      'provider': 'google',
      'createdAt': FieldValue.serverTimestamp(),
      'language': 'Italian', // Default language
    });
  }

  Future<void> signOut() async {
    // await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
  }
}
