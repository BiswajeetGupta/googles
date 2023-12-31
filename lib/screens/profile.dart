import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googles/repo/authService.dart';
import 'package:googles/screens/loginScreen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          CircleAvatar(
            radius: 70,
            backgroundImage:
                NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? ""),
          ),
          const SizedBox(height: 20.0),
          Text(
            FirebaseAuth.instance.currentUser?.displayName ?? "",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20.0),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(FirebaseAuth.instance.currentUser?.email ?? ""),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              authService.logout().then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ));
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
