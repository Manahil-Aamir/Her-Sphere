import 'package:cloud_firestore/cloud_firestore.dart';

class SelfCareModel {
  String uid;
  List<String> journalDocumentIds;
  String id;
  DateTime sleep;
  DateTime wakeup;
  bool notify;
  List<bool> checked;

  SelfCareModel({
    required this.uid,
    required this.journalDocumentIds,
    required this.id,
    required this.sleep,
    required this.wakeup,
    this.notify = false, // Default to false if not specified
    List<bool>? checked, // Optional parameter
  })  : checked = checked ?? List<bool>.filled(10, false),
        assert((checked == null || checked.length == 10), 'Checked array must be exactly 10 elements.');

  factory SelfCareModel.fromQuerySnapshot(DocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return SelfCareModel(
      uid: json['uid'] as String,
      journalDocumentIds: List<String>.from(json['journalDocumentIds']),
      id: doc.id,
      sleep: (json['sleep'] as Timestamp).toDate(),
      wakeup: (json['wakeup'] as Timestamp).toDate(),
      notify: json['notify'] as bool? ?? false, // Default to false if not present in the document
      checked : List<bool>.filled(10, false),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'journalDocumentIds': journalDocumentIds,
      'sleep': Timestamp.fromDate(sleep),
      'wakeup': Timestamp.fromDate(wakeup),
      'notify': notify,
      'checked': checked,
    };
  }
}
