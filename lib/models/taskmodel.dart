import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String uid;
  int total;
  int housing;
  int transportation;
  int food;
  int healthcare;
  int utilities;
  int misc;
  List<String> taskDocumentIds;
  String id;

  TaskModel({
    required this.uid,
    required this.total,
    required this.housing,
    required this.transportation,
    required this.food,
    required this.healthcare,
    required this.utilities,
    required this.misc,
    required this.taskDocumentIds,
    required this.id,
  });

  factory TaskModel.fromQuerySnapshot(DocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return TaskModel(
      uid: json['uid'] as String,
      total: json['total'] as int,
      housing: json['housing'] as int,
      transportation: json['transportation'] as int,
      food: json['food'] as int,
      healthcare: json['healthcare'] as int,
      utilities: json['utilities'] as int,
      misc: json['misc'] as int,
      taskDocumentIds: List<String>.from(json['taskDocumentIds']),
      id: doc.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'total': total,
      'housing': housing,
      'transportation': transportation,
      'food': food,
      'healthcare': healthcare,
      'utilities': utilities,
      'misc': misc,
      'taskDocumentIds': taskDocumentIds,
    };
  }
}
