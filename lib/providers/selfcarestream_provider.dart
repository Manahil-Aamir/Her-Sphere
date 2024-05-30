
import 'package:hersphere/models/journalmodel.dart';
import 'package:hersphere/models/selfcaremodel.dart';
import 'package:hersphere/providers/selfcareinstance_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selfcarestream_provider.g.dart';

@riverpod
Stream<List<JournalModel>> journalsStream(JournalsStreamRef ref, String uid) {
  final selfCareService = ref.watch(selfcareServiceProvider);
  return selfCareService.getJournals(uid);
}

@riverpod
Stream<List<bool>> checkedStream(CheckedStreamRef ref, String uid) {
  final selfCareService = ref.watch(selfcareServiceProvider);
  return selfCareService.getCheckedStream(uid);
}

@riverpod
Stream<SelfCareModel> hydrationStream(HydrationStreamRef ref, String uid) {
  final selfCareService = ref.watch(selfcareServiceProvider);
  return selfCareService.getSelfCareWithoutJournalAndChecked(uid);
}