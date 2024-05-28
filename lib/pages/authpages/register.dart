import 'package:flutter/material.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/authpages/login.dart';
import 'package:hersphere/pages/mainpages/welcome.dart';

import '../mainpages/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // The _emailController is a TextEditingController that handles email input.
  final _emailController = TextEditingController();

  // The _emailController is a TextEditingController that handles password input.
  final _passwordController = TextEditingController();

    // The _nameController is a TextEditingController that handles name input.
  final _nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
    backgroundColor: Color(0xFFFFC8D2),

    //Creating an  Appbar with the BackArrow button to 'WELCOME'
    appBar: AppBar(
      backgroundColor: Color(0xFFFFC8D2),
      leading: BackArrow(widget: Welcome()),
      elevation: 0.5,
    ),
    
    body: Padding(
       // Add padding to all widgets
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 20.0),
      //Keeping all widgets column-wise
      child: Column(
        //Making it all in centre through alignment
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //UI for 'LOGIN' header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Creating stack to display Text with stroke
              Stack(
                children: [
                  // Text with stroke (boundary)
                  Text(
                    'REGISTER',
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
                    'REGISTER',
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

          SizedBox(height: 20.0,),

          //UI for taking name as input
          Container(
            child: Row(
              children: [
                //Heading of 'NAME'
                Text(
                  'Name:',
                  style: TextStyle(
                    color: Color(0xFF716562),
                    fontSize: 25,
                    fontFamily: 'OverlockSC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 55.0),
                //Field for entering Email
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Sara',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20.0),

          //UI for taking email as input
          Container(
            child: Row(
              children: [
                //Heading of 'EMAIL'
                Text(
                  'Email:',
                  style: TextStyle(
                    color: Color(0xFF716562),
                    fontSize: 25,
                    fontFamily: 'OverlockSC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 55.0),
                //Field for entering Email
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'email@gmail.com',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20.0),

          //UI for taking password as input
          Row(
            children: [
              //Heading of 'PASSWORD'
              const Text(
                'Password:',
                style: TextStyle(
                  color: Color(0xFF716562),
                  fontSize: 25,
                  fontFamily: 'OverlockSC',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 5.0),
              //Field for entering Password
              Expanded(
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: '####',
                  ),
                  obscureText: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20.0),

          //Button to Submit the form
          ElevatedButton(
            onPressed: () {                          
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
            },
            child: Text(
              'Register',
              style: TextStyle(
                color: Color(0xFF716562),
                fontSize: 25,
                fontFamily: 'OverlockSC',
                fontWeight: FontWeight.w400,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF716562),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 15.0),

          //UI for 'OR' text
          const Text(
            'or',
            style: TextStyle(
              color: Color(0xFF716562),
              fontSize: 25,
              fontFamily: 'OverlockSC',
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 15.0),

          //UI for Google Sign In Button
          ElevatedButton.icon(
            onPressed: () {
              // Handle Google sign-in logic here
            },
            icon: Image.asset(
              'assets/images/google.png',
              width: 35.0,
              height: 35.0,
            ),
            label: const Text(
              'Continue with Google',
              style: TextStyle(
                color: Color(0xFF716562),
                fontSize: 25,
                fontFamily: 'OverlockSC',
                fontWeight: FontWeight.w400,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF716562),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height : 40.0),
             //Button to redirect to register page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF716562),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(
                  color: Color(0xFF716562),
                  fontSize: 20,
                  fontFamily: 'OverlockSC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    ),
  );
  }
}