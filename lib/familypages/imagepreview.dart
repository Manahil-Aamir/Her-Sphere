import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hersphere/familypages/photos.dart';

import '../impwidgets/backarrow.dart';

class ImagePreview extends StatelessWidget {

  //Navigation on this screen
  final File image;

  // Constructor for the `BackArrow` widget.
  const ImagePreview({Key? key, required this.image}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9CFFD),
        elevation: 0.5,
        //Going back to all photos
        leading: const BackArrow(widget: Photos()),
        title: Stack(
          children: [
            //Text with stroke (boundary)
            Text(
              'Photo',
              style: TextStyle(
                fontFamily: 'OtomanopeeOne',
                fontSize: 30.0,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2.0
                  ..color = Colors.white,
              ),
            ),
            //Text with font color
            const Text(
              'Photo',
              style: TextStyle(
                fontFamily: 'OtomanopeeOne',
                fontSize: 30.0,
                color: Color(0xFF726662),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      //Displaying enlarged image
      body: Center(
        child: Image.file(image),
      ),
      
    );
  }

}
