import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hersphere/pages/familypages/family.dart';
import 'package:hersphere/pages/impwidgets/button.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';
import 'package:hersphere/pages/tasktrackerpages/tasktracker.dart';
import '../impwidgets/logout.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async {
      SystemNavigator.pop();
      return true;
    },
    child: Scaffold(
      backgroundColor: Color(0xFFFFC8D2),

      //App Bar with 'Logout' button
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC8D2),
        elevation: 0.5,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Logout(),
        ],
      ),

      body: SafeArea(
        child: Padding(
          //Applying padding to all widgets
          padding: EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Inserting an image on the top-left corner
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 182.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/home1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12), // Add spacing between widgets

              //UI for welcoming the user
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Creating stack to display Text with stroke
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Text with stroke (boundary)
                        Text(
                          'WELCOME ${user.displayName}',
                          style: TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            fontSize: 24.0,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2.0
                              ..color = Colors.white,
                          ),
                        ),
                        // Text with font color
                        Text(
                          'WELCOME ${user.displayName}',
                          style: TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            fontSize: 24.0,
                            color: Color(0xFF726662),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              //Displaying a 'FAMILY' category Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptionButton(text: 'FAMILY', widget: FamilyPage(),),
                ],
              ),
              SizedBox(height: 20),

              //Displaying a 'TASK TRACKER' category Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptionButton(text: 'TASK TRACKER', widget: TaskTracker()),
                ],
              ),
              SizedBox(height: 20),

              //Displaying a 'SELF-CARE' category Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptionButton(text: 'SELF-CARE', widget: SelfCare()),
                ],
              ),

              //Placing an image on bottom-right side
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 170.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/home2.png'),
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
    ),
    );
  }
}
