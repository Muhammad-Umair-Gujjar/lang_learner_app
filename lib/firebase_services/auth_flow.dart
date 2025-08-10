import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/main_screen.dart';

import '../screens/auth_screens/login_screen.dart';

class AuthFlow {
  static void checkAuthFlow(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );
    }
  }
  static void initializeAuthFlow(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAuthFlow(context);
    });
  }

  }