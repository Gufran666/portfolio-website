import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolio_website/app/screens/admin_panel/auth/login_screen.dart';
import 'package:portfolio_website/app/screens/admin/admin_panel.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const AdminPanel();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}