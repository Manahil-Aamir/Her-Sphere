import 'package:flutter/material.dart';
import 'package:hersphere/impwidgets/backarrow.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  /// The text to be displayed on the button.
  final String text;

  //Navigation on this screen
  final Widget back;

  //Background colour
  final Color color;

  // Constructor for the `OptionButton` widget.
  const AppBarWidget({Key? key, required this.text, required this.color, required this.back}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: color,
        elevation: 0.5,
        //option of going back
        leading: BackArrow(widget: back),
        title: Stack(
          children: [
            //Text with stroke (boundary)
            Text(
              text,
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
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'OtomanopeeOne',
                fontSize: 30.0,
                color: Color(0xFF726662),
              ),
            ),
          ],
        ),
        centerTitle: true,
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
  


