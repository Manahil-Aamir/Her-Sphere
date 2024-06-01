import 'package:hersphere/services/selfcareservice.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selfcareinstance_provider.g.dart';

@riverpod
SelfCareService selfcareService(SelfcareServiceRef ref) {
  // Create and return an instance of SelfcareService here
  return SelfCareService();
}