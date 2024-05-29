import 'package:hersphere/models/taskmodel.dart';
import 'package:hersphere/providers/taskinstance_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'taskfuture_provider.g.dart';

@riverpod
Future<List<TaskModel>> allTasksFuture(AllTasksFutureRef ref) {
  final taskService = ref.watch(taskServiceProvider);
  return taskService.getAllTasks();
}

