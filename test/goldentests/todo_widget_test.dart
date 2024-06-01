import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hersphere/models/todosmodel.dart';
import 'package:hersphere/services/taskservice.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../firebasetest.dart';

// class MockTaskService extends Mock implements TaskService {
//   // Implement mock methods or properties if needed
//   @override
//   Stream<List<ToDo>> toDosStreamProvider(String userId) {
//     // Mock implementation for toDosStreamProvider
//     return Stream.value([]); // Return an empty stream as an example
//   }
// }
// void main() {
//   setupFirebaseAuthMocks();
//   testGoldens('ToDo widget golden test', (WidgetTester tester) async {
//     // Create mock providers
//     final mockTaskService = MockTaskService();

//     // Provide mock data for the widget
//     final List<ToDo> mockToDoList = [
//       ToDo(id: '1', title: 'Task 1', completed: false),
//       ToDo(id: '2', title: 'Task 2', completed: true),
//       ToDo(id: '3', title: 'Task 3', completed: false),
//     ];

//     when(mockTaskService.toDosStreamProvider(any))
//         .thenAnswer((_) => Stream.value(mockToDoList));

//     final widget = ToDo();

//     // Inject mock providers into the widget using MultiProvider
//     final testApp = MaterialApp(
//       home: MultiProvider(
//         providers: [
//           ChangeNotifierProvider<TaskService>.value(
//             value: mockTaskService,
//           ),
//           // Add more providers if needed
//         ],
//         child: Builder(
//           builder: (context) {
//             return widget;
//           },
//         ),
//       ),
//     );

//     // Pump the widget and await rendering
//     await tester.pumpWidgetBuilder(
//       testApp,
//       surfaceSize: const Size(400, 800),
//     );

//     // Take a golden screenshot
//     await screenMatchesGolden(tester, 'todo_golden_test');
//   });
// }
