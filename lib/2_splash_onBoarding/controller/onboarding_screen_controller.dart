import 'package:flutter_riverpod/flutter_riverpod.dart';

final onBoardingIsLoginProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
