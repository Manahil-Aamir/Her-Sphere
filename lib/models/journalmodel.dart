import 'package:cloud_firestore/cloud_firestore.dart';

class JournalModel {
  String name;
  DateTime date;
  String id;

  JournalModel({
    required this.name,
    required this.date,
    required this.id,
  });

  factory JournalModel.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return JournalModel(
      name: json['name'] as String,
      date: (json['date'] as Timestamp).toDate(),
      id: doc.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
    };
  }
}
