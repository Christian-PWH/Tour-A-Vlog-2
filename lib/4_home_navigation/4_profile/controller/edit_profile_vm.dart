import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileLocationProvider = StateProvider<String>((ref) {
  return 'Getting location...';
});

final editProfileImageFilePathProvider =
    StateProvider.autoDispose<String>((ref) {
  return '';
});

final editProfileImageUpdatedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final editProfileImageDeletedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final editProfileLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
