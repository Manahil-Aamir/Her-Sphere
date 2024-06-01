import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/familypages/birthdays.dart';
import 'package:mockito/mockito.dart';
import 'firebasetest.dart';
import 'mockfirebase.dart';

void main() {
  setupFirebaseAuthMocks();

  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockUser mockUser;
  late BirthdaysState state;


  setUp(() {
    // Initialize mocks
    state = BirthdaysState();

  });

  group('BirthdaysState getMonthName', () {
    test('returns correct month name for each month', () {
      expect(state.getMonthName(1), 'January');
      expect(state.getMonthName(2), 'February');
      expect(state.getMonthName(3), 'March');
      expect(state.getMonthName(4), 'April');
      expect(state.getMonthName(5), 'May');
      expect(state.getMonthName(6), 'June');
      expect(state.getMonthName(7), 'July');
      expect(state.getMonthName(8), 'August');
      expect(state.getMonthName(9), 'September');
      expect(state.getMonthName(10), 'October');
      expect(state.getMonthName(11), 'November');
      expect(state.getMonthName(12), 'December');
    });

    test('throws RangeError for invalid month', () {
      expect(() => state.getMonthName(0), throwsRangeError);
      expect(() => state.getMonthName(13), throwsRangeError);
    });
  });
}