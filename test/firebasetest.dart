import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel(
    'plugins.flutter.io/firebase_core',
  );

  channel.setMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'Firebase#initializeCore') {
      print('first');
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
      print('second');
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
    print('third');
    return null;
  });
}
