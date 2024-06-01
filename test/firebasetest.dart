import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel(
    'plugins.flutter.io/firebase_core',
  );

  // ignore: deprecated_member_use
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'Firebase#initializeCore') {
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
    }
    if (methodCall.method == 'Firebase#initializeApp') {
      return {
        'name': '[DEFAULT]',
        'options': {
          'apiKey': 'testApiKey',
          'appId': 'testAppId',
          'messagingSenderId': 'testSenderId',
          'projectId': 'testProjectId',
        },
      };
    }
    return null;
  });
}