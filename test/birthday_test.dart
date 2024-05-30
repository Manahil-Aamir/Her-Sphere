import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/models/birthdaymodel.dart';
import 'package:hersphere/pages/familypages/birthdays.dart';
import 'package:mockito/mockito.dart';

class MockDateTime extends Mock implements DateTime {}
void main() {
  group('BirthdaysState', () {
    // Define a test date
    final testDate = DateTime(2024, 5, 30); // Use your desired test date

    // Create an instance of BirthdaysState
    final state = BirthdaysState();

    test('findAge should return correct age for past birthday this year', () {
      // Mock DateTime.now() to return the fixed test date
      when(DateTime.now()).thenReturn(testDate);

      // Define a past birthday on January 1st of the test year
      final birthday = DateTime(testDate.year, 1, 1);
      
      // Calculate age based on the defined test date
      final age = state.findAge(Birthday(name: 'Test', date: birthday, id: '1'));
      
      // Expect the age to be 1 year old
      expect(age, 1);
    });

    test('findAge should return correct age for upcoming birthday', () {
      // Mock DateTime.now() to return the fixed test date
      when(DateTime.now()).thenReturn(testDate);

      // Define an upcoming birthday on December 31st of the test year
      final birthday = DateTime(testDate.year, 12, 31);
      
      // Calculate age based on the defined test date
      final age = state.findAge(Birthday(name: 'Test', date: birthday, id: '2'));
      
      // Expect the age to be 0 years old
      expect(age, 0);
    });

    test('findDays should return 0 for birthday today', () {
      // Mock DateTime.now() to return the fixed test date
      when(DateTime.now()).thenReturn(testDate);

      // Define the birthday to be the same as the test date
      final birthday = testDate;
      
      // Calculate days until the birthday based on the defined test date
      final days = state.findDays(Birthday(name: 'Test', date: birthday, id: '3'));
      
      // Expect the result to be 0 days
      expect(days, 0);
    });

    test('findDays should return correct days until next birthday', () {
      // Mock DateTime.now() to return the fixed test date
      when(DateTime.now()).thenReturn(testDate);

      // Define the birthday to be on December 31st of the test year
      final birthday = DateTime(testDate.year, 12, 31);
      
      // Calculate days until the birthday based on the defined test date
      final days = state.findDays(Birthday(name: 'Test', date: birthday, id: '4'));
      
      // Expect the result to be 214 days until December 31st from May 30th
      expect(days, 214);
    });
  });
}
