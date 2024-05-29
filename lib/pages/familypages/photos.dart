import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/pages/familypages/family.dart';
import 'package:hersphere/pages/familypages/imagepreview.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/providers/family_provider.dart';
import 'package:hersphere/providers/familystream_provider.dart';
import 'package:hersphere/providers/storage_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Photos extends ConsumerStatefulWidget {
  const Photos({Key? key}) : super(key: key);

  @override
  ConsumerState<Photos> createState() => _PhotosState();
}

class _PhotosState extends ConsumerState<Photos> {
  bool pick = false;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    _checkPhotoPermission(pick);
  }

  Future<bool> _isAndroidVersionLessThan13() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      int sdkInt = androidInfo.version.sdkInt;
      return sdkInt < 33;
    }
    return false;
  }

  Future<void> _checkPhotoPermission(bool b) async {
    PermissionStatus status = await Permission.photos.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();
      if (status == PermissionStatus.denied) {
        if (await _isAndroidVersionLessThan13()) {
          status = await Permission.manageExternalStorage.request();
        }
        if (status == PermissionStatus.denied) {
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
    if (status == PermissionStatus.granted && b) {
      pickImage();
    }
  }

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

Future<void> pickImage() async {
  try {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);
    final storage = ref.read(firebaseStorageProvider);
    await uploadImageToStorage(imageFile, user.uid, storage);
  } catch (e) {
    print('Failed to pick image: $e');
  }
}

Future<void> deleteImage(String imageUrl) async {
  try {
    final storage = ref.read(firebaseStorageProvider);
    await deleteImageFromStorageAndFirestore(user.uid, imageUrl, storage);
  } catch (e) {
    print('Failed to delete image: $e');
  }
}

Future<void> uploadImageToStorage(File imageFile, String uid, FirebaseStorage storage) async {
  try {
    final uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    print(uniqueId);
    final storageRef = storage.ref().child('user_images').child(uid).child(uniqueId); // Unique location for each image
    final uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot downloadUrl = await uploadTask;
    final String imageUrl = await downloadUrl.ref.getDownloadURL();
    final photoNotifier = ref.read(familyNotifierProvider.notifier);
    await photoNotifier.addPhotoUrl(uid, imageUrl);
  } catch (e) {
    if (kDebugMode) {
      print('Error uploading image: $e');
    }
  }
}


Future<void> deleteImageFromStorageAndFirestore(String uid, String imageUrl, FirebaseStorage storage) async {
  try {
    final storageRef = storage.refFromURL(imageUrl);
    await storageRef.delete();
    final photoNotifier = ref.read(familyNotifierProvider.notifier);
    await photoNotifier.removePhotoUrl(uid, imageUrl);
  } catch (e) {
    print('Error deleting image: $e');
  }
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF9CFFD),
    appBar: const AppBarWidget(text: 'PHOTOS', color: Color(0xFFF9CFFD), back: FamilyPage(),),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, watch, _) {
                  final photoUrlsStream = ref.watch(PhotoUrlsStreamProvider(user.uid));
                  return photoUrlsStream.when(
                    data: (photoUrls) {
                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              itemCount: photoUrls.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Enlarge the selected photo on tap
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => ImagePreview(image: photoUrls[index]),
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
                                              deleteImage(photoUrls[index]);
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
                                    child: Image.network(
                                      photoUrls[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  );
                },
              ),
            ),
               // Option of adding a new photo
      Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            pick = true;
            _checkPhotoPermission(pick);
            pick = false;
          }, 
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
