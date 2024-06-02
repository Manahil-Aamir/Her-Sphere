import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/familypages/numbers.dart';
import 'package:hersphere/providers/family_provider.dart';
import 'package:hersphere/providers/familyinstance_provider.dart';
import 'package:hersphere/services/familyservice.dart';
import 'package:mockito/mockito.dart';

import '../providertests/mockfamilyprovider.dart';
import '../providertests/mockfamilyservice.dart';

void main() {
  testWidgets('MyWidget shows numbers and allows adding/deleting', (WidgetTester tester) async {
    final mockFamilyService = MockFamilyService();
    final numbersStream = Stream.value([123, 456, 789]);

    // Provide a unique user ID for testing purposes
    const testUid = 'testUid';

    // Mock the `getNumbers` method to return the `numbersStream`
    when(mockFamilyService.getNumbers(testUid)).thenAnswer((_) => numbersStream);

    // Use ProviderScope with overrides to inject the mock service and the user UID
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          familyNotifierProvider.overrideWith(() => MockFamilyNotifier()),
          familyServiceProvider.overrideWithValue(mockFamilyService),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Numbers(), // No need to pass userUid here
          ),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('NUMBERS'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the stream to emit values
    await tester.pumpAndSettle();

    // Verify numbers are displayed
    expect(find.text('123'), findsOneWidget);
    expect(find.text('456'), findsOneWidget);
    expect(find.text('789'), findsOneWidget);

    // Simulate tapping the add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the add number UI is shown (adjust based on your actual add number implementation)
    expect(find.byType(TextField), findsOneWidget);

    // Simulate deleting a number
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pump();

    // Verify the delete method is called with the correct parameters
    verify(mockFamilyService.removeNumber(testUid, 123)).called(1);
  });
}
