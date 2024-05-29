import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';
import 'package:hersphere/providers/selfcare_provider.dart';
import 'package:hersphere/providers/selfcarefuture_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class Hydration extends ConsumerStatefulWidget {
  const Hydration({Key? key}) : super(key: key);

  @override
  ConsumerState<Hydration> createState() => _HydrationState();
}

class _HydrationState extends ConsumerState<Hydration> {
  final user = FirebaseAuth.instance.currentUser!;

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

//Initializing notifications
  Future<void> initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('girlicon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    isInitialized = true;
  }

// Method to schedule notifications
  Future<void> scheduleNotifications(
      TimeOfDay startTime, TimeOfDay endTime) async {
    print("Notifications");
    // Calculate the time difference between start and end times
    int totalMinutes = (endTime.hour - startTime.hour) * 60 +
        (endTime.minute - startTime.minute);

    // Calculate the interval between each notification
    int intervalMinutes = totalMinutes ~/ 8;

    // Initialize notifications plugin
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Android initialization settings
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('girlicon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Schedule notifications
    for (int i = 0; i < 8; i++) {
      // Calculate notification time based on interval
      int notificationMinutes = intervalMinutes * i;
      int notificationHours = notificationMinutes ~/ 60;
      notificationMinutes = notificationMinutes % 60;
      TimeOfDay notificationTime = TimeOfDay(
          hour: startTime.hour + notificationHours,
          minute: startTime.minute + notificationMinutes);
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
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

// Helper method to get the next instance of the given time
  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    final today = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
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

final startProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());
final endProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());
final switchValueProvider = StateProvider<bool>((ref) => false);

  Future<void> _initializeVariables() async {
    try {
      // Fetch wakeup time
      final DateTime? wakeupTime =
          await ref.watch(WakeupProvider(user.uid).future);
      // Fetch sleep time
      final DateTime? sleepTime =
          await ref.watch(SleepProvider(user.uid).future);
      // Fetch notify value
      final bool notifyValue =
          await ref.watch(NotifyProvider(user.uid).future) ?? false;

      // Initialize start and end time with fetched values
      ref.read(startProvider.notifier).state = wakeupTime != null
          ? TimeOfDay.fromDateTime(wakeupTime)
          : TimeOfDay.now();
      ref.read(endProvider.notifier).state = sleepTime != null
          ? TimeOfDay.fromDateTime(sleepTime)
          : TimeOfDay.now();
      // Initialize _switchValue with fetched notify value
      ref.read(switchValueProvider.notifier).state = notifyValue;
    } catch (error) {
      print('Error initializing variables: $error');
      // Handle error
    }
  }

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
              dayPeriodTextStyle:
                  const TextStyle(color: const Color(0xFF726662)),
              dialHandColor: const Color(0xFFBCF7C5),
              dialTextColor: const Color(0xFF726662),
              dialTextStyle: const TextStyle(color: Colors.indigo),
              elevation: 5.0,
              entryModeIconColor: const Color(0xFF726662),
              hourMinuteColor: const Color(0xFFBCF7C5),
              hourMinuteTextColor: const Color(0xFF726662),
              hourMinuteTextStyle: const TextStyle(color: Colors.lightBlue),
              inputDecorationTheme: const InputDecorationTheme(
                  fillColor: const Color(0xFFBCF7C5)),
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              confirmButtonStyle: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF726662)),
              ),
              cancelButtonStyle: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF726662)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    TimeOfDay start = ref.read(startProvider.notifier).state;
    TimeOfDay end = ref.read(endProvider.notifier).state;

    if (pickedTime != null) {
      if (wakeup && end != pickedTime) {
        ref
            .read(selfCareNotifierProvider.notifier)
            .updateWakeupTime(user.uid, pickedTime);
        if (ref.read(switchValueProvider.notifier).state) {
          cancelAllNotifications();
          scheduleNotifications(start, end);
        }
      } else if (sleep && start != pickedTime) {
        ref
            .read(selfCareNotifierProvider.notifier)
            .updateSleepTime(user.uid, pickedTime);
        if (ref.read(switchValueProvider.notifier).state) {
          cancelAllNotifications();
          scheduleNotifications(start, end);
        }
      }
    }
     _initializeVariables();
     setState(() {
            });
  }

  String StartDate(){
    TimeOfDay start = ref.read(startProvider.notifier).state;
    print('${start.hour}:${start.minute}');
    return '${start.hour}:${start.minute}';
  }

    String EndDate(){
    TimeOfDay end = ref.read(endProvider.notifier).state;
    return '${end.hour}:${end.minute}';
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay start = ref.watch(startProvider.notifier).state;
    TimeOfDay end = ref.watch(endProvider.notifier).state;
    print(end);
    _initializeVariables();
    return Scaffold(
        backgroundColor: const Color(0xFFBCF7C5),
        appBar: const AppBarWidget(
          text: 'Hydration Reminder',
          color: Color(0xFFBCF7C5),
          back: SelfCare(),
        ),
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
                      value: ref.read(switchValueProvider.notifier).state,
                      onChanged: (value) {
                        print('hi');
                        print(ref.read(switchValueProvider.notifier).state);
                        print('value');
                        print(value);

                        ref
                            .read(selfCareNotifierProvider.notifier)
                            .updateNotify(user.uid, value);
                            ref.read(switchValueProvider.notifier).state =  value;
                        if (ref.read(switchValueProvider.notifier).state) scheduleNotifications(start, end);
                        print('notify');
                         print(ref.read(switchValueProvider.notifier).state);
                      },
                    ),
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
                    const Text(
                      'WakeUp Time:',
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
                      child: Text(
                        StartDate(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'OtomanopeeOne',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF726662),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      onPressed: () {
                        _editTime(true, false);
                      },
                      icon: const Icon(
                        Icons.time_to_leave,
                        color: Color(0xFF726662),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                //Setting the sleep time
                Row(
                  children: [
                    const Text(
                      'Sleep Time:',
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
                      child: Text(
                        EndDate(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'OtomanopeeOne',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF726662),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      onPressed: () {
                        _editTime(false, true);
                      },
                      icon: const Icon(
                        Icons.time_to_leave,
                        color: Color(0xFF726662),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
