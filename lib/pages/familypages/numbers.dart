// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:hersphere/pages/familypages/sos.dart';
import '../impwidgets/backarrow.dart';

class Numbers extends StatefulWidget {
  final List<int> mobileNumbers;

  const Numbers({Key? key, required this.mobileNumbers}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NumbersState createState() => _NumbersState(mobileNumbers);
}

class _NumbersState extends State<Numbers> {
  List<int> mobileNumbers;
  int tempNumber = 0;

  _NumbersState(this.mobileNumbers);

  //Adding a valid number and using intl_phone_number_input package
  void _addNumber(BuildContext context) {
    if(mobileNumbers.length==3){
        showDialog(context: context, 
        builder: (BuildContext context){
          return const AlertDialog(
          title: Text(
          'Cannot enter more Numbers',
          style: TextStyle(
            fontFamily: 'OtomanopeeOne',
            fontSize: 15.0,
            color: Color(0xFF726662),
          ),
          ),
          );
        });
    }
    else{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? phoneNumber;
        return AlertDialog(
          title: const Text(
            'Enter Mobile Number',
            style: TextStyle(
              fontFamily: 'OtomanopeeOne',
              fontSize: 15.0,
              color: Color(0xFF726662),
            ),
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    phoneNumber = number.phoneNumber!;
                  },
                  inputDecoration: const InputDecoration(
                    hintText: 'Enter Phone Number',
                  ),
                selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG
              ),
              autoValidateMode: AutovalidateMode.always,
              onInputValidated: (bool value) {
                  if (value) {
                  } else {
                    phoneNumber = null; // Reset phoneNumber if input is invalid
                  }
              }
                ),
              ],
            ),
          
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (phoneNumber != null && phoneNumber!.isNotEmpty) {
                  setState(() {
                    mobileNumbers.add(int.parse(phoneNumber!));
                  });
                  Navigator.pop(context); // Close dialog
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid phone number. Please try again.')),);
                } //show error until mobile number is valid
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 15.0,
                  color: Color(0xFF726662),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel button
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 15.0,
                  color: Color(0xFF726662),
                ),
              ),
            ),
          ],
        );
      },
    );
    }
  }

  // Deleting a number
  void _deleteNumber(int number) {
    setState(() {
      mobileNumbers.remove(number);
    });
  }

  @override
  //creating the UI for 'Numbers' page page
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9CFFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9CFFD),
        elevation: 0.5,
        //Going back to 'SOS' page
        leading: const BackArrow(widget: SOS()),
        title: Stack(
          children: [
            //Text with stroke (boundary)
            Text(
              'SOS',
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
            const Text(
              'SOS',
              style: TextStyle(
                fontFamily: 'OtomanopeeOne',
                fontSize: 30.0,
                color: Color(0xFF726662),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Text with stroke (boundary)
                  Text(
                    'NUMBERS',
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
                    'NUMBERS',
                    style: TextStyle(
                      fontFamily: 'OtomanopeeOne',
                      fontSize: 40.0,
                      color: Color(0xFF726662),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 200),
              // Showing all the numbers in a list
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: mobileNumbers.length,
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    int mobile = mobileNumbers[index];
                    return ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                      textColor: const Color(0xFF726662),
                      title: Text(
                        mobile.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Delete a number
                      trailing: IconButton(
                        onPressed: () => _deleteNumber(mobile),
                        icon: const Icon(Icons.delete, color: Color(0xFF726662)),
                      ),
                    );
                  },
                ),
              ),
              // Option of adding a new number
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () => _addNumber(context),
                  child: const Icon(Icons.add, color: Color(0xFF726662)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
