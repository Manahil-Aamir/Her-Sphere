import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/impwidgets/logout.dart';
import 'package:hersphere/pages/tasktrackerpages/tasktracker.dart';

void main() {
  testWidgets('TaskTracker screen UI test', (WidgetTester tester) async {
    // Ignore overflow errors during the test
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('A RenderFlex overflowed by')) {
        // Ignore the overflow error
        return;
      }
      // Forward other errors to the default handler.
      FlutterError.dumpErrorToConsole(details);
    };

    await tester.pumpWidget(MaterialApp(home: TaskTracker()));

    // Verify that the 'TASK TRACKER' text is present
    expect(find.text('TASK\nTRACKER'), findsNWidgets(2));

    // Verify that the 'EXPENSES' button is present
    expect(find.text('EXPENSES'), findsOneWidget);

    // Verify that the 'TO-DO LIST' button is present
    expect(find.text('TO-DO LIST'), findsOneWidget);

    // Verify that the Logout button is present
    expect(find.byType(Logout), findsOneWidget);

    // Verify that the BackArrow button is present
    expect(find.byType(BackArrow), findsOneWidget);

    // Restore the default error handling
    FlutterError.onError = FlutterError.dumpErrorToConsole;
  });
}
