import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/methods/familymethods/birthdaymethod.dart';
import 'package:hersphere/pages/familypages/family.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/providers/familystream_provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:permission_handler/permission_handler.dart';
import 'package:hersphere/models/birthdaymodel.dart';
import 'package:hersphere/providers/family_provider.dart';

final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

class Birthdays extends ConsumerStatefulWidget {
  const Birthdays({Key? key}) : super(key: key);

  @override
  ConsumerState<Birthdays> createState() => BirthdaysState();
}

class BirthdaysState extends ConsumerState<Birthdays> {
  final nameProvider = StateProvider<String>((ref) => '');
  final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool notify = false;
  final user = FirebaseAuth.instance.currentUser!;
  BirthdayMethods bm = BirthdayMethods();

  // Function to initialize the local timezone
  void initializeTimezone() {
    tzdata.initializeTimeZones();
    final location = tz.getLocation('Asia/Karachi');
    tz.setLocalLocation(location);
  }

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    _checkPermissions();
  }

  //Asking for permission of 'Allowing Notifications' from the user
  Future<void> _checkPermissions() async {
    final PermissionStatus notificationStatus =
        await Permission.notification.status;
    if (notificationStatus != PermissionStatus.granted &&
        notificationStatus != PermissionStatus.permanentlyDenied) {
      final PermissionStatus notificationPermissionStatus =
          await Permission.notification.request();
      if (notificationPermissionStatus != PermissionStatus.granted) {
        _showPermissionDeniedDialog('Notification');
        return;
      }
    } else if (notificationStatus == PermissionStatus.permanentlyDenied) {
      _showPermissionPermanentlyDeniedDialog('Notification');
      return;
    }
  }

  //Dialog box if notifications permissions are denied by the user
  void _showPermissionDeniedDialog(String permissionName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permissionName Permission Denied'),
          content: Text(
              '$permissionName permissions are required to send SOS messages.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
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

  //Dialog box if notifications permissions are permanently denied by the user
  void _showPermissionPermanentlyDeniedDialog(String permissionName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permissionName Permission Permanently Denied'),
          content: Text(
              'Please enable $permissionName permission in app settings to send SOS messages.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 15.0,
                  color: Color(0xFF726662),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text(
                'Open Settings',
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

  Future<void> initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('girlicon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Select date to schedule birthday
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate =
        ref.read(selectedDateProvider.notifier).state ?? DateTime.now();
    DateTime tempPickedDate = selectedDate ?? DateTime.now();

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: const Color(0xFFF9CFFD),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  color: const Color(0xFFF9CFFD),
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          color: Color(0xFF726662),
                          fontSize: 20.0,
                          fontFamily: 'OtomanopeeOne',
                        ),
                      ),
                      brightness: Brightness.light,
                      primaryColor: Color(0xFFF9CFFD),
                      scaffoldBackgroundColor: Color(0xFFF9CFFD),
                      barBackgroundColor: Color(0xFFF9CFFD),
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: tempPickedDate,
                      minimumDate: DateTime(1900),
                      maximumDate: DateTime.now(),
                      onDateTimeChanged: (DateTime newDate) {
                        tempPickedDate = newDate;
                      },
                    ),
                  ),
                ),
              ),
              CupertinoButton(
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'OtomanopeeOne',
                    fontSize: 20.0,
                    color: Color(0xFF726662),
                  ),
                ),
                onPressed: () {
                  ref.read(selectedDateProvider.notifier).state =
                      tempPickedDate;
                  Navigator.of(context).pop();
                  
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //Add birthday
  Future<void> _addBirthday(BuildContext context, String uid) async {
    final selectedDate = ref.read(selectedDateProvider);
    String name = ref.read(nameProvider.notifier).state;
    if (name.isNotEmpty && selectedDate != null) {
      final familyNotifier = ref.read(familyNotifierProvider.notifier);
      await familyNotifier.addBirthday(uid, name, selectedDate);

      // Optionally, schedule a notification here
      _scheduleBirthdayNotifications(
          Birthday(name: name, date: selectedDate, id: ''));

      // Reset name and selectedDate
      ref.read(nameProvider.notifier).state = '';
      ref.read(selectedDateProvider.notifier).state = null;
      Navigator.pop(context);
    } else {
      // Show error dialog if fields are empty
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(
                fontFamily: 'OtomanopeeOne',
                fontSize: 20.0,
                color: Color(0xFF726662),
              ),
            ),
            content: const Text(
              'Both fields are compulsory. Please fill them.',
              style: TextStyle(
                fontFamily: 'OtomanopeeOne',
                fontSize: 15.0,
                color: Color(0xFF726662),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
            ],
          );
        },
      );
    }
  }

  //Remove a birthday
  Future<void> _removeBirthday(
      String uid, String birthdayDocId, DateTime date, String name) async {
    final familyNotifier = ref.read(familyNotifierProvider.notifier);
    await familyNotifier.removeBirthday(uid, birthdayDocId);
    _cancelBirthdayNotification(Birthday(name: name, date: date, id: ''));
  }

  // Schedule notifications only for the newly added birthday, 30 minutes before the birthday
  Future<void> _scheduleBirthdayNotifications(Birthday birthday) async {
    // Get today's date
    var today = DateTime.now();

    // Get the birthday date for this year
    var birthdayThisYear =
        DateTime(today.year, birthday.date.month, birthday.date.day);

    // Check if the birthday has already passed this year
    if (today.isAfter(birthdayThisYear)) {
      // If it has passed, schedule the notification for next year
      birthdayThisYear =
          DateTime(today.year + 1, birthday.date.month, birthday.date.day);
    }

    // Subtract 30 minutes from the birthday date
    var scheduledDate = birthdayThisYear.subtract(const Duration(hours: 22, minutes: 50,));

    initializeTimezone();
    // Get the current timezone of the mobile device
    final String timeZoneName = tz.local.name;

    // Define the scheduled date for the notification using the current timezone
    var scheduledTimezoneDate =
        tz.TZDateTime.from(scheduledDate, tz.getLocation(timeZoneName));

    // Configure Android notification details
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Channel name',
      'Channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    // Create notification details
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      // Schedule the notification 30 minutes before
      await flutterLocalNotificationsPlugin.zonedSchedule(
        birthday.hashCode, // Use the index as the notification ID
        'Birthday Reminder',
        '30 minutes before ${birthday.name}\'s birthday!',
        scheduledTimezoneDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print('scheduled date');
      print(scheduledDate);
      print(
          'Notification scheduled successfully for ${birthday.name} at ${scheduledDate}');
      _futureBirthdays(birthday, scheduledDate);
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  // Schedule notifications only for the newly added birthday, 30 minutes before the birthday
  Future<void> _futureBirthdays(
      Birthday birthday, DateTime scheduleDate) async {
    Future.delayed(const Duration(
        days:
            365)); // Wait a year from now to check if the birthday still exists
    // Get today's date
    var today = DateTime.now();

    // Get the birthday date for this year
    var birthdayThisYear =
        DateTime(today.year, birthday.date.month, birthday.date.day);

    // Check if the birthday has already passed this year
    if (today.isAfter(birthdayThisYear)) {
      // If it has passed, schedule the notification for next year
      birthdayThisYear =
          DateTime(today.year + 1, birthday.date.month, birthday.date.day);
    }

    // Subtract 30 minutes from the birthday date
    var scheduledDate = birthdayThisYear.subtract(const Duration(minutes: 30));

    initializeTimezone();
    // Get the current timezone of the mobile device
    final String timeZoneName = tz.local.name;

    // Define the scheduled date for the notification using the current timezone
    var scheduledTimezoneDate =
        tz.TZDateTime.from(scheduledDate, tz.getLocation(timeZoneName));

    // Configure Android notification details
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Channel name',
      'Channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    // Create notification details
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      // Schedule the notification
      await flutterLocalNotificationsPlugin.zonedSchedule(
        birthday.hashCode, // Use the index as the notification ID
        'Birthday Reminder',
        '30 minutes before ${birthday.name}\'s birthday!',
        scheduledTimezoneDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      print(
          'Notification scheduled successfully for ${birthday.name} at ${scheduledDate}');
      _futureBirthdays(birthday, scheduleDate);
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  //Cancel notifications if birthday removed
  Future<void> _cancelBirthdayNotification(Birthday birthday) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(birthday.hashCode);
      print('Notification canceled successfully for ${birthday.name}');
    } catch (e) {
      print('Error canceling notification: $e');
    }
  }

  //formatting a birthday
  String datetell() {
    final selectedDate = ref.read(selectedDateProvider.notifier).state;
    print(selectedDate);
    if (selectedDate != null) {
      return '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
    } else
      return 'Select date';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9CFFD),
      appBar: const AppBarWidget(
        text: 'BIRTHDAYS',
        color: Color(0xFFF9CFFD),
        back: FamilyPage(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                //Displaying all the birthdays
                child: Consumer(
                  builder: (context, watch, _) {
                    final birthdayStream =
                        ref.watch(birthdaysStreamProvider(user.uid));
                    return birthdayStream.when(
                      data: (birthdayList) {
                        return ListView.builder(
                          itemCount: birthdayList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final birthday = birthdayList[index];
                            int age = bm.findAge(birthday);

                            int days = bm.findDays(birthday);

                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10),
                                ),
                                //Image on basis of index value
                                leading: (index % 2 == 0)
                                    ? Image.asset(
                                        'assets/images/birthday1.png',
                                        width: 25,
                                        height: 400,
                                      )
                                    : Image.asset(
                                        'assets/images/birthday2.png',
                                        width: 40,
                                        height: 500,
                                      ),
                                //remove birthday
                                trailing: IconButton(
                                  onPressed: () {
                                    print(birthday.id);
                                    _removeBirthday(user.uid, birthday.id,
                                        birthday.date, birthday.name);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                tileColor: Color(
                                        (Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(0.3),
                                title: Text(
                                  birthday.name,
                                  style: const TextStyle(
                                    fontFamily: 'OtomanopeeOne',
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF726662),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                subtitle:
                                    //Displaying date with age
                                    Column(
                                  children: [
                                    Text(
                                      '${birthday.date.day} ${bm.getMonthName(birthday.date.month)} ${birthday.date.year}',
                                      style: const TextStyle(
                                        fontFamily: 'OtomanopeeOne',
                                        fontSize: 20.0,
                                        color: Color(0xFF726662),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '$age years old in $days days',
                                      style: const TextStyle(
                                        fontFamily: 'OtomanopeeOne',
                                        fontSize: 15.0,
                                        color: Color(0xFF726662),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Text('Error: $error'),
                    );
                  },
                ),
              ),

              //Add birthday ui functionality
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Add Birthday',
                            style: TextStyle(
                              fontFamily: 'OtomanopeeOne',
                              fontSize: 20.0,
                              color: Color(0xFF726662),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    fontFamily: 'OtomanopeeOne',
                                    fontSize: 13.0,
                                    color: Color(0xFF726662),
                                  ),
                                ),
                                onChanged: (value) {
                                  ref.read(nameProvider.notifier).state = value;
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Text(
                                    'Date:',
                                    style: TextStyle(
                                      fontFamily: 'OtomanopeeOne',
                                      fontSize: 15.0,
                                      color: Color(0xFF726662),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.calendar_month_rounded,
                                      color: Color(0xFF726662),
                                    ),
                                    onPressed: () async {
                                      await _selectDate(context);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    datetell(),
                                    style: const TextStyle(
                                      fontFamily: 'OtomanopeeOne',
                                      fontSize: 13.0,
                                      color: Color(0xFF726662),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                ref.read(nameProvider.notifier).state = '';
                                ref.read(selectedDateProvider.notifier).state =
                                    null;
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: 'OtomanopeeOne',
                                  fontSize: 15.0,
                                  color: Color(0xFF726662),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _addBirthday(context, user.uid);
                              },
                              child: const Text(
                                'Add',
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
                  },
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF726662),
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
