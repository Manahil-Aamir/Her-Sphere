import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hersphere/pages/authpages/login.dart';
import 'package:hersphere/providers/auth_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../firebasetest.dart';

// Mock classes
class MockFirebaseApp extends Mock implements FirebaseApp {}
class MockAuthNotifier extends Mock implements AuthNotifier {}

// Main test function
void main() {
  setupFirebaseMocks();

  setUpAll(() async {
    // Mock Firebase initialization
    await Firebase.initializeApp();
  });

  testGoldens('Login widget golden test', (WidgetTester tester) async {
    await loadAppFonts();

    // Create the mock auth notifier
    final authNotifier = MockAuthNotifier();

    final builder = DeviceBuilder()
      ..addScenario(
        widget: ProviderScope(
          overrides: [
            authNotifierProvider.overrideWith(() => authNotifier),
          ],
          child: const MaterialApp(home: Login()),
        ),
        name: 'login page',
      );

    await tester.pumpDeviceBuilder(builder);

    // Ensure the screen matches the golden file
    await screenMatchesGolden(tester, 'login_widget');
  });
}
