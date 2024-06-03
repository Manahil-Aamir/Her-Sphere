import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/mainpages/welcome.dart';

void main() {
  testWidgets('Welcome widget test', (WidgetTester tester) async {
    // Build the Welcome widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Welcome(),
      ),
    );

    // Verify that the background color is correct.
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect((scaffold.backgroundColor), Color(0xFFFFC8D2));

    // Verify that the app name text is present.
    expect(find.text('HER SPHERE'), findsAtLeast(2));

    // Verify that the tagline text is present.
    expect(find.text("a woman’s companion to balance it all"), findsAtLeast(2));

    // Verify that the LOGIN button is present.
    expect(find.text('LOGIN'), findsOneWidget);

    // Verify that the REGISTER button is present.
    expect(find.text('REGISTER'), findsOneWidget);
  });
}