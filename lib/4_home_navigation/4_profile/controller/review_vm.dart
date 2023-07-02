import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewStarProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
