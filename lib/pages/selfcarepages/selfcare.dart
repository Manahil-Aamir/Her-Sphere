import 'package:flutter/material.dart';
import 'package:hersphere/pages/mainpages/home.dart';
import 'package:hersphere/pages/selfcarepages/daily.dart';
import 'package:hersphere/pages/selfcarepages/hydration.dart';
import 'package:hersphere/pages/selfcarepages/journal.dart';
import '../impwidgets/backarrow.dart';
import '../impwidgets/button.dart';
import '../impwidgets/logout.dart';

class SelfCare extends StatefulWidget {
  const SelfCare({Key? key}) : super(key: key);

  @override
  State<SelfCare> createState() => _SelfCareState();
}

class _SelfCareState extends State<SelfCare> {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
        backgroundColor: const Color(0xFFBCF7C5),
        elevation: 0.5,
        leading: const BackArrow(widget: Home()),
        actions: const <Widget>[
          Logout(),
        ],
      );
    return Scaffold(
      backgroundColor: const Color(0xFFBCF7C5),

      //App Bar with 'Logout' button and back arrow to 'Home'
      appBar: appBar,

      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.fromLTRB(0.0, 10.0, 12.0, 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Inserting an image on the top-left corner
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.2),
                  child: Container(
                    width: 200.31,
                    height: 152.49,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/selfcare1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              // UI for 'SELF CARE' category
              Center(
                child: Stack(
                  children: [
                    // Text with stroke (boundary)
                    Text(
                      'SELF CARE',
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
                      'SELF CARE',
                      style: TextStyle(
                        fontFamily: 'OtomanopeeOne',
                        fontSize: 40.0,
                        color: Color(0xFF726662),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Displaying a 'JOURNAL' option Button
              const OptionButton(text: 'JOURNAL', widget: Journal()),

              const SizedBox(height: 20),

              // Displaying a 'HYDRATION REMINDER' option Button
              const OptionButton(text: 'HYDRATION REMINDER', widget: Hydration()),

              const SizedBox(height: 20),

              // Displaying a 'SOS' option Button
              const OptionButton(text: 'DAILY PLAN', widget: Daily()),

              const SizedBox(height: 100),

              // Placing an image on bottom-right side
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 160.0,
                    height: 450.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/selfcare2.png'),
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
