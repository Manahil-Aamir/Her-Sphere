
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/selfcarepages/ViewJournalEntry.dart';
import 'package:hersphere/providers/selfcare_provider.dart';
import 'package:hersphere/providers/selfcarestream_provider.dart';
import 'package:intl/intl.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';


class Journal extends ConsumerStatefulWidget {
  const Journal({Key? key}) : super(key: key);

  @override
  ConsumerState<Journal> createState() => _JournalState();

}

class _JournalState extends ConsumerState<Journal> {

  //List that will hold all ToDo
  // ignore: non_constant_identifier_names
  String t = '';
  final user = FirebaseAuth.instance.currentUser!;
  late final tProvider = StateProvider<String>((ref) => '');
  
  //Adding a new task in todo list
  void _addEntry (String str) { 
    if(str!=''){
    DateTime now = DateTime.now();
    // Format the DateTime object as String and include only the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    ref.read(selfCareNotifierProvider.notifier).addJournal(user.uid, str, now);
    }
  }

  //Removing a task in todo list
  void _removeEntry (String jDoc) { 
    ref.read(selfCareNotifierProvider.notifier).removeJournal(user.uid, jDoc);
  }

  String formatDate(DateTime date) {
  // Define the date format
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  
  // Format the date
  return formatter.format(date);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBCF7C5),
      appBar: const AppBarWidget(
        text: 'Journals',
        color: Color(0xFFBCF7C5),
        back: SelfCare(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, watch, _) {
                    final journalsAsyncValue = ref.watch(journalsStreamProvider(user.uid));
                    return journalsAsyncValue.when(
                      data: (journalList) {
                        return ListView.builder(
                          itemCount: journalList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
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
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.circular(10),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _removeEntry(journalList[index].id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  tileColor: Colors.white,
                                  title: Text(
                                    formatDate(journalList[index].date),
                                    style: const TextStyle(
                                      fontFamily: 'Times New Roman',
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF726662),
                                    ),
                                  ),
                                  subtitle: Text(
                                    journalList[index].name,
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
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(child: Text('Error: $error')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Builder(
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Add Entry',
                      style: TextStyle(
                        fontFamily: 'OtomanopeeOne',
                        fontSize: 20.0,
                        color: Color(0xFF726662),
                      ),
                    ),
                    content: TextField(
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
                        ref.read(tProvider.notifier).state = value;
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ref.read(tProvider.notifier).state = '';
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
                          _addEntry(ref.read(tProvider.notifier).state);
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
          );
        },
        child: const Icon(
          Icons.add,
          color: Color(0xFF726662),
        ),
      ),
    );
  }
}


