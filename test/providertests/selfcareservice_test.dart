import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/models/selfcaremodel.dart';

import 'mockselfcareservice.dart';

void main() {
  group('MockSelfCareService', () {
    MockSelfCareService mockSelfCareService = MockSelfCareService();

    test('addOrUpdateSelfCare', () async {
      final selfCare = SelfCareModel(
        uid: '3',
        sleep: DateTime.now(),
        wakeup: DateTime.now().add(const Duration(hours: 8)),
        notify: false,
        journalDocumentIds: [],
        id: 'id3',
      );
      await mockSelfCareService.addOrUpdateSelfCare(selfCare);
      final updatedSelfCare = await mockSelfCareService.getSelfCareWithoutJournalAndChecked('3').first;
      expect(updatedSelfCare, selfCare);
    });


    test('updateNotify', () async {
      final updatedNotifyValue = true;
      final selfCareId = '1';
      await mockSelfCareService.updateNotify(selfCareId, updatedNotifyValue);
      final updatedNotify = await mockSelfCareService.getNotify(selfCareId);
      expect(updatedNotify, updatedNotifyValue);
    });

    test('updateCheckedIndex', () async {
      final updatedIndex = 0;
      final updatedValue = true;
      final selfCareId = '1';
      await mockSelfCareService.updateCheckedIndex(selfCareId, updatedIndex, updatedValue);
      final updatedSelfCare = await mockSelfCareService.getSelfCareWithoutJournalAndChecked(selfCareId).first;
      expect(updatedSelfCare.checked[updatedIndex], updatedValue);
    });

    test('updateWakeupTime', () async {
      final updatedTime = TimeOfDay(hour: 7, minute: 30);
      final selfCareId = '1';
      await mockSelfCareService.updateWakeupTime(selfCareId, updatedTime);
      final updatedSelfCare = await mockSelfCareService.getSelfCareWithoutJournalAndChecked(selfCareId).first;
      final expectedDateTime = mockSelfCareService.convertTimeOfDayToDateTime(updatedTime);
      expect(updatedSelfCare.wakeup, expectedDateTime);
    });

    test('updateSleepTime', () async {
      final updatedTime = TimeOfDay(hour: 22, minute: 0);
      final selfCareId = '1';
      await mockSelfCareService.updateSleepTime(selfCareId, updatedTime);
      final updatedSelfCare = await mockSelfCareService.getSelfCareWithoutJournalAndChecked(selfCareId).first;
      final expectedDateTime = mockSelfCareService.convertTimeOfDayToDateTime(updatedTime);
      expect(updatedSelfCare.sleep, expectedDateTime);
    });

    test('getCheckedStream', () async {
      final selfCareId = '1';
      final checkedStream = mockSelfCareService.getCheckedStream(selfCareId);
      final checkedList = await checkedStream.first;
      expect(checkedList.length, 10); // Assuming the checked list has a fixed length of 10
    });

    test('getWakeupTime', () async {
      final selfCareId = '1';
      final wakeupTime = await mockSelfCareService.getWakeupTime(selfCareId);
      expect(wakeupTime, isA<DateTime>());
    });

    test('getSleepTime', () async {
      final selfCareId = '1';
      final sleepTime = await mockSelfCareService.getSleepTime(selfCareId);
      expect(sleepTime, isA<DateTime>());
    });

    test('getNotify', () async {
      final selfCareId = '1';
      final notifyValue = await mockSelfCareService.getNotify(selfCareId);
      expect(notifyValue, isA<bool>());
    });

  
  });
}
