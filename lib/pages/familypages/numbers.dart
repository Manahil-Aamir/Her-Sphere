// ignore_for_file: no_logic_in_create_state

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/providers/family_provider.dart';
import 'package:hersphere/providers/familystream_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:hersphere/pages/familypages/sos.dart';
import '../impwidgets/backarrow.dart';

class Numbers extends ConsumerStatefulWidget {
  const Numbers({Key? key}) : super(key: key);

  @override
  ConsumerState<Numbers> createState() => _NumbersState();
}

class _NumbersState extends ConsumerState<Numbers> {
  final user = FirebaseAuth.instance.currentUser!;
  int tempNumber = 0;
  
  //Adds a new phone number to the list
  void _addNumber(BuildContext context, WidgetRef ref) async {
    final numbersAsyncValue = ref.watch(numbersStreamProvider(user.uid));

    numbersAsyncValue.when(
      data: (numbers) {
        if (numbers.length >= 3) {
          showDialog(
            context: context,
            builder: (BuildContext context) {

              // Show an alert dialog if the list is full
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
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String? phoneNumber;
              // Show a dialog to enter a new phone number
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
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onInputValidated: (bool value) {
                          if (!value) {
                            // Reset phoneNumber if input is invalid
                            phoneNumber =
                                null; 
                          }
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (phoneNumber != null && phoneNumber!.isNotEmpty) {
                        ref
                            .read(familyNotifierProvider.notifier)
                            .addNumber(user.uid, int.parse(phoneNumber!));
                        Navigator.pop(context);
                      } else {
                        // Close dialog before showing SnackBar
                        Navigator.pop(
                            context); 
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text(
                                  'Number is invalid',
                                  style: TextStyle(
                                    fontFamily: 'OtomanopeeOne',
                                    fontSize: 15.0,
                                    color: Color(0xFF726662),
                                  ),
                                ),
                              );
                            });
                      }
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
      },
      loading: () {
        // Handle loading state
      },
      error: (error, stack) {
        print('Error fetching numbers: $error');
      },
    );
  }

  // Deleting a number
  void _deleteNumber(int number) {
    ref.read(familyNotifierProvider.notifier).removeNumber(user.uid, number);
  }

//UI for creating Numbers page
  @override
  Widget build(BuildContext context) {
    final numbersAsyncValue = ref.watch(NumbersStreamProvider(user.uid));

    return Scaffold(
      backgroundColor: const Color(0xFFF9CFFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9CFFD),
        elevation: 0.5,
        leading: const BackArrow(widget: SOS()),
        title: Stack(
          children: [
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
              // Show the numbers using StreamProvider
              Expanded(
                child: numbersAsyncValue.when(
                  data: (numbers) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: numbers.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (BuildContext context, int index) {
                        int mobile = numbers[index];
                        return ListTile(
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
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
                            icon: const Icon(Icons.delete,
                                color: Color(0xFF726662)),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                ),
              ),
              // Option of adding a new number
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () => _addNumber(context, ref),
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
