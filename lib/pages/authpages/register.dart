import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/methods/authentication/auth.dart';
import 'package:hersphere/methods/authentication/google.dart';
import 'package:hersphere/providers/auth_provider.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _auth = Connect();

  @override
  Widget build(BuildContext context) {
    final logged = ref.watch(authNotifierProvider);
    final loggedIn = logged.value;
    final GoogleSignInProvider _googleSignInProvider =
        GoogleSignInProvider(loggedIn!);
    return Scaffold(
      backgroundColor: Color(0xFFFFC8D2),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC8D2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              // UI for 'REGISTER' header
              Center(
                child: Stack(
                  children: [
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
                    const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontFamily: 'OtomanopeeOne',
                        fontSize: 50.0,
                        color: Color(0xFF726662),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // UI for taking name as input
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20.0),

              // UI for taking email as input
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value))) {
                    return 'Not a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20.0),

              // UI for taking password as input
              TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Enter password of atleast 6 characters';
                    }
                    return null;
                  }),

              const SizedBox(height: 20.0),

              // UI for taking confirm password as input
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20.0),

              // Button to Submit the form
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, proceed with registration
                    _auth.register(_emailController, _passwordController,
                        _nameController.text, context, _formKey);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF716562),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
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

              const SizedBox(height: 40.0),

              // Button to redirect to login page
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF716562),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    fontSize: 20,
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
