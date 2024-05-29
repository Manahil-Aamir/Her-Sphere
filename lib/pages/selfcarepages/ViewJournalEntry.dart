import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hersphere/models/journalmodel.dart';
import 'package:intl/intl.dart';

class ViewJournalEntry extends StatelessWidget {
  final JournalModel journal;

  const ViewJournalEntry({Key? key, required this.journal}) : super(key: key);

  String formatDate(DateTime date) {
  // Define the date format
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  
  // Format the date
  return formatter.format(date);
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Journal Entry',
        style: TextStyle(
          fontFamily: 'OtomanopeeOne',
          fontSize: 20.0,
          color: Color(0xFF726662),
        ),
      ),

      //View the entire entry along with date
      content: IntrinsicHeight(
        child: Column(
          children: [
            Text(
              formatDate(journal.date),
              style: const TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF726662),
              ),
            ),
            Expanded(
              child: Text(
                journal.name,
                style: const TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF726662),
                ),
              ),
            ),
          ],
        ),
      ),

      //Close the dialog
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(
              fontFamily: 'OtomanopeeOne',
              fontSize: 15.0,
              color: Color(0xFF726662),
            ),
          ),
        ),
      ],
    );
  }
}
