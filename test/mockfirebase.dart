import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseApp extends Mock implements FirebaseApp {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {}
