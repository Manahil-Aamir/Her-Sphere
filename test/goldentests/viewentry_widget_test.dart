import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hersphere/models/journalmodel.dart';
import 'package:hersphere/pages/selfcarepages/ViewJournalEntry.dart';

void main() {
  testGoldens('ViewJournalEntry widget golden test', (WidgetTester tester) async {
    await loadAppFonts();

    // Create a JournalModel instance
    final journal = JournalModel( name: 'My Journal Entry', date: DateTime(2024, 6, 1), id:  '');

    // Build the ViewJournalEntry widget
    await tester.pumpWidgetBuilder(
      ViewJournalEntry(journal: journal),
      surfaceSize: const Size(300, 400),
    );

    // Verify the appearance of the widget
    await screenMatchesGolden(tester, 'viewentry_widget');
  });
}