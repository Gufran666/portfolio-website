import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio_website/app/screens/admin/admin_panel.dart';
import 'package:portfolio_website/app/screens/admin_panel/auth/login_screen.dart';
import 'firebase_options.dart';
import 'auth_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/admin': (context) => const AdminPanel(),
      },
      home: const AuthWrapper(),
    );
  }
}