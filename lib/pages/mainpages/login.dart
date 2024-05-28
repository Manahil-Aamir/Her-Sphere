
import 'package:flutter/material.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/mainpages/home.dart';
import 'package:hersphere/pages/mainpages/register.dart';
import 'package:hersphere/pages/mainpages/welcome.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // The _emailController is a TextEditingController that handles email input.
  final _emailController = TextEditingController();

  // The _emailController is a TextEditingController that handles password input.
  final _passwordController = TextEditingController();
  @override

  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFFC8D2),

    //Creating an  Appbar with the BackArrow button to 'WELCOME'
    appBar: AppBar(
      backgroundColor: const Color(0xFFFFC8D2),
      leading: const BackArrow(widget: Welcome()),
      elevation: 0.5,
    ),
    
    body: Center(
      child: Padding(
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
                      'LOGIN',
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
                    const Text(
                      'LOGIN',
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
        
            const SizedBox(height: 20.0,),
        
            //UI for taking email as input
            Row(
              children: [
                //Heading of 'EMAIL'
                const Text(
                  'Email:',
                  style: TextStyle(
                    color: Color(0xFF716562),
                    fontSize: 25,
                    fontFamily: 'OverlockSC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 55.0),
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
                Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (Route route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF716562),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF716562),
                  fontSize: 25,
                  fontFamily: 'OverlockSC',
                  fontWeight: FontWeight.w400,
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
                foregroundColor: const Color(0xFF716562),
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
                  MaterialPageRoute(builder: (context) => const Register()),
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
                'New? Create a new account',
                style: TextStyle(
                  color: Color(0xFF716562),
                  fontSize: 25,
                  fontFamily: 'OverlockSC',
                  fontWeight: FontWeight.w400,
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