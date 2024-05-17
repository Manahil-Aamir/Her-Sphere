import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hersphere/familypages/birthday.dart';
import 'package:hersphere/familypages/family.dart';
import 'package:hersphere/impwidgets/appbar.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:permission_handler/permission_handler.dart';

import '../impwidgets/backarrow.dart';

class Birthdays extends StatefulWidget {
  const Birthdays({Key? key}) : super(key: key);

  @override
  State<Birthdays> createState() => BirthdaysState();
}

class BirthdaysState extends State<Birthdays> {
  String name = '';
  DateTime? selectedDate;
  List<Birthday> birthdayList = [];
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool notify = false;
  late tz.Location _localTimeZone;

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

  //Option of selecting the birthday date and formatted the visuals of the date picker
  Future<void> _selectDate(BuildContext context) async {
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
              child: const Text('OK',
              style: TextStyle(
                fontFamily: 'OtomanopeeOne',
                fontSize: 20.0,
                color: Color(0xFF726662),
              ),),
              onPressed: () {
                setState(() {
                  selectedDate = tempPickedDate;
                });
                if (kDebugMode) {
                  print('I selected $selectedDate');
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );

  if (kDebugMode) {
    print('I selected $selectedDate');
  }
}


  //Adding the birthday to the list
  Future<void> _addBirthday(BuildContext context) async {
    if (name.isNotEmpty && selectedDate != null) {
      print(
          'Birthday added: Name - $name, Date - $selectedDate  , notify: $notify');
      Navigator.of(context).pop();
      _checkPermissions();
      // Schedule notification if permission granted
      if (selectedDate != null) {
        _scheduleBirthdayNotifications(
            Birthday(name: name, date: selectedDate!));
        print('hiiiiii');
      }
      setState(() {
        birthdayList.add(Birthday(name: name, date: selectedDate!));
        name = '';
        selectedDate = null;
      });
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

  //Deleting a birthday from the list
  void _removeBirthday(int index) {
    setState(() {
      _cancelBirthdayNotification(birthdayList[index]);
      birthdayList.removeAt(index);
    });
  }

  //Getting month name
  String getMonthName(int month) {
    final monthNames = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
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
      // Schedule the notification 30 minutes before
      await flutterLocalNotificationsPlugin.zonedSchedule(
        birthdayList.indexOf(birthday), // Use the index as the notification ID
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

    if (birthdayList.contains(birthday)) {
      // Subtract 30 minutes from the birthday date
      var scheduledDate =
          birthdayThisYear.subtract(const Duration(minutes: 30));

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
          birthdayList
              .indexOf(birthday), // Use the index as the notification ID
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
  }

  Future<void> _cancelBirthdayNotification(Birthday birthday) async {
    try {
      await flutterLocalNotificationsPlugin
          .cancel(birthdayList.indexOf(birthday));
      print('Notification canceled successfully for ${birthday.name}');
    } catch (e) {
      print('Error canceling notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9CFFD),
      appBar: const AppBarWidget(
        text: 'BIRTHDAYS',
        color: Color(0xFFF9CFFD),
        back: Family(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //Creating a list to display all the birthdays
              Expanded(
                child: ListView.builder(
                  itemCount: birthdayList.length,
                  itemBuilder: (BuildContext context, int index) {
                    int age = birthdayList[index].date.month >
                                DateTime.now().month ||
                            (birthdayList[index].date.month ==
                                    DateTime.now().month &&
                                birthdayList[index].date.day >=
                                    DateTime.now().day)
                        ? DateTime.now().year - birthdayList[index].date.year
                        : DateTime.now().year -
                            birthdayList[index].date.year +
                            1;

                    //Displaying how many days are left for birthday
                    int days =
                        birthdayList[index].date.month > DateTime.now().month ||
                                (birthdayList[index].date.month ==
                                        DateTime.now().month &&
                                    birthdayList[index].date.day >=
                                        DateTime.now().day)
                            ? DateTime(
                                    DateTime.now().year,
                                    birthdayList[index].date.month,
                                    birthdayList[index].date.day)
                                .difference(DateTime.now())
                                .inDays
                            : DateTime(
                                    DateTime.now().year + 1,
                                    birthdayList[index].date.month,
                                    birthdayList[index].date.day)
                                .difference(DateTime.now())
                                .inDays;

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10),
                        ),
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
                        trailing: IconButton(
                          onPressed: () {
                            _removeBirthday(index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        tileColor:
                            Color((Random().nextDouble() * 0xFFFFFF).toInt())
                                .withOpacity(0.3),
                        title: Text(
                          birthdayList[index].name,
                          style: const TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF726662),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Column(
                          children: [
                            Text(
                              '${birthdayList[index].date.day} ${getMonthName(birthdayList[index].date.month)} ${birthdayList[index].date.year}',
                              style: const TextStyle(
                                fontFamily: 'OtomanopeeOne',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF726662),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Will turn $age in $days days',
                              style: const TextStyle(
                                fontFamily: 'OtomanopeeOne',
                                fontSize: 17.0,
                                color: Color(0xFF726662),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              //Option of adding a new birthday
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        //Alert Dialog of adding birthday and it asks for name and date
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
                              //Adding a name
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
                                  setState(() {
                                    name = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              //Selecting a date
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
                                    selectedDate != null
                                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                        : 'Select date',
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
                            //Cancel
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  name = '';
                                  selectedDate = null;
                                });
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
                            //Add Birthday
                            TextButton(
                              onPressed: () {
                                _addBirthday(context);
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
