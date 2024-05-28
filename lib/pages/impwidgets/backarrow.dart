import 'package:flutter/material.dart';


class BackArrow extends StatelessWidget {

  //Navigation on this screen
  final Widget widget;

  // Constructor for the `BackArrow` widget.
  const BackArrow({Key? key, required this.widget}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  IconButton(
      icon: const Icon(Icons.arrow_back,
      color: Color(0xFF726662)),
      //Navigate to previous page when the button is pressed.
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget),
          );
        },
    );
  }
  }