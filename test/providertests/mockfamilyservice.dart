import 'package:hersphere/models/birthdaymodel.dart';
import 'package:hersphere/models/familymodel.dart';
import 'package:hersphere/services/familyservice.dart';

class MockFamilyService implements FamilyService {
  List<Family> _mockData = [];

  MockFamilyService() {
    // Initialize mock data
    _mockData = [
      Family(
        uid: '1',
        numbers: [123, 456],
        photoUrls: ['url1', 'url2'],
        birthdayDocumentIds: ['docId1', 'docId2'],
        id: 'id1',
      ),
      Family(
        uid: '2',
        numbers: [789],
        photoUrls: ['url3'],
        birthdayDocumentIds: ['docId3'],
        id: 'id2',
      ),
    ];
  }

  @override
  Future<void> addOrUpdateFamily(Family family) async {
    final index = _mockData.indexWhere((element) => element.uid == family.uid);
    if (index != -1) {
      _mockData[index] = family;
    } else {
      _mockData.add(family);
    }
  }

  @override
  Future<void> addNumber(String uid, int number) async {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].numbers.add(number);
    }
  }

  @override
  Future<void> removeNumber(String uid, int number) async {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].numbers.remove(number);
    }
  }

  @override
  Future<void> addPhotoUrl(String uid, String url) async {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].photoUrls.add(url);
    }
  }

  @override
  Future<void> removePhotoUrl(String uid, String url) async {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].photoUrls.remove(url);
    }
  }

  @override
  Future<void> addBirthday(String uid, String name, DateTime date) async {
    // Mock implementation to add birthday to the family
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].birthdayDocumentIds.add('newDocId'); // Mocking adding a birthday document ID
    }
  }

  @override
  Future<void> removeBirthday(String uid, String birthdayDocId) async {
    // Mock implementation to remove birthday from the family
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].birthdayDocumentIds.remove(birthdayDocId); // Mocking removing a birthday document ID
    }
  }

  @override
  Future<void> addBirthdayDocumentId(String uid, String birthdayDocId) async {
    // Mock implementation to add birthday document ID to the family
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].birthdayDocumentIds.add(birthdayDocId); // Mocking adding a birthday document ID
    }
  }

  @override
  Future<void> removeBirthdayDocumentId(String uid, String birthdayDocId) async {
    // Mock implementation to remove birthday document ID from the family
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].birthdayDocumentIds.remove(birthdayDocId); // Mocking removing a birthday document ID
    }
  }

  @override
  Stream<List<Family>> getFamily(String uid) {
    return Stream.value(_mockData.where((family) => family.uid == uid).toList());
  }

  @override
  Stream<List<Family>> getAllFamily() {
    return Stream.value(_mockData);
  }

  @override
  Stream<List<int>> getNumbers(String uid) {
    final family = _mockData.firstWhere((element) => element.uid == uid);
    return Stream.value(family.numbers);
  }

  @override
  Stream<List<String>> getPhotoUrls(String uid) {
    final family = _mockData.firstWhere((element) => element.uid == uid);
    return Stream.value(family.photoUrls);
  }
  
  @override
  Stream<List<Birthday>> getBirthdays(String uid) {
    // TODO: implement getBirthdays
    throw UnimplementedError();
  }
  
  @override
  Future<List<int>> getNumberList(String uid) {
    // TODO: implement getNumberList
    throw UnimplementedError();
  }
}