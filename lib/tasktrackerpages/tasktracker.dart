import 'package:flutter/material.dart';
import 'package:hersphere/mainpages/home.dart';
import '../impwidgets/backarrow.dart';
import '../impwidgets/button.dart';
import '../impwidgets/logout.dart';

class TaskTracker extends StatefulWidget {
  const TaskTracker({Key? key}) : super(key: key);

  @override
  State<TaskTracker> createState() => _TaskTrackerState();

}

class _TaskTrackerState extends State<TaskTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB5EFFC),
      
      //App Bar with 'Logout' button and back arrow to 'Home'
      appBar: AppBar(
        backgroundColor: Color(0xFFB5EFFC),
        elevation: 0.5,
        leading: BackArrow(widget: Home()),
        actions: <Widget>[
          Logout(),
        ],
      ),

      body: SafeArea(
        child: Padding(
          //Applying padding to all widgets
          padding: EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            //Inserting an image on the top-right corner
            Align(
              alignment: Alignment.topRight,
              child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(0.22),
                  child: Container(
                    width: 116,
                    height: 118,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/tasktracker1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

              SizedBox(height: 73), // Add spacing between widgets

              //UI for 'TASK TRACKER' category
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Creating stack to display Text with stroke
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Text with stroke (boundary)
                      Text(
                        'TASK\nTRACKER',
                        textAlign: TextAlign.center,
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
                      Text(
                        'TASK\nTRACKER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OtomanopeeOne',
                          fontSize: 40.0,
                          color: Color(0xFF726662),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              //Displaying a 'EXPENSES' option Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptionButton(text: 'EXPENSES', widget: Home(),),
                ],
              ),
              SizedBox(height: 20),

              //Displaying a 'TO-DO LIST' option Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptionButton(text: 'TO-DO LIST', widget: Home()),
                ],
              ),

              //Placing an image on bottom-left side
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 185.0,
                    height: 230.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/tasktracker2.png'),
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