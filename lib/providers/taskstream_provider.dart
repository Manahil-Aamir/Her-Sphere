

import 'package:hersphere/models/journalmodel.dart';
import 'package:hersphere/models/taskmodel.dart';
import 'package:hersphere/models/todosmodel.dart';
import 'package:hersphere/providers/selfcareinstance_provider.dart';
import 'package:hersphere/providers/taskinstance_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'taskstream_provider.g.dart';

@riverpod
Stream<List<ToDos>> toDosStream(ToDosStreamRef ref, String taskId) {
  final taskService = ref.watch(taskServiceProvider);
  return taskService.getToDos(taskId);
}



@riverpod
Stream<int> remainingStream(RemainingStreamRef ref, String uid) {
  final taskService = ref.watch(taskServiceProvider);
  return taskService.getRemaining(uid);
}

@riverpod
Stream<TaskModel> taskStream(TaskStreamRef ref, String uid){
  final taskService = ref.watch(taskServiceProvider);
  return taskService.getTaskWithoutToDos(uid);
}