import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_provider.g.dart';

@riverpod
FirebaseStorage firebaseStorage(FirebaseStorageRef ref) {
  // Create and return an instance of FamilyService here
  return FirebaseStorage.instance;
}