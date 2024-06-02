import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/models/familymodel.dart';

import 'mockfamilyservice.dart';

void main() {
  group('MockFamilyService', () {
    late MockFamilyService mockFamilyService;

    setUp(() {
      mockFamilyService = MockFamilyService();
    });

    test('Add or Update Family', () async {
      final family = Family(
        uid: '3',
        numbers: [],
        photoUrls: [],
        birthdayDocumentIds: [],
        id: 'id3',
      );
      await mockFamilyService.addOrUpdateFamily(family);

      final familyStream = mockFamilyService.getFamily('3');
      final retrievedFamily = await familyStream.first;

      expect(retrievedFamily.first, equals(family));
    });

    test('Add Number', () async {
      final uid = '2';
      final number = 111;
      await mockFamilyService.addNumber(uid, number);

      final numbersStream = mockFamilyService.getNumbers(uid);
      final retrievedNumbers = await numbersStream.first;

      expect(retrievedNumbers, contains(number));
    });

    test('Remove Number', () async {
      final uid = '1';
      final number = 456;
      await mockFamilyService.removeNumber(uid, number);

      final numbersStream = mockFamilyService.getNumbers(uid);
      final retrievedNumbers = await numbersStream.first;

      expect(retrievedNumbers, isNot(contains(number)));
    });


    test('Remove Photo URL', () async {
      final uid = '1';
      final url = 'url1';
      await mockFamilyService.removePhotoUrl(uid, url);

      final photoUrlsStream = mockFamilyService.getPhotoUrls(uid);
      final retrievedUrls = await photoUrlsStream.first;

      expect(retrievedUrls, isNot(contains(url)));
    });

    test('Remove Birthday', () async {
      final uid = '2';
      final birthdayDocId = 'docId3';
      await mockFamilyService.removeBirthday(uid, birthdayDocId);

      final familyStream = mockFamilyService.getFamily(uid);
      final retrievedFamily = await familyStream.first;

      expect(retrievedFamily.first.birthdayDocumentIds, isNot(contains(birthdayDocId)));
    });

    test('Add Birthday Document ID', () async {
      final uid = '1';
      final birthdayDocId = 'newDocId';
      await mockFamilyService.addBirthdayDocumentId(uid, birthdayDocId);

      final familyStream = mockFamilyService.getFamily(uid);
      final retrievedFamily = await familyStream.first;

      expect(retrievedFamily.first.birthdayDocumentIds, contains(birthdayDocId));
    });



    // Additional test cases for getFamily, getAllFamily, getNumbers, and getPhotoUrls are already provided in the previous response.
  });
}