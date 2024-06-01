// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';
// import 'package:hersphere/methods/authentication/google.dart';
// import 'package:hersphere/pages/authpages/login.dart';
// import 'package:hersphere/providers/auth_provider.dart';
// import 'package:mockito/mockito.dart';
// import 'package:riverpod/riverpod.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure WidgetsBinding is initialized

//   // Initialize Firebase
//   await Firebase.initializeApp();

//   testGoldens('Login widget golden test', (WidgetTester tester) async {
//     await loadAppFonts();

//     // Mock the auth notifier
//     final authNotifier = MockAuthNotifier();

//     final builder = DeviceBuilder()
//       ..addScenario(
//         widget: ProviderScope(
//           overrides: [
//             authNotifierProvider.overrideWith(() => authNotifier),
//           ],
//           child: const MaterialApp(home: Login()),
//         ),
//         name: 'login page',
//       );

//     await tester.pumpDeviceBuilder(builder);

//     await screenMatchesGolden(tester, 'login_widget'); // Adjust the name as per your golden file
//   });
// }


// // Mock auth notifier class
// class MockAuthNotifier extends Mock implements AuthNotifier {}

