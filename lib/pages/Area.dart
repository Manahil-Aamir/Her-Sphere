import 'package:hersphere/models/birthdaymodel.dart';

class Area{
  static double get pi => 3.141592;

  double Circle(double radius){
    if(radius < 0){
      throw Exception('Negative Value');
    }
    return (pi*radius.square);
  }

  double Rectangle(double length, double breadth){
    return length*breadth;
  }

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

}

extension NumSquare on double {
  double get square => this*this;
}

