import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/models/birthdaymodel.dart';
import 'package:hersphere/pages/Area.dart';
void main() {
  test("Calculating area of circle with radius 1 and expecting result 1", () {
    // Arrange
    Area area = Area();
    double expectedArea = 3.141592;

    //Action
    double actualArea = area.Circle(1);

    //Assert
    expect(actualArea, equals(expectedArea));
  });

test("Testing with negative radius of 10", () {
    // Arrange
    Area area = Area();

    // Act & Assert
    expect(() => area.Circle(-10), throwsA(isA<Exception>().having(
      (e) => e.toString(),
      'message',
      'Exception: Negative Radius',
    )));
  });

    test('should return January for month 1', () {
    // Arrange
    Area area = Area();
    int month = 1;
    String expectedMonthName = 'January';

    // Act
    String actualMonthName = area.getMonthName(1);

    // Assert
    expect(actualMonthName, equals(expectedMonthName));
  });

    test('should return correct days for birthday passed this year', () {
     Area area = Area();
      print('hi');
      final today = DateTime.now();
      final birthday = Birthday(
        name: 'Test',
        date: DateTime(today.year, today.month - 1, today.day),
        id: '3',
      );

      final daysUntilNextYear =
          DateTime(today.year + 1, today.month - 1, today.day)
              .difference(today)
              .inDays;
              print(area.findDays(birthday));

      expect(area.findDays(birthday), equals(daysUntilNextYear));
    });
  

    test("Testing with radius of 0", () {
    // Arrange
    Area area = Area();
    double expectedArea = 0;

    //Action
    double actualArea = area.Circle(0);

    //Assert
    expect(actualArea, equals(expectedArea));
  });

  test("Testing with radius of 0", () {
    // Arrange
    Area area = Area();
    double expectedArea = double.infinity;

    //Action
    double actualArea = area.Circle(double.infinity);

    //Assert
    expect(actualArea, equals(expectedArea));
  });

    test("Testing with length and breadth 0", () {
    // Arrange
    Area area = Area();
    double expectedArea = 0;

    //Action
    double actualArea = area.Rectangle(0,0);

    //Assert
    expect(actualArea, equals(expectedArea));
  });

    test("Testing with length 8 and breadth 9", () {
    // Arrange
    Area area = Area();
    double expectedArea = 72;

    //Action
    double actualArea = area.Rectangle(8, 9);

    //Assert
    expect(actualArea, equals(expectedArea));
  });

      test("Testing with length -8 and breadth -9", () {
    // Arrange
    Area area = Area();
    double expectedArea = 72;

    //Action
    double actualArea = area.Rectangle(-8, -9);

    //Assert
    expect(actualArea, equals(expectedArea));
  });

        test("Testing with length and breadth infinity", () {
    // Arrange
    Area area = Area();
    double expectedArea = double.infinity;

    //Action
    double actualArea = area.Rectangle(double.infinity, double.infinity);

    //Assert
    expect(actualArea, equals(expectedArea));
  });
}
