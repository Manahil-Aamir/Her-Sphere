import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/impwidgets/button.dart';

void main() {
  // Define the target screen to navigate to
  final targetWidget = Scaffold(
    appBar: AppBar(
      title: const Text('Target Page'),
    ),
    body: const Center(
      child: Text('This is the target page'),
    ),
  );

  //BackArrow
  testGoldens('BackArrow widget golden test', (tester) async {
    // Build the BackArrow widget
    final backArrowWidget = MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackArrow(widget: targetWidget),
        ),
      ),
    );

    // Load the widget
    await tester.pumpWidgetBuilder(backArrowWidget);

    // Capture the initial state of the widget
    await screenMatchesGolden(tester, 'back_arrow_initial');

    // Tap the back arrow button
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // Capture the state after navigation
    await screenMatchesGolden(tester, 'back_arrow_navigated');
  });

  //Appbar widget
  testGoldens('AppBarWidget golden test', (tester) async {
    // Build the AppBarWidget
    final appBarWidget = MaterialApp(
      home: Scaffold(
        appBar: AppBarWidget(
          text: 'Test Title',
          color: Colors.blue,
          back: targetWidget,
        ),
        body: Center(child: Text('AppBarWidget Test Body')),
      ),
    );

    // Load the widget
    await tester.pumpWidgetBuilder(appBarWidget);

    // Capture the initial state of the widget
    await screenMatchesGolden(tester, 'app_bar_widget_initial');

    // Tap the back arrow button
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // Capture the state after navigation
    await screenMatchesGolden(tester, 'app_bar_widget_navigated');
  });

  //Option button
    testGoldens('OptionButton widget golden test', (tester) async {
    // Build the OptionButton widget
    final optionButtonWidget = MaterialApp(
      home: Scaffold(
        body: Center(
          child: OptionButton(
            text: 'Test Button',
            widget: targetWidget,
          ),
        ),
      ),
    );

    // Load the widget
    await tester.pumpWidgetBuilder(optionButtonWidget);

    // Capture the initial state of the widget
    await screenMatchesGolden(tester, 'option_button_initial');

    // Tap the button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Capture the state after navigation
    await screenMatchesGolden(tester, 'option_button_navigated');
  });
}
