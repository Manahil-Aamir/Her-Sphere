import 'package:flutter/material.dart';
import 'package:hersphere/mainpages/login.dart';


class Logout extends StatelessWidget {

  // Constructor for the `Logout` widget.
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // The width of the button.
      width: 75,

      // The height of the button.
      height: 10,
      
      child: ElevatedButton(
        // The style of the button, including background color, text style, and more.
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF716562),
          textStyle: const TextStyle(
            fontSize: 12,
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },

        // The child widget of the button, which is a centered text with the given text.
        child: const Center(child: Text('LOGOUT'))),
      
    );
  }
}
  
