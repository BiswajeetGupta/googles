import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googles/screens/BottomNav.dart';
import 'package:googles/screens/loginScreen.dart';

class AuthAcreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // While waiting for data
            } else if (snapshot.hasData) {
              return BottomNav();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
