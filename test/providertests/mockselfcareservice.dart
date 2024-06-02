import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:hersphere/models/selfcaremodel.dart';
import 'package:hersphere/models/journalmodel.dart';
import 'package:hersphere/services/selfcareservice.dart';

import 'dart:async';

class MockSelfCareService extends Mock implements SelfCareService {
  List<SelfCareModel> _mockData = [];
  List<JournalModel> _mockJournals = [];

  MockSelfCareService() {
    // Initialize mock data for SelfCareModel
    _mockData = [
      SelfCareModel(
        uid: '1',
        sleep: DateTime.now(),
        wakeup: DateTime.now().add(const Duration(hours: 8)),
        notify: false,
        journalDocumentIds: ['docId1', 'docId2'],
        id: 'id1',
      ),
      SelfCareModel(
        uid: '2',
        sleep: DateTime.now(),
        wakeup: DateTime.now().add(const Duration(hours: 8)),
        notify: false,
        journalDocumentIds: ['docId3'],
        id: 'id2',
      ),
    ];

    // Initialize mock data for JournalModel
    _mockJournals = [
      JournalModel(
        name: 'Journal 1',
        date: DateTime.now().subtract(Duration(days: 2)),
        id: 'docId1',
      ),
      JournalModel(
        name: 'Journal 2',
        date: DateTime.now().subtract(Duration(days: 1)),
        id: 'docId2',
      ),
      JournalModel(
        name: 'Journal 3',
        date: DateTime.now(),
        id: 'docId3',
      ),
    ];
  }

  @override
  Future<void> addOrUpdateSelfCare(SelfCareModel selfcare) async {
    final index =
        _mockData.indexWhere((element) => element.uid == selfcare.uid);
    if (index != -1) {
      _mockData[index] = selfcare;
    } else {
      _mockData.add(selfcare);
    }
  }

  @override
  Future<void> addJournal(String uid, String name, DateTime date) async {
    _mockJournals.add(JournalModel(name: name, date: date, id: uid));
  }

  @override
  Future<void> removeJournal(String uid, String journalDocId) async {
    _mockJournals.removeWhere((journal) => journal.id == journalDocId);
  }

  @override
  Future<void> updateNotify(String uid, bool newValue) async {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].notify = newValue;
    }
  }

  @override
  Future<void> updateCheckedIndex(String uid, int index, bool value) async {
    final selfCareIndex = _mockData.indexWhere((element) => element.uid == uid);
    if (selfCareIndex != -1) {
      // For this example, let's assume checked list has fixed length of 10
      _mockData[selfCareIndex].checked[index] = value;
    }
  }

  @override
  DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  @override
  Future<void> updateWakeupTime(String uid, TimeOfDay newWakeupTime) async {
    DateTime newWakeupDateTime = convertTimeOfDayToDateTime(newWakeupTime);
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].wakeup = newWakeupDateTime;
    }
  }

  @override
  Future<void> updateSleepTime(String uid, TimeOfDay newSleepTime) async {
    DateTime newSleepDateTime = convertTimeOfDayToDateTime(newSleepTime);
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      _mockData[index].sleep = newSleepDateTime;
    }
  }

  @override
  Stream<List<bool>> getCheckedStream(String uid) {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      return Stream.value(_mockData[index].checked);
    } else {
      return Stream.value(List<bool>.filled(10, false));
    }
  }

  @override
  Future<DateTime?> getWakeupTime(String uid) async {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      return _mockData[index].wakeup;
    } else {
      return null;
    }
  }

  @override
  Future<DateTime?> getSleepTime(String uid) async {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      return _mockData[index].sleep;
    } else {
      return null;
    }
  }

  @override
  Future<bool> getNotify(String uid) async {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      return _mockData[index].notify;
    } else {
      return false;
    }
  }

  @override
  Stream<SelfCareModel> getSelfCareWithoutJournalAndChecked(String uid) {
    final index = _mockData.indexWhere((element) => element.uid == uid);
    if (index != -1) {
      return Stream.value(_mockData[index]);
    } else {
      return Stream.empty();
    }
  }

  @override
  Stream<List<JournalModel>> getJournals(String uid) {
    final selfCare = _mockData.firstWhere((selfCare) => selfCare.uid == uid,
        orElse: () => SelfCareModel(
            uid: '',
            wakeup: DateTime.now(),
            sleep: DateTime.now(),
            notify: false,
            checked: [],
            journalDocumentIds: [],
            id: ''));
    if (selfCare.uid == uid) {
      final journals = selfCare.journalDocumentIds
          .map((id) => _mockJournals.firstWhere((journal) => journal.id == id,
              orElse: () =>
                  JournalModel(name: '', date: DateTime.now(), id: '')))
          .where((journal) => journal != null)
          .toList();
      return Stream.value(journals);
    } else {
      return Stream.value(
          []); // Return an empty list if no matching self-care model is found
    }
  }

  @override
  Stream<List<SelfCareModel>> getAllSelfCare() {
    return Stream.value(_mockData);
  }
}
