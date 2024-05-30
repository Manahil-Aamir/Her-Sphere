import 'package:cloud_firestore/cloud_firestore.dart';

class ToDos {
  String data;
  bool check;
  String id;

  ToDos({
    required this.data,
    required this.check,
    required this.id,
  });

  factory ToDos.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return ToDos(
      data: json['name'] as String,
      check: json['check'] as bool,
      id: doc.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'check': check,
    };
  }
}
