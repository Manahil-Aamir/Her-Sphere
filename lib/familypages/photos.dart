import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hersphere/familypages/family.dart';
import 'package:hersphere/familypages/sos.dart';
import 'package:hersphere/familypages/imagepreview.dart';
import 'package:hersphere/impwidgets/appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info/device_info.dart';

import '../impwidgets/backarrow.dart';

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  List<File> _savedImages = [];

  @override
  void initState() {
    super.initState();
    _checkPhotoPermission();
  }

   //Evaluating the android version of user to decide which permissions to ask for accessng photos
   Future<bool> _isAndroidVersionLessThan13() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      int sdkInt = androidInfo.version.sdkInt;
      return sdkInt < 33;
    }
    return false;
  }

  //Asking for permission from  user to access their gallery and camera
  Future<void> _checkPhotoPermission() async {
  PermissionStatus status = await Permission.photos.status;
  if (status != PermissionStatus.granted) {
    status = await Permission.photos.request();
    if (status == PermissionStatus.denied) {
      if (await _isAndroidVersionLessThan13()) {
        // If Android version is less than 13, request manage_storage permission
        status = await Permission.manageExternalStorage.request();
      }
      if (status == PermissionStatus.denied) {
        // Handle the permission denial accordingly
        if (await _isAndroidVersionLessThan13()) {
          _showPermissionPermanentlyDeniedDialog('Manage Storage');
        } else {
          _showPermissionDeniedDialog('Photos');
        }
      }
    } else if (status == PermissionStatus.permanentlyDenied && !(await _isAndroidVersionLessThan13())) {
      _showPermissionPermanentlyDeniedDialog('Photos');
    }
  }
  if (status == PermissionStatus.granted) {
    pickImage();
  }
}

  //Dialog if image permissions are denied by the user
  void _showPermissionDeniedDialog(String permissionName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permissionName Permission Denied'),
          content: Text('$permissionName permissions are required to access the gallery.'),
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

  //Dialog if image permissions are permanently denied by the user
  void _showPermissionPermanentlyDeniedDialog(String permissionName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permissionName Permission Permanently Denied'),
          content: Text('Please enable $permissionName permission in app settings to access the gallery.'),
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

  //Picking an image from gallery
  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile == null) return;
      final imageTemp = File(pickedFile.path);
      setState(() {
        _savedImages.add(imageTemp);
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _savedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9CFFD),
      appBar: const AppBarWidget(text: 'PHOTOS', color: Color(0xFFF9CFFD), back: Family(),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: _savedImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Enlarge the selected photo on tap
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImagePreview(image: _savedImages[index]),
                      ));
                    },
                    onLongPress: () {
                      // Provide an option to delete the selected photo
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Image',
                          style: TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            color: Color(0xFF726662),
                          ),),
                          content: const Text('Do you want to delete this image?',
                            style: TextStyle(
                              fontFamily: 'OtomanopeeOne',
                              fontSize: 13.0,
                              color: Color(0xFF726662),
                          ),),                      
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel',
                              style: TextStyle(
                                  fontFamily: 'OtomanopeeOne',
                                  fontSize: 11.0,
                                  color: Color(0xFF726662),
                              ),),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteImage(index);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete',
                              style: TextStyle(
                                  fontFamily: 'OtomanopeeOne',
                                  fontSize: 11.0,
                                  color: Color(0xFF726662),
                              ),),
                            ),
                          ],
                        ),
                      );
                    },

                    //Formatting to display the photo
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0), // Border radius
                        border: Border.all(
                          color: const Color(0xFF726662), // Border color
                          width: 1.0, // Border width
                        ),
                        color: const Color(0xFF726662), // Background color
                      ),
                      child: Image.file(
                        _savedImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
      
                  );
                },
              ),
            ),

             // Option of adding a new photo
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () => _checkPhotoPermission(),
                child: const Icon(Icons.add, color: Color(0xFF726662)),
              ),
            ),
          ],
        ),
      ),
    );
  }


}