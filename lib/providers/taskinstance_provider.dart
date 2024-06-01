import 'package:hersphere/services/taskservice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'taskinstance_provider.g.dart';

@riverpod
TaskService taskService(TaskServiceRef ref) {
  // Create and return an instance of SelfcareService here
  return TaskService();
}