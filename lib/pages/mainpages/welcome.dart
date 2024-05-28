import 'package:flutter/material.dart';
import 'package:hersphere/pages/impwidgets/button.dart';
import 'package:hersphere/pages/authpages/login.dart';
import 'package:hersphere/pages/authpages/register.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
  backgroundColor: Color(0xFFFFC8D2),
  // Creating a SafeArea widget to ensure the content is not obscured by notches or system UI
  body: SafeArea(
    child: Padding(
      // Add padding to all widgets
      padding: EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
      // Creating a Column widget to stack child widgets vertically
      child: Column(
        children: [

          //Inserting an image on the top-right corner
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 120.0,
                height: 210.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/welcome2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 2),

          //UI for name of the App
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Creating stack to display Text with stroke
              Stack(
                children: [
                  // Text with stroke (boundary)
                  Text(
                    'HER SPHERE',
                    style: TextStyle(
                      fontFamily: 'OtomanopeeOne',
                      fontSize: 50.0,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2.0
                        ..color = Colors.white,
                    ),
                  ),
                  // Text with font color
                  Text(
                    'HER SPHERE',
                    style: TextStyle(
                      fontFamily: 'OtomanopeeOne',
                      fontSize: 50.0,
                      color: Color(0xFF726662),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 2),

          //Tagline for the app
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children:
                [
                  // Text with stroke (boundary)
                  Text(
                  'a woman’s companion to balance it all',
                  style: TextStyle(
                    fontFamily: 'Birthstone',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    letterSpacing: 1.0,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.5
                      ..color = Colors.white,
                    ),
                  ),

                  // Text with font color
                  Text(
                  'a woman’s companion to balance it all',
                  style: TextStyle(
                    fontFamily: 'Birthstone',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF726662),
                    fontSize: 25.0,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center, // Center the text
                ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          //Displaying a Login Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionButton(text: 'LOGIN', widget: Login(),),
            ],
          ),

          SizedBox(height: 20),

          //Displaying a Register button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionButton(text: 'REGISTER', widget: Register()),
            ],
          ),

          //Placing an image on bottom-left side
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 100.0,
                height: 300.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/welcome1.png'),
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
