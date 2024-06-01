import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/methods/familymethods/birthdaymethod.dart';
import 'package:hersphere/models/birthdaymodel.dart';

void main() {
  group('Age Calculation:', () {
    var birthdaymethods = BirthdayMethods();
    test('Birthday in the past of the current year', () {
      final today = DateTime.now();
      final birthday = Birthday(
        name: 'Test',
        date: DateTime(today.year - 20, today.month, today.day),
        id: '1',
      );
      final age = today.year -
          birthday.date.year -
          (today.month >= birthday.date.month && today.day >= birthday.date.day
              ? 0
              : 1);
      expect(birthdaymethods.findAge(birthday), equals(age));
    });

    test('Birthday in the future of the current year', () {
      final today = DateTime.now();
      final birthday = Birthday(
        name: 'Test',
        date: DateTime(today.year, today.month + 1, today.day + 5),
        id: '2',
      );
      final age = today.year - birthday.date.year;
      expect(birthdaymethods.findAge(birthday), equals(age));
    });

    test('Birthday is today', () {
      final today = DateTime.now();
      final birthday = Birthday(
        name: 'Test',
        date: DateTime(today.year, today.month, today.day),
        id: '3',
      );
      final age = 0;
      expect(birthdaymethods.findAge(birthday), equals(age));
    });
  });

group('Days Until Next Birthday:', () {
  var birthdaymethods = BirthdayMethods();
  
  test('Calculate days until next birthday - Birthday is in the future', () {
    final today = DateTime.now();
    // Assuming birthday is next year from today
    final birthday = Birthday(
      name: 'Test',
      date: DateTime(today.year, today.month, today.day-1),
      id: '4',
    );
    final nextBirthday = DateTime(today.year + 1, birthday.date.month, birthday.date.day);
    final daysUntilNextBirthday = nextBirthday.difference(today).inDays;
    expect(birthdaymethods.findDays(birthday), equals(daysUntilNextBirthday));
  });

  test('Calculate days until next birthday - Birthday is in the past', () {
    final today = DateTime.now();
    // Assuming birthday just passed in this year
    final birthday = Birthday(
      name: 'Test',
      date: DateTime(today.year, today.month, today.day - 10), // Adjusted for recent past date
      id: '5',
    );
    final nextBirthday = DateTime(today.year + 1, birthday.date.month, birthday.date.day);
    final daysUntilNextBirthday = nextBirthday.difference(today).inDays;
    expect(birthdaymethods.findDays(birthday), equals(daysUntilNextBirthday));
  });
});

  
  test('Get month name', () {
    var birthdayMethods = BirthdayMethods();
    expect(birthdayMethods.getMonthName(1), 'January');
    expect(birthdayMethods.getMonthName(5), 'May');
    expect(birthdayMethods.getMonthName(12), 'December');
  });

  test('Get month name - Error scenario', () {
    var birthdayMethods = BirthdayMethods();
    expect(() => birthdayMethods.getMonthName(0), throwsRangeError);
  });
}
