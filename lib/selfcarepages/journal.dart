
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hersphere/selfcarepages/ViewJournalEntry.dart';
import 'package:intl/intl.dart';
import 'package:hersphere/impwidgets/appbar.dart';
import 'package:hersphere/selfcarepages/entry.dart';
import 'package:hersphere/selfcarepages/selfcare.dart';


class Journal extends StatefulWidget {
  const Journal({Key? key}) : super(key: key);

  @override
  State<Journal> createState() => _JournalState();

}

class _JournalState extends State<Journal> {

  //List that will hold all ToDo
  // ignore: non_constant_identifier_names
  List <Entry> journalList = [];
  String t = '';
  
  //Adding a new task in todo list
  void _addEntry (String str) { 
    if(str!=''){
    DateTime now = DateTime.now();
    // Format the DateTime object as String and include only the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    setState((){
      journalList.add(Entry(entry: str, date: formattedDate));
    });
    Navigator.pop(context);
    }
  }

  //Removing a task in todo list
  void _removeEntry (int index) { 
    setState((){
      journalList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFBCF7C5),
      appBar: const AppBarWidget(text: 'Journals', color: Color(0xFFBCF7C5), back: SelfCare(),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Creating a list to display all the tasks
              Expanded(
                child: ListView.builder(
                  itemCount: journalList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(

                      //Tap to view the entire journal entry
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ViewJournalEntry(journal: journalList[index]);
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                      
                        //List of all the tasks
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(10),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              _removeEntry(index);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          tileColor: Colors.white,
                          //Displaying date of entry
                          title: Text(
                          journalList[index].date,
                            style: const TextStyle(
                              fontFamily: 'Times New Roman',
                              fontSize: 19.0,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF726662),
                            ),
                          ),
                          //Displaying entry
                          subtitle: Text(
                            journalList[index].entry,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,                 
                            style: const TextStyle(
                              fontFamily: 'Times New Roman',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF726662),
                            ),
                            textAlign: TextAlign.center,
                          ),
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

                        //Alert Dialog of adding new entry
                        return AlertDialog(
                          title: const Text(
                            'Add Entry',
                            style: TextStyle(
                              fontFamily: 'OtomanopeeOne',
                              fontSize: 20.0,
                              color: Color(0xFF726662),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              //Entering entry and limit is of 500 characters
                              Flexible(
                                child: TextField(
                                  maxLength: 500,
                                  maxLines: 10,
                                  decoration: const InputDecoration(
                                    labelText: 'Add New Entry',
                                    labelStyle: TextStyle(
                                      fontFamily: 'OtomanopeeOne',
                                      fontSize: 17.0,
                                      color: Color(0xFF726662),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      t = value;
                                    });
                                  },
                                ),
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
                            //Adding a entry
                            TextButton(
                              onPressed: () {
                                _addEntry(t);
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