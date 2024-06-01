
import 'package:hersphere/services/familyservice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'familyinstance_provider.g.dart';

@riverpod
FamilyService familyService(FamilyServiceRef ref) {
  // Create and return an instance of FamilyService here
  return FamilyService();
}
