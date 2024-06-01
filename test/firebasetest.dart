import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void setupFirebaseAuthMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel(
    'plugins.flutter.io/firebase_core',
  );

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'Firebase#initializeCore':
        return {
          'name': '[DEFAULT]',
          'options': {
            'apiKey': 'testApiKey',
            'appId': 'testAppId',
            'messagingSenderId': 'testSenderId',
            'projectId': 'testProjectId',
          },
          'pluginConstants': {},
        };
      case 'Firebase#initializeApp':
        return {
          'name': '[DEFAULT]',
          'options': {
            'apiKey': 'testApiKey',
            'appId': 'testAppId',
            'messagingSenderId': 'testSenderId',
            'projectId': 'testProjectId',
          },
        };
      default:
        return null;
    }
  });
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}
