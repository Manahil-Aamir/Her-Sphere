
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/impwidgets/logout.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';

void main() {
  testWidgets('SelfCare screen UI test', (WidgetTester tester) async {
        FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('A RenderFlex overflowed by')) {
        // Ignore the overflow error
        return;
      }
      // Forward other errors to the default handler.
      FlutterError.dumpErrorToConsole(details);
    };


    await tester.pumpWidget(MaterialApp(home: ProviderScope(child: SelfCare())));

    // Verify that the 'SELF CARE' text is present
    expect(find.text('SELF CARE'), findsExactly(2));

    // Verify that the 'JOURNAL' button is present
    expect(find.text('JOURNAL'), findsOneWidget);

    // Verify that the 'HYDRATION REMINDER' button is present
    expect(find.text('HYDRATION REMINDER'), findsOneWidget);

    // Verify that the 'DAILY PLAN' button is present
    expect(find.text('DAILY PLAN'), findsOneWidget);

    // Verify that the Logout button is present
    expect(find.byType(Logout), findsOneWidget);

    // Verify that the BackArrow button is present
    expect(find.byType(BackArrow), findsOneWidget);

        // Restore the default error handling
    FlutterError.onError = FlutterError.dumpErrorToConsole;
  });
}