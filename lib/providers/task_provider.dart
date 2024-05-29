import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/models/taskmodel.dart';
import 'package:hersphere/models/todos.dart';
import 'package:hersphere/providers/taskinstance_provider.dart';
import 'package:hersphere/repository/taskservice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_provider.g.dart';

@riverpod
class TaskNotifier extends _$TaskNotifier {

  late TaskService _taskService;

 
  @override
  List<TaskModel> build() {
    _taskService = ref.read(taskServiceProvider);
    _fetchAllTasks();
    return [];
  }

  void _fetchAllTasks() {
    _taskService.getAllTasks().then((tasks) {
      state = tasks;
    }).catchError((error) {
      print('Error fetching tasks: $error');
    });
  }

    // Add or update a todo
  Future<void> addOrUpdateToDo(String docId,bool val) async {
    try {
      await _taskService.updateToDoChecked(docId, val);
      _fetchAllTasks();
    } catch (error) {
      print('Error adding or updating ToDo: $error');
    }
  }

  Future<void> addOrUpdateTask(TaskModel task) async {
    try {
      await _taskService.addOrUpdateTask(task);
      _fetchAllTasks();
    } catch (error) {
      print('Error adding or updating task: $error');
    }
  }

  Future<void> addToDo(String taskId, String data, bool check) async {
    try {
      await _taskService.addToDo(taskId, data, check);
      _fetchAllTasks();
    } catch (error) {
      print('Error adding ToDo: $error');
    }
  }

  Future<void> removeToDo(String taskId, String toDoId) async {
    try {
      await _taskService.removeToDo(taskId, toDoId);
      _fetchAllTasks();
    } catch (error) {
      print('Error removing ToDo: $error');
    }
  }

  Future<void> updateTaskIntValue(String uid, String attribute, int value) async {
    try {
      await _taskService.updateTaskIntValue(uid, attribute, value);
      _fetchAllTasks();
    } catch (error) {
      print('Error updating $attribute: $error');
    }
  }

  Stream<int> getRemaining(String uid) {
    return _taskService.getRemaining(uid);
  }
}
