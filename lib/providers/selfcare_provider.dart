import 'package:flutter/material.dart';
import 'package:hersphere/providers/selfcareinstance_provider.dart';
import 'package:hersphere/repository/selfcareservice.dart';
import 'package:hersphere/models/selfcaremodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selfcare_provider.g.dart';

@riverpod
class SelfCareNotifier extends _$SelfCareNotifier {
  late SelfCareService _selfCareService;


  @override
  List<SelfCareModel> build() {
    _selfCareService = ref.read(selfcareServiceProvider);
    _fetchSelfcare();
    return [];
  }

  // Fetch todos as a stream and update the state
  void _fetchSelfcare() {
    _selfCareService.getAllSelfCare().listen((selfcares) {
      state = selfcares.cast<SelfCareModel>();
    });
  }

  Future<void> addOrUpdateSelfCare(SelfCareModel selfcare) async {
    try {
      await _selfCareService.addOrUpdateSelfCare(selfcare);
    } catch (error) {
      print('Error adding or updating self-care data: $error');
    }
  }

  Future<void> addJournal(String uid, String name, DateTime date) async {
    try {
      await _selfCareService.addJournal(uid, name, date);
    } catch (error) {
      print('Error adding journal: $error');
    }
  }

  Future<void> removeJournal(String uid, String journalDocId) async {
    try {
      await _selfCareService.removeJournal(uid, journalDocId);
    } catch (error) {
      print('Error removing journal: $error');
    }
  }

  Future<void> updateCheckedIndex(String uid, int index, bool value) async {
    try {
      await _selfCareService.updateCheckedIndex(uid, index, value);
    } catch (error) {
      print('Error updating checked index: $error');
    }
  }

  Future<void> updateWakeupTime(String uid, TimeOfDay newWakeupTime) async {
    try {
      await _selfCareService.updateWakeupTime(uid, newWakeupTime);
    } catch (error) {
      print('Error updating wakeup time: $error');
    }
  }

  Future<void> updateSleepTime(String uid, TimeOfDay newSleepTime) async {
    try {
      await _selfCareService.updateSleepTime(uid, newSleepTime);
    } catch (error) {
      print('Error updating sleep time: $error');
    }
  }

  
  Future<void> updateNotify(String uid, bool newValue) async {
    try {
      await _selfCareService.updateNotify(uid, newValue);
    } catch (error) {
      print('Error updating notify: $error');
    }
  }
}
