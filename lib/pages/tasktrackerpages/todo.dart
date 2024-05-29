import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/tasktrackerpages/tasktracker.dart';
import 'package:hersphere/providers/taskinstance_provider.dart';
import 'package:hersphere/providers/taskstream_provider.dart';
import 'package:hersphere/repository/taskservice.dart';


class ToDo extends ConsumerStatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  ConsumerState<ToDo> createState() => _ToDoState();
}

class _ToDoState extends ConsumerState<ToDo> {
  late TextEditingController _textEditingController;
  late TaskService _taskService;
  String task = '';
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _taskService = ref.read(taskServiceProvider);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _addTask(String str) {
    if (str.isNotEmpty) {
      _taskService.addToDo(user.uid, str, false); // Initially unchecked
      _textEditingController.clear();
    }
  }

  void _removeTask(String taskId, String todoDocId) {
    _taskService.removeToDo(taskId, todoDocId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB5EFFC),
      appBar: const AppBarWidget(
        text: 'TO-Do',
        color: Color(0xFFB5EFFC),
        back: TaskTracker(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final toDosAsyncValue = ref.watch(toDosStreamProvider(user.uid));
                  return toDosAsyncValue.when(
                    data: (toDos) {
                      return ListView.builder(
                        itemCount: toDos.length,
                        itemBuilder: (context, index) {
                          final task = toDos[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: Checkbox(
                                value: task.check,
                                onChanged: (value) {
                                  _taskService.updateToDoChecked(task.id, !task.check);
                                  ref.refresh(toDosStreamProvider(user.uid));
                                },
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  _removeTask(user.uid, task.id);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              tileColor: Colors.white,
                              title: Text(
                                task.data,
                                style: TextStyle(
                                  fontFamily: 'OtomanopeeOne',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF726662),
                                  decoration: task.check ? TextDecoration.lineThrough : TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Text('Error: $error'),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Add Task',
                          style: TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            fontSize: 20.0,
                            color: Color(0xFF726662),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              controller: _textEditingController,
                              maxLength: 30,
                              decoration: const InputDecoration(
                                labelText: 'Add New To-Do',
                                labelStyle: TextStyle(
                                  fontFamily: 'OtomanopeeOne',
                                  fontSize: 13.0,
                                  color: Color(0xFF726662),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  task = value;
                                });
                              },
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _textEditingController.clear();
                              setState(() {
                                task = '';
                              });
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontFamily: 'OtomanopeeOne',
                                fontSize: 15.0,
                                color: Color(0xFF726662),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _addTask(task);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                fontFamily: 'OtomanopeeOne',
                                fontSize: 15.0,
                                color: Color(0xFF726662),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF726662),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

