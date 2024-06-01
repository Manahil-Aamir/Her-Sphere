import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/methods/selfcaremethods/entrymethod.dart';

void main() {
  final entryMethod = EntryMethod();

  group('formatDate:', () {
    test('Regular date', () {
      final date = DateTime(2024, 6, 1);
      const expectedFormattedDate = '01/06/2024';
      expect(entryMethod.formatDate(date), equals(expectedFormattedDate));
    });

    test('Leap year date', () {
      final date = DateTime(2024, 2, 29);
      const expectedFormattedDate = '29/02/2024';
      expect(entryMethod.formatDate(date), equals(expectedFormattedDate));
    });

    test('Single digit day and month', () {
      final date = DateTime(2024, 1, 5);
      const expectedFormattedDate = '05/01/2024';
      expect(entryMethod.formatDate(date), equals(expectedFormattedDate));
    });
  });
}
