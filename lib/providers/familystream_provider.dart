
import 'package:hersphere/models/birthdaymodel.dart';
import 'package:hersphere/providers/familyinstance_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Import Family model if needed

part 'familystream_provider.g.dart';

@riverpod
Stream<List<int>> numbersStream(NumbersStreamRef ref,String uid) {
  final familyService = ref.watch(familyServiceProvider);
  return familyService.getNumbers(uid);
}

@riverpod
Stream<List<String>> photoUrlsStream(PhotoUrlsStreamRef ref, String uid) {
  final familyService = ref.watch(familyServiceProvider);
  return familyService.getPhotoUrls(uid);
}

@riverpod
Stream<List<Birthday>> birthdaysStream(BirthdaysStreamRef ref, String uid) {
  final familyService = ref.watch(familyServiceProvider);
  return familyService.getBirthdays(uid);
}
