import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
    // Return a stream with a mock user
    final mockUser = MockUser();
    return Stream.value(mockUser);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // Return a future with a mock user credential
    final mockUserCredential = MockUserCredential();
    return Future.value(mockUserCredential);
  }

}

class MockUser extends Mock implements User {

}

class MockUserCredential extends Mock implements UserCredential {
  
}