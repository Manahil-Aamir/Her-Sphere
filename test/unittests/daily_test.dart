

import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/methods/selfcaremethods/dailymethod.dart';

void main() {
  final dailyMethod = DailyMethod();

  group('Calculate progress:', () {
    test('Case 1: c < q', () {
      const c = 3;
      const q = 10;
      const expectedProgress = c / q;
      expect(dailyMethod.calculateProgress(c, q), equals(expectedProgress));
    });

    test('Case 2: c = q', () {
      const c = 5;
      const q = 5;
      const expectedProgress = c / q;
      expect(dailyMethod.calculateProgress(c, q), equals(expectedProgress));
    });

    test('Case 4: c > q (Result equals to infinity)', () {
      const c = 8;
      const q = 0;
      final result = dailyMethod.calculateProgress(c, q);
      expect(result.isInfinite, equals(true)); // Adjusted expectation
    });
  });
}
