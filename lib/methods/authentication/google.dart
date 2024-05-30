import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hersphere/pages/mainpages/home.dart';
import 'package:hersphere/pages/mainpages/welcome.dart';
import 'package:hersphere/providers/auth_provider.dart';

class GoogleSignInProvider extends StateNotifier<bool> {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInProvider(super.state);
  GoogleSignInAccount get user => _user!;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  // Implement Google Sign-In functionality
  Future<void> googleLogin(BuildContext context, WidgetRef ref) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with GoogleAuthCredential
      await FirebaseAuth.instance.signInWithCredential(credentials);

      // Set the isLoggedIn flag to true
      ref.read(authNotifierProvider.notifier).setLoggedIn(true);

      // Navigate to the Home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  // Implement Sign-Out functionality
  Future<void> googleSignOut(BuildContext context, WidgetRef ref) async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      // Check if the user is currently signed in
      if (await _googleSignIn.isSignedIn()) {
        //Sign outt from Google
        await _googleSignIn.signOut();
      }
      //Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Set the isLoggedIn flag to false
      ref.read(authNotifierProvider.notifier).setLoggedIn(false);

      // Navigate to the Welcome screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Welcome(),
        ),
      );
    } catch (error) {
      print('Error signing out: $error');
    }
  }
}
