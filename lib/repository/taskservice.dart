import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hersphere/models/taskmodel.dart';
import 'package:hersphere/models/todosmodel.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if a task document exists by UID
  Future<bool> _taskExists(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('tasks').doc(uid).get();
    return doc.exists;
  }

  //Update the checkbox of ToDo
  Future<void> updateToDoChecked(String toDoDocId, bool checked) async {
    try {
      await _firestore
        ..collection('todos').doc(toDoDocId).update({
          'check': checked,
        });
    } catch (error) {
      print("Error in updateToDoChecked: $error");
    }
  }
  
  // Add or Update Task document based on user UID
  Future<void> addOrUpdateTask(TaskModel task) async {
    try {
      bool exists = await _taskExists(task.uid);
      DocumentReference taskDoc = _firestore.collection('tasks').doc(task.uid);

      if (exists) {
        await taskDoc.update(task.toMap());
      } else {
        await taskDoc.set(task.toMap());
      }
    } catch (error) {
      print("Error in addOrUpdateTask: $error");
    }
  }

  // Add a ToDo document ID to the task document and the todos collection
  Future<void> addToDo(String uid, String data, bool check) async {
    DocumentReference toDoDoc = await _firestore.collection('todos').add({
      'data': data,
      'check': check,
    });
    await addToDoDocumentId(uid, toDoDoc.id);
  }

  // Remove a ToDo document ID from the task document and delete the ToDo document
  Future<void> removeToDo(String uid, String toDoDocId) async {
    await removeToDoDocumentId(uid, toDoDocId);
    await _firestore.collection('todos').doc(toDoDocId).delete();
  }

  // Add a ToDo document ID to the task document
  Future<void> addToDoDocumentId(String uid, String toDoDocId) async {
    if (await _taskExists(uid)) {
      await _firestore.collection('tasks').doc(uid).update({
        'taskDocumentIds': FieldValue.arrayUnion([toDoDocId])
      });
    } else {
      await addOrUpdateTask(TaskModel(
        uid: uid,
        total: 0, // Add appropriate initial values
        housing: 0,
        transportation: 0,
        food: 0,
        healthcare: 0,
        utilities: 0,
        misc: 0,
        taskDocumentIds: [toDoDocId],
        id: uid,
      ));
    }
  }

  // Remove a ToDo document ID from the task document
  Future<void> removeToDoDocumentId(String uid, String toDoDocId) async {
    bool taskExists = await _taskExists(uid);

    if (taskExists) {
      try {
        await _firestore.collection('tasks').doc(uid).update({
          'taskDocumentIds': FieldValue.arrayRemove([toDoDocId])
        });
      } catch (e) {
        print('Error removing ToDo document ID from task document: $e');
        return;
      }
    } else {
      print('Task document does not exist for UID: $uid');
      return;
    }

    try {
      await _firestore.collection('todos').doc(toDoDocId).delete();
    } catch (e) {
      print('Error removing ToDo document: $e');
      return;
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    final snapshot = await _firestore.collection('tasks').get();
    if (snapshot.docs.isEmpty) {
      return [];
    }
    return snapshot.docs
        .map((doc) => TaskModel.fromQuerySnapshot(doc))
        .toList();
  }

  Stream<TaskModel> getTaskWithoutToDos(String uid) {
    return _firestore
        .collection('tasks')
        .doc(uid)
        .snapshots()
        .asyncMap((snapshot) async {
      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data() as Map<String, dynamic>;
        return TaskModel(
          uid: data['uid'] as String,
          total: data['total'] as int,
          housing: data['housing'] as int,
          transportation: data['transportation'] as int,
          food: data['food'] as int,
          healthcare: data['healthcare'] as int,
          utilities: data['utilities'] as int,
          misc: data['misc'] as int,
          taskDocumentIds: List<String>.from(data['taskDocumentIds'] ?? []),
          id: snapshot.id,
        );
      } else {
        // Create a new TaskModel if it doesn't exist
        final newTask = TaskModel(
          uid: uid,
          total: 0, // Add appropriate initial values
          housing: 0,
          transportation: 0,
          food: 0,
          healthcare: 0,
          utilities: 0,
          misc: 0,
          taskDocumentIds: [],
          id: uid,
        );

        // Save the new TaskModel to Firestore
        await addOrUpdateTask(newTask);

        // Return the new TaskModel
        return newTask;
      }
    });
  }

  Stream<List<ToDos>> getToDos(String taskId) {
    return _firestore
        .collection('tasks')
        .doc(taskId)
        .snapshots()
        .asyncMap((doc) async {
      if (doc.exists &&
          doc.data() != null &&
          doc.data()!.containsKey('taskDocumentIds')) {
        List<String> todoIds = List<String>.from(doc['taskDocumentIds'] ?? []);
        if (todoIds.isEmpty) {
          return [];
        }

        // Fetch ToDos data for each ID
        List<ToDos> todos = [];
        for (String id in todoIds) {
          DocumentSnapshot todoDoc =
              await _firestore.collection('todos').doc(id).get();
          if (todoDoc.exists) {
            Map<String, dynamic> data = todoDoc.data() as Map<String, dynamic>;
            todos.add(ToDos(
              data: data['data'] as String,
              check: data['check'] as bool,
              id: todoDoc.id, // Retrieve the document ID here
            ));
          }
        }

        return todos;
      } else {
        return []; // Return an empty list if the field doesn't exist or is null
      }
    });
  }

  Future<void> updateTaskIntValue(
      String uid, String attribute, int value) async {
    try {
      await _firestore.collection('tasks').doc(uid).update({
        attribute: value,
      });
    } catch (e) {
      print('Error updating $attribute for task $uid: $e');
    }
  }

  Stream<int> getRemaining(String uid) {
    return _firestore.collection('tasks').doc(uid).snapshots().map((doc) {
      final data = doc.data();
      if (data == null) return 0;

      int total = data['total'] ?? 0;
      int housing = data['housing'] ?? 0;
      int transportation = data['transportation'] ?? 0;
      int food = data['food'] ?? 0;
      int healthcare = data['healthcare'] ?? 0;
      int utilities = data['utilities'] ?? 0;
      int misc = data['misc'] ?? 0;

      return total -
          (housing + transportation + food + healthcare + utilities + misc);
    });
  }
}
