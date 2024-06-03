import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';

void main() {
  testWidgets('AppBarWidget renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(
            text: 'Test Text',
            color: Colors.blue, // Set a test color
            back: Container(), // Provide a back widget for testing
          ),
        ),
      ),
    );

    // Verify that the app bar title text style is applied correctly
    expect(find.text('Test Text'), findsNWidgets(2)); // The text is drawn twice due to stroke and fill

    // Verify that the app bar background color is set correctly
    expect(
      tester.widget<AppBar>(find.byType(AppBar)).backgroundColor,
      equals(Colors.blue),
    );

    // Verify that the app bar leading widget is present
    expect(find.byType(BackArrow), findsOneWidget);
  });
}
