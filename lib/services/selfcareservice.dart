import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hersphere/models/journalmodel.dart';
import 'package:hersphere/models/selfcaremodel.dart';

class SelfCareService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if a selfcare document exists by UID
  Future<bool> _SelfCareExists(String uid) async {
    DocumentSnapshot doc =
        await _firestore.collection('selfcare').doc(uid).get();
    return doc.exists;
  }

  // Add or Update Selfcare document based on user UID
  Future<void> addOrUpdateSelfCare(SelfCareModel selfcare) async {
    try {
      bool exists = await _SelfCareExists(selfcare.uid);
      DocumentReference familyDoc =
          _firestore.collection('selfcare').doc(selfcare.uid);

      if (exists) {
        // If the document exists, update the fields
        await familyDoc.update(selfcare.toMap());
      } else {
        // If the document does not exist, create it
        await familyDoc.set(selfcare.toMap());
      }
    } catch (error) {
      print("Error in addOrUpdateFamily: $error");
    }
  }

  // Add a journal document ID to the selfcare document and the journal collection
  Future<void> addJournal(String uid, String name, DateTime date) async {
    DocumentReference journalDoc = await _firestore.collection('journal').add({
      'name': name,
      'date': date,
    });
    await addJournalDocumentId(uid, journalDoc.id);
  }

  // Remove a journal document ID from the selfcare document and delete the journal document
  Future<void> removeJournal(String uid, String journalDocId) async {
    await removeJournalDocumentId(uid, journalDocId);
    await _firestore.collection('journal').doc(journalDocId).delete();
  }

  // Add a journal document ID to the family document
  Future<void> addJournalDocumentId(String uid, String journalDocId) async {
    if (await _SelfCareExists(uid)) {
      await _firestore.collection('selfcare').doc(uid).update({
        'journalDocumentIds': FieldValue.arrayUnion([journalDocId])
      });
    } else {
      await addOrUpdateSelfCare(SelfCareModel(
          uid: uid,
          journalDocumentIds: [journalDocId],
          sleep: DateTime.now(),
          wakeup: DateTime.now().add(const Duration(hours: 8)),
          notify: false,
          checked: List<bool>.filled(10, false),
          id: ''));
    }
  }

  // Remove a journal document ID from the family document
  Future<void> removeJournalDocumentId(String uid, String journalDocId) async {
    bool selfcareExists = await _SelfCareExists(uid);

    if (selfcareExists) {
      try {
        await _firestore.collection('selfcare').doc(uid).update({
          'journalDocumentIds': FieldValue.arrayRemove([journalDocId])
        });
      } catch (e) {
        print(
            'Error removing journalthday document ID from selfcare document: $e');
        return;
      }
    } else {
      print('Selfcare document does not exist for UID: $uid');
      return;
    }

    try {
      await _firestore.collection('journal').doc(journalDocId).delete();
    } catch (e) {
      print('Error removing journal document: $e');
      return;
    }
  }

  // Update notify value
  Future<void> updateNotify(String uid, bool newValue) async {
    try {
      if (await _SelfCareExists(uid)) {
        await _firestore
            .collection('selfcare')
            .doc(uid)
            .update({'notify': newValue});
      } else {
        // If the document does not exist, create it first
        await addOrUpdateSelfCare(SelfCareModel(
            uid: uid,
            journalDocumentIds: [],
            sleep: DateTime.now(),
            wakeup: DateTime.now().add(const Duration(hours: 8)),
            notify: newValue,
            checked: List<bool>.filled(10, false),
            id: ''));
      }
    } catch (error) {
      print("Error updating notify value: $error");
    }
  }

  // Update checked index
  Future<void> updateCheckedIndex(String uid, int index, bool value) async {
    try {
      if (await _SelfCareExists(uid)) {
        await _firestore.collection('selfcare').doc(uid).update({
          'checked.$index': value,
        });
      } else {
        // If the document does not exist, create it first
        await addOrUpdateSelfCare(SelfCareModel(
            uid: uid,
            journalDocumentIds: [],
            sleep: DateTime.now(),
            wakeup: DateTime.now().add(const Duration(hours: 8)),
            notify: false,
            checked: List<bool>.filled(10, false),
            id: ''));
        // Now update the checked index
        await _firestore.collection('selfcare').doc(uid).update({
          'checked.$index': value,
        });
      }
    } catch (error) {
      print("Error updating checked index: $error");
    }
  }

  DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  //Update the wakeup time
  Future<void> updateWakeupTime(String uid, TimeOfDay newWakeupTime) async {
    DateTime newWakeupDateTime = convertTimeOfDayToDateTime(newWakeupTime);
    try {
      if (await _SelfCareExists(uid)) {
        await _firestore.collection('selfcare').doc(uid).update({
          'wakeup': newWakeupDateTime,
        });
      } else {
        await addOrUpdateSelfCare(SelfCareModel(
            uid: uid,
            wakeup: newWakeupDateTime,
            sleep: DateTime.now(),
            notify: false,
            checked: List<bool>.filled(10, false),
            journalDocumentIds: [],
            id: ''));
      }
    } catch (error) {
      print("Error updating wakeup time: $error");
    }
  }

  //Update the sleep time
  Future<void> updateSleepTime(String uid, TimeOfDay newSleepTime) async {
    DateTime newSleepDateTime = convertTimeOfDayToDateTime(newSleepTime);
    try {
      if (await _SelfCareExists(uid)) {
        await _firestore.collection('selfcare').doc(uid).update({
          'sleep': newSleepDateTime,
        });
      } else {
        await addOrUpdateSelfCare(SelfCareModel(
            uid: uid,
            sleep: newSleepDateTime,
            wakeup: DateTime.now().add(const Duration(hours: 8)),
            notify: false,
            checked: List<bool>.filled(10, false),
            journalDocumentIds: [],
            id: ''));
      }
    } catch (error) {
      print("Error updating sleep time: $error");
    }
  }

  //Getting the checked array as stream
  Stream<List<bool>> getCheckedStream(String uid) {
    return _firestore.collection('selfcare').doc(uid).snapshots().map((doc) {
      if (!doc.exists) {
        // Create the document with default data if it doesn't exist
        _firestore.collection('selfcare').doc(uid).set({
          'sleep': DateTime.now(), // Default sleep time
          'wakeup': DateTime.now()
              .add(const Duration(hours: 8)), // Default wakeup time
          'notify': false, // Default notify flag
          'checked': List<bool>.filled(10, false), // Default checked array
          'journalDocumentIds': [], // Default journal document IDs
          'uid': uid
        });
        return List<bool>.filled(10, false); // Return a default checked array
      } else {
        final data = doc.data();
        if (data == null || data['checked'] == null) {
          return List<bool>.filled(10, false); // Return a default checked array
        }

        // Ensure that the 'checked' field is a List<dynamic> or Map<String, dynamic>
        final checkedData = data['checked'];
        if (checkedData is List<dynamic>) {
          // Convert List<dynamic> to List<bool>
          return List<bool>.from(checkedData.map((e) => e as bool));
        } else if (checkedData is Map<String, dynamic>) {
          // Convert map values to boolean based on their string representation
          final List<bool> checkedList = List<bool>.filled(10, false);
          checkedData.forEach((key, value) {
            final index = int.tryParse(key);
            if (index != null && index >= 0 && index < checkedList.length) {
              if (value is bool) {
                checkedList[index] = value;
              } else if (value is String) {
                // Convert string representation of boolean to actual boolean
                checkedList[index] = value.toLowerCase() == 'true';
              } else {
                // For other types, set default value
                checkedList[index] =
                    false; // or true, depending on your default behavior
              }
            }
          });

          return checkedList;
        } else {
          // Handle other types
          print(
              'Unexpected data type for the \'checked\' field: ${checkedData.runtimeType}');
          return List<bool>.filled(10, false); // Return a default checked array
        }
      }
    });
  }

  // Getter for wakeup time
  Future<DateTime?> getWakeupTime(String uid) async {
    try {
      final docSnapshot =
          await _firestore.collection('selfcare').doc(uid).get();
      final data = docSnapshot.data();
      if (data == null || data['wakeup'] == null) {
        return null; // Return null if no data or 'wakeup' field is found
      }
      return (data['wakeup'] as Timestamp).toDate();
    } catch (e) {
      print('Error fetching wakeup time: $e');
      return null;
    }
  }

  // Getter for sleep time
  Future<DateTime?> getSleepTime(String uid) async {
    try {
      final docSnapshot =
          await _firestore.collection('selfcare').doc(uid).get();
      final data = docSnapshot.data();
      if (data == null || data['sleep'] == null) {
        return null; // Return null if no data or 'sleep' field is found
      }
      return (data['sleep'] as Timestamp).toDate();
    } catch (e) {
      print('Error fetching sleep time: $e');
      return null;
    }
  }

  // Getter for notify boolean
  Future<bool> getNotify(String uid) async {
    try {
      final docSnapshot =
          await _firestore.collection('selfcare').doc(uid).get();
      final data = docSnapshot.data();
      if (data == null || data['notify'] == null) {
        return false; // Return false if no data or 'notify' field is found
      }
      return data['notify'] as bool;
    } catch (e) {
      print('Error fetching notify status: $e');
      return false;
    }
  }

  //Stream to get all info for hydration
  Stream<SelfCareModel> getSelfCareWithoutJournalAndChecked(String uid) {
    return _firestore
        .collection('selfcare')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return SelfCareModel.fromQuerySnapshot(snapshot);
      } else {
        // Return a default SelfCareModel if the document doesn't exist
        return SelfCareModel(
          uid: uid,
          id: '',
          sleep: DateTime.now(),
          wakeup: DateTime.now(),
          notify: false,
          journalDocumentIds: [],
        );
      }
    });
  }

  // Stream to get journals
  Stream<List<JournalModel>> getJournals(String uid) {
    return _firestore
        .collection('selfcare')
        .doc(uid)
        .snapshots()
        .asyncMap((doc) async {
      if (doc.exists &&
          doc.data() != null &&
          doc.data()!.containsKey('journalDocumentIds')) {
        List<String> journalIds =
            List<String>.from(doc['journalDocumentIds'] ?? []);
        if (journalIds.isEmpty) {
          return [];
        }

        // Fetch journal data for each ID
        List<JournalModel> journals = [];
        for (String id in journalIds) {
          DocumentSnapshot journalDoc =
              await _firestore.collection('journal').doc(id).get();
          if (journalDoc.exists) {
            Map<String, dynamic> data =
                journalDoc.data() as Map<String, dynamic>;
            journals.add(JournalModel(
              id: journalDoc.id, // Retrieve the document ID here
              name: data['name'] as String,
              date: (data['date'] as Timestamp).toDate(),
            ));
          }
        }

        // Sort journals by date in ascending order
        journals.sort((a, b) => b.date.compareTo(a.date));

        return journals;
      } else {
        return []; // Return an empty list if the field doesn't exist or is null
      }
    });
  }

  // Get Selfcare document as a stream
  Stream<List<SelfCareModel>> getAllSelfCare() {
    return _firestore.collection('selfcare').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return SelfCareModel.fromQuerySnapshot(doc);
      }).toList();
    });
  }
}
