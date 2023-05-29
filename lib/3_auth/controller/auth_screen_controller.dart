import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final signUpLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
