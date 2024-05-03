import 'package:flutter/material.dart';
import 'package:hersphere/impwidgets/appbar.dart';
import 'package:hersphere/tasktrackerpages/task.dart';
import 'package:hersphere/tasktrackerpages/tasktracker.dart';


class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();

}

class _ToDoState extends State<ToDo> {

  //List that will hold all ToDo
  // ignore: non_constant_identifier_names
  List <Task> ToDoList = [];
  String t = '';
  
  //Adding a new task in todo list
  void _addTask (String str) { 
    if(str!=''){
    setState((){
      ToDoList.add(Task(task: str, checked: false));
    });
    Navigator.pop(context);
    }
  }

  //Removing a task in todo list
  void _removeTask (int index) { 
    setState((){
      ToDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFB5EFFC),
      appBar: const AppBarWidget(text: 'TODo List', color: Color(0xFFB5EFFC), back: TaskTracker(),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Creating a list to display all the tasks
              Expanded(
                child: ListView.builder(
                  itemCount: ToDoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),

                      //List of all the tasks
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10),
                        ),
                        leading: Checkbox(
                          value: ToDoList[index].checked, 
                          onChanged: (newValue) {
                            setState(() {
                              ToDoList[index].checked = !ToDoList[index].checked;
                            });
                          }
                        ),
                          trailing: IconButton(
                          onPressed: () {
                            _removeTask(index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        tileColor: Colors.white,
                        //Displayig task on basis of wheteher its checked or not
                        title: Text(
                          ToDoList[index].task,
                          style: TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF726662),
                            decoration: ToDoList[index].checked ? TextDecoration.lineThrough  : TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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

                        //Alert Dialog of adding task
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
                              //Entering task and limit is of 30 characters
                              TextField(
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
                                    t = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          //Cancel Button
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  t = '';
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
                            //Adding a task
                            TextButton(
                              onPressed: () {
                                _addTask(t);
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
        ))
    );
  }

}