import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/providers/family_provider.dart';
import 'package:mockito/mockito.dart';

import 'mockfamilyprovider.dart';
import 'mockfamilyservice.dart';


void main() {
  late MockFamilyNotifier notifier;
  late MockFamilyService mockFamilyService;

  setUp(() {
    mockFamilyService = MockFamilyService();
  });

  group('MockFamilyNotifier Tests', () {
    test('addNumber calls FamilyService addNumber', () async {
      const uid = '1';
      const number = 999;

      // Arrange
      when(mockFamilyService.addNumber(uid, number)).thenAnswer((_) async => Future.value());

      // Act
      await mockFamilyService.addNumber(uid, number);

      // Assert
      verify(mockFamilyService.addNumber(uid, number)).called(1);
    });

    test('removeNumber calls FamilyService removeNumber', () async {
      const uid = '1';
      const number = 999;

      // Arrange
      when(mockFamilyService.removeNumber(uid, number)).thenAnswer((_) async => Future.value());

      // Act
      await mockFamilyService.removeNumber(uid, number);

      // Assert
      verify(mockFamilyService.removeNumber(uid, number)).called(1);
    });

    test('addPhotoUrl calls FamilyService addPhotoUrl', () async {
      const uid = '1';
      const url = 'https://example.com/photo.jpg';

      // Arrange
      when(mockFamilyService.addPhotoUrl(uid, url)).thenAnswer((_) async => Future.value());

      // Act
      await mockFamilyService.addPhotoUrl(uid, url);

      // Assert
      verify(mockFamilyService.addPhotoUrl(uid, url)).called(1);
    });

    test('removePhotoUrl calls FamilyService removePhotoUrl', () async {
      const uid = '1';
      const url = 'https://example.com/photo.jpg';

      // Arrange
      when(mockFamilyService.removePhotoUrl(uid, url)).thenAnswer((_) async => Future.value());

      // Act
      await mockFamilyService.removePhotoUrl(uid, url);

      // Assert
      verify(mockFamilyService.removePhotoUrl(uid, url)).called(1);
    });

    test('addBirthday calls FamilyService addBirthday', () async {
      const uid = '1';
      const name = 'John';
      final date = DateTime(2000, 1, 1);

      // Arrange
      when(mockFamilyService.addBirthday(uid, name, date)).thenAnswer((_) async => Future.value());

      // Act
      await mockFamilyService.addBirthday(uid, name, date);

      // Assert
      verify(mockFamilyService.addBirthday(uid, name, date)).called(1);
    });

    test('removeBirthday calls FamilyService removeBirthday', () async {
      const uid = '1';
      const birthdayDocId = 'docId';

      // Arrange
      when(mockFamilyService.removeBirthday(uid, birthdayDocId)).thenAnswer((_) async => Future.value());

      // Act
      await mockFamilyService.removeBirthday(uid, birthdayDocId);

      // Assert
      verify(mockFamilyService.removeBirthday(uid, birthdayDocId)).called(1);
    });
  });
}
