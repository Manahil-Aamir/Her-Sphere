
import 'package:hersphere/providers/selfcareinstance_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selfcarefuture_provider.g.dart';


@riverpod
Future<DateTime?> wakeup(WakeupRef ref, String uid) {
  final selfCareService = ref.watch(selfcareServiceProvider );
  return selfCareService.getWakeupTime(uid);
}

@riverpod
Future<DateTime?> sleep(SleepRef ref, String uid) {
  final selfCareService = ref.watch(selfcareServiceProvider );
  return selfCareService.getSleepTime(uid);
}

@riverpod
Future<bool> notify(NotifyRef ref, String uid) {
  final selfCareService = ref.watch(selfcareServiceProvider );
  return selfCareService.getNotify(uid);
}