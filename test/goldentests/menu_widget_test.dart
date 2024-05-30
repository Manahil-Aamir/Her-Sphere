import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hersphere/pages/familypages/family.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/impwidgets/logout.dart';
import 'package:hersphere/pages/mainpages/home.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';
import 'package:hersphere/pages/tasktrackerpages/tasktracker.dart';
import 'package:hersphere/pages/mainpages/home.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/impwidgets/button.dart';
import 'package:hersphere/pages/impwidgets/logout.dart';

void main() {
  testGoldens('FamilyPage golden test', (WidgetTester tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..addScenario(
        widget: MaterialApp(
          home:  FamilyPage()
        ),
        name: 'default',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'family_widget');
  });

    testGoldens('SelfCare golden test', (WidgetTester tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..addScenario(
        widget: MaterialApp(
          home:  SelfCare()
        ),
        name: 'default',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'selfcare_widget');
  });

      testGoldens('Task Tracker golden test', (WidgetTester tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..addScenario(
        widget: MaterialApp(
          home:  TaskTracker()
        ),
        name: 'default',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'tasktracker_widget');
  });
}
