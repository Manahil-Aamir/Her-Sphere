import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hersphere/pages/familypages/numbers.dart';
import 'package:hersphere/providers/familystream_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geocoding/geocoding.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../impwidgets/backarrow.dart';
import 'family.dart';

class SOS extends ConsumerStatefulWidget {
  const SOS({super.key});

  @override
  ConsumerState<SOS> createState() => _SOSState();
}

class _SOSState extends ConsumerState<SOS> {
  int tempNumber = 0;

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  //checking for permission of location and sms
  //permission of location is crucial
  Future<void> _checkPermissions() async {
    final PermissionStatus locationStatus = await Permission.location.status;
    if (locationStatus != PermissionStatus.granted) {
      final PermissionStatus locationPermissionStatus =
          await Permission.location.request();
      if (locationPermissionStatus == PermissionStatus.denied) {
        _showPermissionDeniedDialog('Location');
        return;
      }
    } else if (locationStatus == PermissionStatus.permanentlyDenied) {
      _showPermissionPermanentlyDeniedDialog('Location');
      return;
    }

    //if location of permission is given and not sms so popup of location can still be viewed by user
    final PermissionStatus smsStatus = await Permission.sms.status;
    print(PermissionStatus);
    if (smsStatus != PermissionStatus.granted) {
      final PermissionStatus smsPermissionStatus =
          await Permission.sms.request();
      if (smsPermissionStatus != PermissionStatus.granted &&
          smsPermissionStatus != PermissionStatus.permanentlyDenied) {
        _showPermissionDeniedDialog('SMS');
        _getLocation();
        return;
      } else if (smsPermissionStatus == PermissionStatus.permanentlyDenied) {
        _getLocation();
        _showPermissionPermanentlyDeniedDialog('SMS');
      }
      return;
    }

    _getLocationAndSendSOS();
  }

  //Dialog box that will pop up if any permission is denied by user
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
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  //Dialog box that will pop up if the user has permanently denied a permission request
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
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  //Tracking location of user and sending SOS
  Future<void> _getLocationAndSendSOS() async {
    try {
      // Fetch current location
      geolocator.Position position =
          await geolocator.Geolocator.getCurrentPosition();
      double lat = position.latitude;
      double lng = position.longitude;

      // Reverse geocoding to get address
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(lat, lng);
      final Placemark place = placemarks.first;

      // Send SOS message
      _sendSMS(
          "HELP!!!: ${place.name}, ${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}");

      // Display location in popup
      _showLocationPopup(place);
    } catch (e) {
      print("Error sending SOS: $e");
    }
  }

  //Showing location to user in popup no sms sent
  Future<void> _getLocation() async {
    try {
      // Fetch current location
      geolocator.Position position =
          await geolocator.Geolocator.getCurrentPosition();
      double lat = position.latitude;
      double lng = position.longitude;

      // Reverse geocoding to get address
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(lat, lng);
      final Placemark place = placemarks.first;

      // Display location in popup
      _showLocationPopup(place);
    } catch (e) {
      print("Error sending SOS: $e");
    }
  }

  //Shows the actual address of the user
  void _showLocationPopup(Placemark place) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Location'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("${place.street}"),
                Text("${place.locality}, ${place.postalCode}"),
                Text("${place.country}"),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<List<int>> fetchNumbers(String uid, WidgetRef ref) async {
    final numbersAsyncValue = await ref.read(numbersStreamProvider(uid).future);
    return numbersAsyncValue;
  }

  Future<void> sendSMSWithNumbers(String message, List<int> numbers) async {
    try {
      List<String> recipientStrings =
          numbers.map((number) => number.toString()).toList();
      String result =
          await sendSMS(message: message, recipients: recipientStrings);
      print(result);
    } catch (error) {
      print('Failed to send SMS: $error');
    }
  }

  void _sendSMS(String message) async {
    try {
      final numbers = await fetchNumbers(user.uid, ref);
      await sendSMSWithNumbers(message, numbers);
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9CFFD),
      //title of the screen
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9CFFD),
        elevation: 0.5,
        //Going back to 'Family page'
        leading: const BackArrow(widget: FamilyPage()),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SOS button
            IconButton(
              icon: Image.asset('assets/images/sos1.png'),
              iconSize: 150.0,
              padding: const EdgeInsets.all(40.0),
              onPressed: () {
                _checkPermissions();
              },
            ),
            const SizedBox(height: 30),

            //Adding numbers to send your location to
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFFFFF),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Numbers()),
                );
              },
              child: const Text(
                "Registered Numbers",
                style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 13.0,
                  color: Color(0xFF726662),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
