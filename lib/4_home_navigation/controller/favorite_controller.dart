import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/tour_controller.dart';

part 'favorite_controller.g.dart';

@riverpod
bool isFavorite(
  IsFavoriteRef ref, {
  required String tourId,
}) {
  final favorites = ref.watch(favoriteControllerProvider).asData?.value ?? [];
  for (int i = 0; i < favorites.length; i++) {
    if (favorites[i].id == tourId) return true;
  }
  return false;
}

@Riverpod(keepAlive: true)
class FavoriteController extends _$FavoriteController {
  late final FirebaseDatabase _dbInstance;
  late final UserController _userController;
  late final TourController _tourController;

  @override
  FutureOr<List<TourModel>> build() {
    _dbInstance = FirebaseDatabase.instance;
    _userController = ref.watch(userControllerProvider.notifier);
    _tourController = ref.watch(tourControllerProvider);
    return get();
  }

  FutureOr<List<TourModel>> get() async {
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return [];
    state = const AsyncValue.loading();
    try {
      final ref = _dbInstance.ref('Users/${currentUser.uid}/favorites');
      final snapshot = await ref.get();
      if (!snapshot.exists) return [];
      final toursFuture = (snapshot.value as List).map((e) {
        return _tourController.getTourById(e as String);
      }).toList();
      final toursFutureResult = (await Future.wait(toursFuture));
      final List<TourModel> tours = [];
      for (int i = 0; i < toursFutureResult.length; i++) {
        if (toursFutureResult[i] != null) {
          tours.add(toursFutureResult[i]!);
        }
      }
      return tours;
    } on FirebaseException catch (_) {
      return [];
    }
  }

  Future<String> save(String tourId) async {
    debugPrint('SAVE');
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return 'Current User Null';
    state = const AsyncValue.loading();
    final toursId = state.value!.map((e) => e.id).toList();
    if (toursId.contains(tourId)) return 'Already saved';
    try {
      final ref = _dbInstance.ref('Users/${currentUser.uid}/favorites');

      await ref.set([...toursId, tourId]);
      final tour = await _tourController.getTourById(tourId);
      if (tour == null) {
        state = await AsyncValue.guard(() async => get());
        return '';
      }
      final favorites = state.value!..add(tour);
      state = AsyncValue.data(favorites);
      return '';
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<String> remove(String tourId) async {
    debugPrint('REMOVE');
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return 'Current User Null';
    state = const AsyncValue.loading();
    try {
      final ref = _dbInstance.ref('Users/${currentUser.uid}/favorites');
      final favorites =
          state.value!.where((element) => element.id != tourId).toList();
      final toursId = favorites.map((e) => e.id).toList();
      await ref.set(toursId);
      state = AsyncValue.data(favorites);
      return '';
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }
}
