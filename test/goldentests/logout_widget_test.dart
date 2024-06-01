// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';
// import 'package:hersphere/pages/impwidgets/logout.dart';
// import 'package:hersphere/providers/auth_provider.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MockSharedPreferences extends Mock implements SharedPreferences {}

// void main() {
//   // Initialize mock shared preferences before any test runs
//   SharedPreferences.setMockInitialValues({});

//   // Define the mock provider
//   final mockSharedPreferences = MockSharedPreferences();

//   setUp(() {
//     when(mockSharedPreferences.getBool(any())).thenReturn(true);
//     when(mockSharedPreferences.setBool(any, any)).thenAnswer((_) async => true);
//   });

//   testGoldens('Logout widget golden test', (tester) async {
//     // Override the provider
//     final authNotifierProvider = Provider<AuthNotifier>((ref) {
//       return AuthNotifier()..state = true; // Mock the logged-in state
//     });


//     // Build the Logout widget
//     final logoutWidget = UncontrolledProviderScope(
//       container: container,
//       child: MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: Logout(),
//           ),
//         ),
//       ),
//     );

//     // Load the widget
//     await tester.pumpWidgetBuilder(logoutWidget);

//     // Capture the initial state of the widget
//     await screenMatchesGolden(tester, 'logout_widget_initial');
//   });
// }
