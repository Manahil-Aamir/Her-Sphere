import 'package:flutter/material.dart';
import 'package:hersphere/familypages/birthdays.dart';
import 'package:hersphere/familypages/photos.dart';
import 'package:hersphere/familypages/sos.dart';
import 'package:hersphere/mainpages/home.dart';
import '../impwidgets/backarrow.dart';
import '../impwidgets/button.dart';
import '../impwidgets/logout.dart';

class Family extends StatefulWidget {
  const Family({Key? key}) : super(key: key);

  @override
  State<Family> createState() => _FamilyState();
}

class _FamilyState extends State<Family> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9CFFD),

      //App Bar with 'Logout' button and back arrow to 'Home'
      appBar: AppBar(
        backgroundColor: Color(0xFFF9CFFD),
        elevation: 0.5,
        leading: const BackArrow(widget: Home()),
        actions: const <Widget>[
          Logout(),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 23.0),

              // Inserting an image on the top-left corner
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.23),
                    child: Container(
                      width: 200.0,
                      height: 150.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/family1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              // UI for 'FAMILY' category
              Stack(
                alignment: Alignment.center,
                children: [
                  // Text with stroke (boundary)
                  Text(
                    'FAMILY',
                    style: TextStyle(
                      fontFamily: 'OtomanopeeOne',
                      fontSize: 40.0,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2.0
                        ..color = Colors.white,
                    ),
                  ),
                  // Text with font color
                  const Text(
                    'FAMILY',
                    style: TextStyle(
                      fontFamily: 'OtomanopeeOne',
                      fontSize: 40.0,
                      color: Color(0xFF726662),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Displaying a 'BIRTHDAYS' option Button
              const OptionButton(text: 'BIRTHDAYS', widget: Birthdays()),

              const SizedBox(height: 20),

              // Displaying a 'PHOTOS' option Button
              const OptionButton(text: 'PHOTOS', widget: Photos()),

              const SizedBox(height: 20),

              // Displaying a 'SOS' option Button
              const OptionButton(text: 'SOS', widget: SOS()),

              // Placing an image on bottom-right side
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 250.0,
                    height: 280.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/family2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
