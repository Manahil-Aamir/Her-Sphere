import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/familypages/family.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/impwidgets/logout.dart';


void main() {
  testWidgets('FamilyPage screen UI test', (WidgetTester tester) async {
    // Ignore overflow errors during the test
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('A RenderFlex overflowed by')) {
        // Ignore the overflow error
        return;
      }
      // Forward other errors to the default handler.
      FlutterError.dumpErrorToConsole(details);
    };

    await tester.pumpWidget(MaterialApp(home: FamilyPage()));

    // Verify that the 'FAMILY' text is present
    expect(find.text('FAMILY'), findsExactly(2));

    // Verify that the 'BIRTHDAYS' button is present
    expect(find.text('BIRTHDAYS'), findsOneWidget);

    // Verify that the 'PHOTOS' button is present
    expect(find.text('PHOTOS'), findsOneWidget);

    // Verify that the 'SOS' button is present
    expect(find.text('SOS'), findsOneWidget);

    // Verify that the Logout button is present
    expect(find.byType(Logout), findsOneWidget);

    // Verify that the BackArrow button is present
    expect(find.byType(BackArrow), findsOneWidget);

    // Restore the default error handling
    FlutterError.onError = FlutterError.dumpErrorToConsole;
  });
}
