import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hersphere/methods/authentication/auth.dart';
import 'package:hersphere/methods/authentication/google.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/authpages/register.dart';
import 'package:hersphere/pages/mainpages/welcome.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/providers/auth_provider.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
  final _auth = Connect();

  @override
  Widget build(BuildContext context) {
    final logged = ref.watch(authNotifierProvider);
    final loggedIn = logged.value;
    final GoogleSignInProvider _googleSignInProvider =
        GoogleSignInProvider(loggedIn!);
    return Scaffold(
      backgroundColor: const Color(0xFFFFC8D2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC8D2),
        leading: const BackArrow(widget: Welcome()),
        elevation: 0.5,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 20.0),
          child: Form(
            key: _loginformKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                // UI for 'LOGIN' header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Creating stack to display Text with stroke
                    Stack(
                      children: [
                        // Text with stroke (boundary)
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            fontSize: 50,
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
                const SizedBox(height: 20.0),
                // UI for taking email as input
                Row(
                  children: [
                    // Heading of 'EMAIL'
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
                    // Field for entering Email
                    Expanded(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'email@gmail.com',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // UI for taking password as input
                Row(
                  children: [
                    // Heading of 'PASSWORD'
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
                    // Field for entering Password
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: '######',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Button to Submit the form
                ElevatedButton(
                  onPressed: () {
                    if (_loginformKey.currentState!.validate()) {
                      try {
                        _auth.login(ref, _emailController, _passwordController,
                            context, _loginformKey);
                      } on PlatformException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('A platform error occurred: ${e.message}'),
                          ),
                        );
                      }
                    }
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
                // UI for 'OR' text
                const Center(
                  child: Text(
                    'or',
                    style: TextStyle(
                      color: Color(0xFF716562),
                      fontSize: 25,
                      fontFamily: 'OverlockSC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                // UI for Google Sign In Button
                ElevatedButton.icon(
                  onPressed: () {
                    _googleSignInProvider.googleLogin(context, ref);
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
                const SizedBox(height: 40.0),
                // Button to redirect to register page
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
                    'New? Create Account',
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
      ),
    );
  }
}
