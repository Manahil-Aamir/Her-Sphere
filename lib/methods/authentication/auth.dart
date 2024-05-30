import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/pages/authpages/login.dart';
import 'package:hersphere/pages/mainpages/home.dart';
import 'package:hersphere/providers/auth_provider.dart';

class Connect {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login function
  void login(
    WidgetRef ref,
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    // Validate form
    if (formKey.currentState!.validate()) {
      await attemptLogin(
        ref,
        emailController.text.trim(),
        passwordController.text.trim(),
        context,
      );
    } else {
      _showErrorDialog(context, 'Please enter valid email and password.');
    }
  }

  // Attempt login with provided email and password
  Future<void> attemptLogin(
    WidgetRef ref,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Login successful
      print('Login successful');
      ref.read(authNotifierProvider.notifier).setLoggedIn(true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } catch (error) {
      handleError(context, error);
    }
  }

  // Handle errors during login
  void handleError(BuildContext context, dynamic error) {
    String errorMessage;

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        default:
          errorMessage = 'Authentication error: ${error.message}';
          break;
      }
    } else if (error is PlatformException) {
      switch (error.code) {
        case 'ERROR_INVALID_CREDENTIAL':
        case 'ERROR_USER_NOT_FOUND':
          errorMessage =
              'The supplied auth credential is incorrect, malformed, or has expired.';
          break;
        case 'ERROR_WRONG_PASSWORD':
          errorMessage =
              'The password is invalid or the user does not have a password.';
          break;
        default:
          errorMessage = 'Platform error: ${error.message}';
          break;
      }
    } else {
      errorMessage = 'Sign-in failed: $error';
    }
    // Show error dialog with error message
    _showErrorDialog(context, errorMessage);
  }

  // Show error dialog with provided message
  void _showErrorDialog(BuildContext context, String message) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              color: Color(0xFF716562),
              fontSize: 25,
              fontFamily: 'OverlockSC',
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Color(0xFF716562),
              fontSize: 18,
              fontFamily: 'OverlockSC',
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF716562),
                  fontSize: 18,
                  fontFamily: 'OverlockSC',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Register function
  Future<void> register(
    TextEditingController emailController,
    TextEditingController passwordController,
    String name,
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (formKey.currentState!.validate()) {
      // Form is valid, proceed with registration
      try {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // Registration successful
        print('Registration successful');
        if (userCredential.user != null) {
          await userCredential.user!.updateDisplayName(name);
          await userCredential.user!.reload();
          // Refetch the user to get updated details
          User? updatedUser = _auth.currentUser;
          print(updatedUser);
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _showErrorDialog(context, 'The password provided is too weak.');
        } else if (e.code == 'EMAIL_ALREADY_IN_USE') {
          _showErrorDialog(context, 'The email address is already in use.');
        } else {
          _showErrorDialog(context, 'Registration failed: ${e.message}');
        }
      } catch (error) {
        // Registration failed
        _showErrorDialog(context, 'Registration failed: $error');
      }
    }
  }
}
