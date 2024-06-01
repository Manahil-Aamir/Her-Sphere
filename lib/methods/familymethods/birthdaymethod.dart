import 'package:hersphere/models/birthdaymodel.dart';

class BirthdayMethods {
  //Calculate age
  int findAge(Birthday birthday) {
    int i = (birthday.date.month > DateTime.now().month ||
            (birthday.date.month == DateTime.now().month &&
                birthday.date.day >= DateTime.now().day)
        ? DateTime.now().year - birthday.date.year
        : DateTime.now().year - birthday.date.year + 1);
    return i;
  }

  //Calculate days
  int findDays(Birthday birthday) {
    int d = (birthday.date.month > DateTime.now().month ||
            (birthday.date.month == DateTime.now().month &&
                birthday.date.day >= DateTime.now().day)
        ? DateTime(DateTime.now().year, birthday.date.month, birthday.date.day)
            .difference(DateTime.now())
            .inDays
        : DateTime(
                DateTime.now().year + 1, birthday.date.month, birthday.date.day)
            .difference(DateTime.now())
            .inDays);
    return d;
  }

  //Getting month name
  String getMonthName(int month) {
    final monthNames = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }
}
