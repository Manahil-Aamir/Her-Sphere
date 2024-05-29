import 'package:cloud_firestore/cloud_firestore.dart';

class Family {
  String uid;
  List<int> numbers;
  List<String> photoUrls;
  List<String> birthdayDocumentIds;
  String id;

  Family({
    required this.uid,
    required this.numbers,
    required this.photoUrls,
    required this.birthdayDocumentIds,
    required this.id,
  });

  factory Family.fromQuerySnapshot(DocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Family(
      uid: json['uid'] as String,
      numbers: List<int>.from(json['numbers']),
      photoUrls: List<String>.from(json['photoUrls']),
      birthdayDocumentIds: List<String>.from(json['birthdayDocumentIds']),
      id: doc.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'numbers': numbers,
      'photoUrls': photoUrls,
      'birthdayDocumentIds': birthdayDocumentIds,
    };
  }
}

