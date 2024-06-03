import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';

void main() {
  testWidgets('BackArrow navigates back correctly', (WidgetTester tester) async {
    late BuildContext capturedContext;
    late Widget capturedWidget;

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            capturedContext = context;
            capturedWidget = BackArrow(widget: Container()); // Use a container as the target widget for testing
            return Scaffold(
              appBar: AppBar(
                leading: capturedWidget,
              ),
            );
          },
        ),
      ),
    );

    // Verify that the BackArrow widget is rendered
    expect(find.byType(BackArrow), findsOneWidget);

    // Simulate pressing the back arrow
    await tester.tap(find.byType(BackArrow));
    await tester.pumpAndSettle();

    // Verify that Navigator.pop() is called
    expect(Navigator.of(capturedContext).canPop(), isTrue);
  });
}