import 'package:hersphere/models/familymodel.dart';
import 'package:hersphere/providers/family_provider.dart';

import 'mockfamilyservice.dart';

class MockFamilyNotifier extends FamilyNotifier{
  MockFamilyService _familyService = MockFamilyService();



  // Fetch todos as a stream and update the state
  void _fetchFamilies() {
    _familyService.getAllFamily();
  }

  Future<void> addNumber(String uid, int number) async {
    try {
      await _familyService.addNumber(uid, number);
    } catch (error) {
      print("Error adding number: $error");
      // Handle error
    }
  }

  Future<void> removeNumber(String uid, int number) async {
    try {
      await _familyService.removeNumber(uid, number);
    } catch (error) {
      print("Error removing number: $error");
      // Handle error
    }
  }

  Future<void> addPhotoUrl(String uid, String url) async {
    try {
      await _familyService.addPhotoUrl(uid, url);
    } catch (error) {
      print("Error adding photo URL: $error");
      // Handle error
    }
  }

  Future<void> removePhotoUrl(String uid, String url) async {
    try {
      await _familyService.removePhotoUrl(uid, url);
    } catch (error) {
      print("Error removing photo URL: $error");
      // Handle error
    }
  }

  Future<void> addBirthday(String uid, String name, DateTime date) async {
    try {
      await _familyService.addBirthday(uid, name, date);
    } catch (error) {
      print("Error adding birthday: $error");
      // Handle error
    }
  }

  Future<void> removeBirthday(String uid, String birthdayDocId) async {
    try {
      await _familyService.removeBirthday(uid, birthdayDocId);
    } catch (error) {
      print("Error removing birthday: $error");
      // Handle error
    }
  }
}
