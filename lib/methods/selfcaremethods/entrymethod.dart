import 'package:intl/intl.dart';

class EntryMethod {
  String formatDate(DateTime date) {
    // Define the date format
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    // Format the date
    return formatter.format(date);
  }
}
