import 'package:cloud_firestore/cloud_firestore.dart';

class Birthday {
  String name;
  DateTime date;
  String id;

  Birthday({
    required this.name,
    required this.date,
    required this.id,
  });

  factory Birthday.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Birthday(
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
