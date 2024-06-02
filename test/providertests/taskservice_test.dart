import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/models/taskmodel.dart';
import 'package:hersphere/models/todosmodel.dart';

import 'mocktaskservice.dart';

void main() {
  group('MockTaskService', () {
    MockTaskService mockTaskService = MockTaskService();

    test('addOrUpdateTask', () async {
      final task = TaskModel(
        uid: '3',
        total: 200,
        housing: 50,
        transportation: 40,
        food: 30,
        healthcare: 20,
        utilities: 20,
        misc: 40,
        taskDocumentIds: [],
        id: 'task3',
      );
      await mockTaskService.addOrUpdateTask(task);
      final updatedTask = await mockTaskService.getTaskWithoutToDos('3').first;
      expect(updatedTask, task);
    });

    test('updateToDoChecked', () async {
      final updatedToDoId = 'todo1';
      final updatedCheckedValue = true;
      await mockTaskService.updateToDoChecked(
          updatedToDoId, updatedCheckedValue);
      final updatedToDo = await mockTaskService.getToDos('task1').first;
      final toDoToUpdate =
          updatedToDo.firstWhere((todo) => todo.id == updatedToDoId);
      expect(toDoToUpdate.check, updatedCheckedValue);
    });

    test('updateTaskIntValue', () async {
      final uid = '1';
      final attribute = 'total';
      final updatedValue = 120;
      await mockTaskService.updateTaskIntValue(uid, attribute, updatedValue);
      final updatedTask = await mockTaskService.getTaskWithoutToDos(uid).first;
      expect(updatedTask.total, updatedValue);
    });

    test('getRemaining', () async {
      final uid = '2';
      final remainingStream = mockTaskService.getRemaining(uid);
      final remaining = await remainingStream.first;
      final task = await mockTaskService.getTaskWithoutToDos(uid).first;
      final expectedRemaining = task != null
          ? task.total -
              (task.housing +
                  task.transportation +
                  task.food +
                  task.healthcare +
                  task.utilities +
                  task.misc)
          : 0;
      expect(remaining, expectedRemaining);
    });

    test('updateToDo updates existing to-do', () async {
      final toDoToUpdateId = 'todo1';
      final newData = 'Call doctor';
      final newCheck = true;
      await mockTaskService.updateToDo(toDoToUpdateId, newData, newCheck);
      final toDos = await mockTaskService.getToDos('task1').first;
      final updatedToDo = toDos.firstWhere((todo) => todo.id == toDoToUpdateId);
      expect(updatedToDo.data, newData);
      expect(updatedToDo.check, newCheck);
    });
  });
}
