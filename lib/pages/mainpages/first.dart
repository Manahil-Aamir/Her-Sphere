import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/pages/mainpages/home.dart';
import 'package:hersphere/pages/mainpages/welcome.dart';
import 'package:hersphere/providers/auth_provider.dart';

class First extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(authNotifierProvider);

    return MaterialApp(
      home: loginState.when(
        data: (loggedIn) => loggedIn ? const Home() : const Welcome(),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
      ),
    );
  }
}
