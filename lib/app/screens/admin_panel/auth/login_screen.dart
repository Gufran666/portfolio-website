import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGradientBackground(),
          _buildTitle(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildLoginCard(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.yellowAccent,
              Colors.black87
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      top: 80,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          'Admin Panel',
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return SizedBox(
      width: 450,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: const Color(0xFF16213E).withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputFields(),
                const SizedBox(height: 24),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email, color: Colors.white70),
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white70),
            fillColor: Colors.white12,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Colors.white70),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white70),
            fillColor: Colors.white12,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
        ),
        child: _isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : const Text(
          'ACCESS PANEL',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await _authService.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        // Navigation handled by AuthWrapper
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Login failed. Please try again.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else if (e.code == 'user-disabled') {
          errorMessage = 'This account has been disabled.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}