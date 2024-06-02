import 'package:hersphere/models/taskmodel.dart';
import 'package:hersphere/models/todosmodel.dart';
import 'package:hersphere/services/taskservice.dart';
import 'package:mockito/mockito.dart';

class MockTaskService extends Mock implements TaskService{

  List<TaskModel> _mockTasks = [];
  List<ToDos> _mockToDos = [];

  MockTaskService() {
    _mockTasks = [
      TaskModel(
        uid: '1',
        total: 100,
        housing: 30,
        transportation: 20,
        food: 15,
        healthcare: 10,
        utilities: 10,
        misc: 15,
        taskDocumentIds: ['todo1', 'todo2'],
        id: 'task1',
      ),
      TaskModel(
        uid: '2',
        total: 150,
        housing: 40,
        transportation: 30,
        food: 20,
        healthcare: 15,
        utilities: 15,
        misc: 30,
        taskDocumentIds: ['todo3'],
        id: 'task2',
      ),
    ];

    _mockToDos = [
      ToDos(
        data: 'Complete assignment',
        check: false,
        id: 'todo1',
      ),
      ToDos(
        data: 'Prepare presentation',
        check: true,
        id: 'todo2',
      ),
      ToDos(
        data: 'Attend meeting',
        check: false,
        id: 'todo3',
      ),
    ];
  }

  Future<bool> taskExists(String uid) async {
    return _mockTasks.any((task) => task.uid == uid);
  }

  Future<void> updateToDoChecked(String toDoDocId, bool checked) async {
    final todo = _mockToDos.firstWhere((todo) => todo.id == toDoDocId);
    todo.check = checked;
  }

  Future<void> addOrUpdateTask(TaskModel task) async {
    final index = _mockTasks.indexWhere((t) => t.uid == task.uid);
    if (index != -1) {
      _mockTasks[index] = task;
    } else {
      _mockTasks.add(task);
    }
  }

  Future<void> addToDo(String uid, String data, bool check) async {
    final toDo = ToDos(data: data, check: check, id: 'newTodoId');
    _mockToDos.add(toDo);
    _mockTasks.firstWhere((task) => task.uid == uid).taskDocumentIds.add(toDo.id);
  }

  Future<void> removeToDo(String uid, String toDoDocId) async {
    _mockToDos.removeWhere((todo) => todo.id == toDoDocId);
    _mockTasks.firstWhere((task) => task.uid == uid).taskDocumentIds.remove(toDoDocId);
  }

  Future<void> addToDoDocumentId(String uid, String toDoDocId) async {
    _mockTasks.firstWhere((task) => task.uid == uid).taskDocumentIds.add(toDoDocId);
  }

  Future<void> removeToDoDocumentId(String uid, String toDoDocId) async {
    _mockTasks.firstWhere((task) => task.uid == uid).taskDocumentIds.remove(toDoDocId);
  }

  Future<void> updateToDo(String toDoDocId, String data, bool check) async {
    final index = _mockToDos.indexWhere((todo) => todo.id == toDoDocId);
    if (index != -1) {
      _mockToDos[index] = ToDos(data: data, check: check, id: toDoDocId);
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    return _mockTasks;
  }

  Stream<TaskModel> getTaskWithoutToDos(String uid) {
    final task = _mockTasks.firstWhere((task) => task.uid == uid, orElse: () => TaskModel(uid: '', total: 0, housing: 0, transportation: 0, food: 0, healthcare: 0, utilities: 0, misc: 0, taskDocumentIds: [], id: ''));
    return Stream.value(task);
  }

Stream<List<ToDos>> getToDos(String taskId) {
  final task = _mockTasks.firstWhere((task) => task.id == taskId, orElse: () => TaskModel(uid: '', total: 0, housing: 0, transportation: 0, food: 0, healthcare: 0, utilities: 0, misc: 0, taskDocumentIds: [], id: ''));
  final todos = task.taskDocumentIds
      .map((id) => _mockToDos.firstWhere((todo) => todo.id == id, orElse: () => ToDos(data: '', check: false, id: '')))
      .where((todo) => todo != null)
      .toList();
  return Stream.value(todos);
}


  Future<void> updateTaskIntValue(String uid, String attribute, int value) async {
    final index = _mockTasks.indexWhere((task) => task.uid == uid);
    if (index != -1) {
      final task = _mockTasks[index];
      switch (attribute) {
        case 'total':
          task.total = value;
          break;
        case 'housing':
          task.housing = value;
          break;
        case 'transportation':
          task.transportation = value;
          break;
        case 'food':
          task.food = value;
          break;
        case 'healthcare':
          task.healthcare = value;
          break;
        case 'utilities':
          task.utilities = value;
          break;
        case 'misc':
          task.misc = value;
          break;
        default:
          break;
      }
    }
  }

  Stream<int> getRemaining(String uid) {
    final task = _mockTasks.firstWhere((task) => task.uid == uid, orElse: () => TaskModel(uid: '', total: 0, housing: 0, transportation: 0, food: 0, healthcare: 0, utilities: 0, misc: 0, taskDocumentIds: [], id: ''));
    final remaining = task != null ? task.total - (task.housing + task.transportation + task.food + task.healthcare + task.utilities + task.misc) : 0;
    return Stream.value(remaining);
  }
}