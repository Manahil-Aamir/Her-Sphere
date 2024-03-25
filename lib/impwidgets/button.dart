import 'package:flutter/material.dart';


class OptionButton extends StatelessWidget {
  /// The text to be displayed on the button.
  final String text;

  //Navigation on this screen
  final Widget widget;

  // Constructor for the `OptionButton` widget.
  const OptionButton({Key? key, required this.text, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // The width of the button.
      width: 219,

      // The height of the button.
      height: 78,
      
      child: ElevatedButton(
        // The style of the button, including background color, text style, and more.
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF716562),
          textStyle: TextStyle(
            fontSize: 30,
            fontFamily: 'OverlockSC',
            fontWeight: FontWeight.w400,
            height: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 3,
        ),

        //Navigate to other page when the button is pressed.
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget),
          );
        },

        // The child widget of the button, which is a centered text with the given text.
        child: Center(child: Text(text,
        textAlign: TextAlign.center,)),
      ),
    );
  }
}
  


