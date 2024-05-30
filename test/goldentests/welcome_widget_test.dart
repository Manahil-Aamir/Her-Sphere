import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hersphere/pages/mainpages/welcome.dart';

void main() {
  testGoldens('Welcome widget golden test', (WidgetTester tester) async {
    await loadAppFonts();
    final builder = DeviceBuilder()
      ..addScenario(
        widget: MaterialApp(home: Welcome()),
        name: 'default page',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'welcome_widget');
  });
}
