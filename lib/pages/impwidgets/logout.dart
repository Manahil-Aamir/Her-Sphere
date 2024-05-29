import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/methods/authentication/google.dart';
import 'package:hersphere/pages/authpages/login.dart';
import 'package:hersphere/providers/auth_provider.dart';

class Logout extends ConsumerWidget{
  // Constructor for the `Logout` widget.
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
              final logged = ref.watch(authNotifierProvider);
    final loggedIn = logged.value;
    final GoogleSignInProvider _googleSignInProvider =
        GoogleSignInProvider(loggedIn!);
    return SizedBox(
      // The width of the button.
      width: 80,

      // The height of the button.
      height: 20,

      child: ElevatedButton(
          // The style of the button, including background color, text style, and more.
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF716562),
            textStyle: const TextStyle(
              fontSize: 8,
              fontFamily: 'OverlockSC',
              fontWeight: FontWeight.w800,
              height: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 3,
          ),

          //Navigate to login page when the button is pressed.
          onPressed: () {
            _googleSignInProvider.googleSignOut(context, ref);
          },

          // The child widget of the button, which is a centered text with the given text.
          child: const Center(child: Text('LOGOUT'))),
    );
  }
}
