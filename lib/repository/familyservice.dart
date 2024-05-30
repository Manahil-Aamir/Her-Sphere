import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hersphere/models/birthdaymodel.dart';
import 'package:hersphere/models/familymodel.dart';

class FamilyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if a family document exists by UID
  Future<bool> _familyExists(String uid) async {
    DocumentSnapshot doc =
        await _firestore.collection('families').doc(uid).get();
    return doc.exists;
  }

  // Add or Update Family document based on user UID
  Future<void> addOrUpdateFamily(Family family) async {
    try {
      bool exists = await _familyExists(family.uid);
      DocumentReference familyDoc =
          _firestore.collection('families').doc(family.uid);

      if (exists) {
        // If the document exists, update the fields
        await familyDoc.update(family.toMap());
      } else {
        // If the document does not exist, create it
        await familyDoc.set(family.toMap());
      }
    } catch (error) {
      print("Error in addOrUpdateFamily: $error");
    }
  }

  // Add a number to the family document
  Future<void> addNumber(String uid, int number) async {
    if (await _familyExists(uid)) {
      await _firestore.collection('families').doc(uid).update({
        'numbers': FieldValue.arrayUnion([number])
      });
    } else {
      await addOrUpdateFamily(Family(
        uid: uid,
        numbers: [number],
        photoUrls: [],
        birthdayDocumentIds: [],
        id: uid,
      ));
    }
  }

  // Remove a number from the family document
  Future<void> removeNumber(String uid, int number) async {
    if (await _familyExists(uid)) {
      await _firestore.collection('families').doc(uid).update({
        'numbers': FieldValue.arrayRemove([number])
      });
    }
  }

  // Add a photo URL to the family document
  Future<void> addPhotoUrl(String uid, String url) async {
    if (await _familyExists(uid)) {
      await _firestore.collection('families').doc(uid).update({
        'photoUrls': FieldValue.arrayUnion([url])
      });
    } else {
      await addOrUpdateFamily(Family(
        uid: uid,
        numbers: [],
        photoUrls: [url],
        birthdayDocumentIds: [],
        id: uid,
      ));
    }
  }

  // Remove a photo URL from the family document
  Future<void> removePhotoUrl(String uid, String url) async {
    if (await _familyExists(uid)) {
      await _firestore.collection('families').doc(uid).update({
        'photoUrls': FieldValue.arrayRemove([url])
      });
    }
  }

  // Add a birthday document ID to the family document and the birthday collection
  Future<void> addBirthday(String uid, String name, DateTime date) async {
    DocumentReference birthdayDoc =
        await _firestore.collection('birthdays').add({
      'name': name,
      'date': date,
    });
    await addBirthdayDocumentId(uid, birthdayDoc.id);
  }

  // Remove a birthday document ID from the family document and delete the birthday document
  Future<void> removeBirthday(String uid, String birthdayDocId) async {
    await removeBirthdayDocumentId(uid, birthdayDocId);
    await _firestore.collection('birthdays').doc(birthdayDocId).delete();
  }

  // Add a birthday document ID to the family document
  Future<void> addBirthdayDocumentId(String uid, String birthdayDocId) async {
    if (await _familyExists(uid)) {
      await _firestore.collection('families').doc(uid).update({
        'birthdayDocumentIds': FieldValue.arrayUnion([birthdayDocId])
      });
    } else {
      await addOrUpdateFamily(Family(
        uid: uid,
        numbers: [],
        photoUrls: [],
        birthdayDocumentIds: [birthdayDocId],
        id: uid,
      ));
    }
  }

  // Remove a birthday document ID from the family document
  Future<void> removeBirthdayDocumentId(
      String uid, String birthdayDocId) async {
    bool familyExists = await _familyExists(uid);

    if (familyExists) {
      try {
        await _firestore.collection('families').doc(uid).update({
          'birthdayDocumentIds': FieldValue.arrayRemove([birthdayDocId])
        });
      } catch (e) {
        print('Error removing birthday document ID from family document: $e');
        return;
      }
    } else {
      print('Family document does not exist for UID: $uid');
      return;
    }

    try {
      await _firestore.collection('birthdays').doc(birthdayDocId).delete();
    } catch (e) {
      print('Error removing birthday document: $e');
      return;
    }
  }

  // Get Family document as a stream
  Stream<List<Family>> getFamily(String uid) {
    return _firestore.collection('families').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Family.fromQuerySnapshot(doc)).toList();
    });
  }

  // Get Family document as a stream
  Stream<List<Family>> getAllFamily() {
    return _firestore.collection('families').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Family.fromQuerySnapshot(doc);
      }).toList();
    });
  }

  // Get numbers as a stream
  Stream<List<int>> getNumbers(String uid) {
    return _firestore.collection('families').doc(uid).snapshots().map((doc) {
      final data = doc.data();
      if (data == null || data['numbers'] == null) {
        return <int>[]; // Return an empty list if no data or 'numbers' field is found
      }
      return List<int>.from(data['numbers']);
    });
  }

  Future<List<int>> getNumberList(String uid) async {
    try {
      final docSnapshot =
          await _firestore.collection('families').doc(uid).get();
      final data = docSnapshot.data();
      if (data == null || data['numbers'] == null) {
        return <int>[]; // Return an empty list if no data or 'numbers' field is found
      }
      return List<int>.from(data['numbers']);
    } catch (e) {
      print('Error fetching numbers: $e');
      return <int>[]; // Return an empty list on error
    }
  }

// Get photo URLs as a stream
  Stream<List<String>> getPhotoUrls(String uid) {
    return _firestore.collection('families').doc(uid).snapshots().map((doc) {
      if (doc.exists &&
          doc.data() != null &&
          doc.data()!.containsKey('photoUrls')) {
        return List<String>.from(doc['photoUrls']);
      } else {
        return []; // Return an empty list if the field doesn't exist or is null
      }
    });
  }

// Stream to get birthdays
  Stream<List<Birthday>> getBirthdays(String uid) {
    return _firestore
        .collection('families')
        .doc(uid)
        .snapshots()
        .asyncMap((doc) async {
      if (doc.exists &&
          doc.data() != null &&
          doc.data()!.containsKey('birthdayDocumentIds')) {
        List<String> birthdayIds =
            List<String>.from(doc['birthdayDocumentIds'] ?? []);
        if (birthdayIds.isEmpty) {
          return [];
        }

        // Fetch birthday data for each ID
        List<Birthday> birthdays = [];
        for (String id in birthdayIds) {
          DocumentSnapshot birthdayDoc =
              await _firestore.collection('birthdays').doc(id).get();
          if (birthdayDoc.exists) {
            Map<String, dynamic> data =
                birthdayDoc.data() as Map<String, dynamic>;
            birthdays.add(Birthday(
              id: birthdayDoc.id, // Retrieve the document ID here
              name: data['name'] as String,
              date: (data['date'] as Timestamp).toDate(),
            ));
          }
        }

        return birthdays;
      } else {
        return []; // Return an empty list if the field doesn't exist or is null
      }
    });
  }
}
