
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;


class Hydration extends StatefulWidget {
  const Hydration({Key? key}) : super(key: key);

  @override
  State<Hydration> createState() => _HydrationState();

}

class _HydrationState extends State<Hydration> {

  
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isInitialized = false;

    @override
  void initState() {
    super.initState();
    initializeNotifications();
    initializeTimezone();
     _checkPermissions();
  }

  void initializeTimezone() {
    tzdata.initializeTimeZones();
    final location = tz.getLocation('Asia/Karachi');
    tz.setLocalLocation(location);
  }

      //Asking for permission of 'Allowing Notifications' from the user
    Future<void> _checkPermissions() async {
    final PermissionStatus notificationStatus = await Permission.notification.status;
    if (notificationStatus != PermissionStatus.granted && notificationStatus != PermissionStatus.permanentlyDenied) {
      final PermissionStatus notificationPermissionStatus = await Permission.notification.request();
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
          content: Text('$permissionName permissions are required to send SOS messages.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close',
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
          content: Text('Please enable $permissionName permission in app settings to send SOS messages.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close',
              style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 15.0,
                  color: Color(0xFF726662),
                ),),
            ),
            ElevatedButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text('Open Settings',
              style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 15.0,
                  color: Color(0xFF726662),
                ),),
            ),
          ],
        );
      },
    );
  }

//Initializing notifications
Future<void> initializeNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = const AndroidInitializationSettings('girlicon');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  isInitialized = true;
}


// Method to schedule notifications
Future<void> scheduleNotifications(TimeOfDay startTime, TimeOfDay endTime) async {
  print("Notifications");
  // Calculate the time difference between start and end times
  int totalMinutes = (endTime.hour - startTime.hour) * 60 + (endTime.minute - startTime.minute);
  
  // Calculate the interval between each notification
  int intervalMinutes = totalMinutes ~/ 8;

  // Initialize notifications plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  // Android initialization settings
  var initializationSettingsAndroid = const AndroidInitializationSettings('girlicon');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Schedule notifications
  for (int i = 0; i < 8; i++) {
    // Calculate notification time based on interval
    int notificationMinutes = intervalMinutes * i;
    int notificationHours = notificationMinutes ~/ 60;
    notificationMinutes = notificationMinutes % 60;
    TimeOfDay notificationTime = TimeOfDay(hour: startTime.hour + notificationHours, minute: startTime.minute + notificationMinutes);
    print(notificationTime);
    // Schedule notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      i,
      'Notification ${i + 1}',
      'Drink Water',
      _nextInstanceOfTime(notificationTime),
      matchDateTimeComponents: DateTimeComponents.time,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          priority: Priority.high,
          importance: Importance.max,
          playSound: true,
          icon: 'girlicon',
        ),

      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,

    );
  }
}

// Helper method to get the next instance of the given time
tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
  final now = tz.TZDateTime.now(tz.local);
  final today = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);
  return now.isBefore(today) ? today : today.add(const Duration(days: 1));
}

// Method to cancel all scheduled notifications
Future<void> cancelAllNotifications() async {
if (!isInitialized) {
  await initializeNotifications();
}

  // Cancel all scheduled notifications
  await flutterLocalNotificationsPlugin.cancelAll();
}

//variables to hold start and end time
TimeOfDay start = TimeOfDay.now();
TimeOfDay end = TimeOfDay.now();

//on/off toggle
bool _switchValue = false;

//Editting the sleep and wakeup time
void _editTime(bool wakeup, bool sleep) async {
  TimeOfDay initialTime = TimeOfDay.now();
TimeOfDay? pickedTime = await showTimePicker(
  context: context,
  initialTime: initialTime,
  builder: (BuildContext context, Widget? child) {
    //Modifying the theme of TimePicker
    return Theme(
      data: ThemeData(
        timePickerTheme: TimePickerThemeData(
          dayPeriodColor: const Color(0xFFBCF7C5),
          dayPeriodTextColor: const Color(0xFF726662),
          dayPeriodTextStyle: const TextStyle(color: const Color(0xFF726662)),
          dialHandColor: const Color(0xFFBCF7C5),
          dialTextColor: const Color(0xFF726662),
          dialTextStyle: const TextStyle(color: Colors.indigo),
          elevation: 5.0,
          entryModeIconColor: const Color(0xFF726662),
          hourMinuteColor: const Color(0xFFBCF7C5),
          hourMinuteTextColor: const Color(0xFF726662),
          hourMinuteTextStyle: const TextStyle(color: Colors.lightBlue),
          inputDecorationTheme: const InputDecorationTheme(fillColor:const Color(0xFFBCF7C5) ),
          padding: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF726662)),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF726662)),
          ),

        ),
      ),
      child: child!,
    );
  },
);



if (pickedTime != null) {
    if (wakeup && end != pickedTime) {
      setState(() {
        start = pickedTime;
      });
    if(_switchValue){
      cancelAllNotifications();
      scheduleNotifications(start, end);
    }
    } else if (sleep && start != pickedTime) {
      setState(() {
        end = pickedTime;
      });
      if(_switchValue){
      cancelAllNotifications();
      scheduleNotifications(start, end);
    }
  }
}
}
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFBCF7C5),
      appBar: const AppBarWidget(text: 'Hydration Reminder', color: Color(0xFFBCF7C5), back: SelfCare(),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Toggle button to enable/disable notifications
            Row(
              children: [
                const Text(
                  'off',
                  style: TextStyle(
                    fontFamily: 'OtomanopeeOne',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF726662),
                  ),
                ),
                Switch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                    if(_switchValue) scheduleNotifications(start, end);
                  },),
                  const Text(
                  'on',
                  style: TextStyle(
                    fontFamily: 'OtomanopeeOne',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF726662),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            //Setting the wakeup time
            Row(
              children: [
                const Text('WakeUp Time:',
                style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF726662),
                ),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 25,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text('${start.hour}:${start.minute}',
                  textAlign: TextAlign.center,
                  style:const TextStyle(
                    fontFamily: 'OtomanopeeOne',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF726662),
                  ),),
                ),
                const SizedBox(width: 15),
                IconButton(
                  onPressed:(){ _editTime(true, false);
                  },
                  icon: const Icon(Icons.time_to_leave,
                  color: Color(0xFF726662),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            //Setting the sleep time
            Row(
              children: [
                const Text('Sleep Time:',
                style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF726662),
                ),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 25,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text('${end.hour}:${end.minute}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'OtomanopeeOne',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF726662),
                  ),),
                ),
                const SizedBox(width: 15),
                IconButton(
                  onPressed:(){ _editTime(false, true);
                  },
                  icon: const Icon(Icons.time_to_leave,
                  color: Color(0xFF726662),
                  ),
                ),
              ],
            ),
          ],
        ))
    );
  }

}