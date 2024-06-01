import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hersphere/pages/familypages/family.dart';
import 'package:hersphere/pages/impwidgets/backarrow.dart';
import 'package:hersphere/pages/impwidgets/logout.dart';
import 'package:hersphere/pages/mainpages/home.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';
import 'package:hersphere/pages/tasktrackerpages/tasktracker.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  
    TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Set up mock values for SharedPreferences
    SharedPreferences.setMockInitialValues({});
  });

  testGoldens('Family golden test', (WidgetTester tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..addScenario(
        widget: ProviderScope(
          child: const MaterialApp(home: FamilyPage()),
        ),
        name: 'default',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'family_widget');
  });

  testGoldens('Self Care golden test', (WidgetTester tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..addScenario(
        widget: ProviderScope(
          child: const MaterialApp(home: SelfCare()),
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
        widget: ProviderScope(
          child: const MaterialApp(home: TaskTracker()),
        ),
        name: 'default',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'tasktracker_widget');
  });
}
