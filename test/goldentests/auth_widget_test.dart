// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';
// import 'package:hersphere/pages/authpages/login.dart';
// import 'package:hersphere/providers/auth_provider.dart';
// import 'package:mockito/mockito.dart';
// import '../firebasetest.dart';
// import '../mockfirebase.dart';

// class MockFirebaseApp extends Mock implements FirebaseApp {}

// void main() async {
//   setupFirebaseMocks();
  
//       // Create a mock FirebaseApp instance
//       final MockFirebaseApp mockFirebaseApp = MockFirebaseApp();

//       // Mock Firebase.initializeApp() to return the mockFirebaseApp instance
//       when(Firebase.initializeApp()).thenAnswer((_) async => mockFirebaseApp);



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

// class MockAuthNotifier extends Mock implements AuthNotifier {}


