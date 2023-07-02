import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/notification_model.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';

part 'notification_controller.g.dart';

@Riverpod(keepAlive: true)
class NotificationController extends _$NotificationController {
  late final FirebaseDatabase _dbInstance;
  late final UserController _userController;

  @override
  FutureOr<List<String>> build() {
    _dbInstance = FirebaseDatabase.instance;
    _userController = ref.watch(userControllerProvider.notifier);

    return _get();
  }

  Future<List<String>> _get() async {
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return [];
    final ref = _dbInstance.ref('Users/${currentUser.uid}/notifications');
    final snapshot = await ref.get();
    if (!snapshot.exists) return [];
    _listenForChildEvent(ref);
    return (snapshot.value as List).map((e) => e as String).toList();
  }

  void _listenForChildEvent(DatabaseReference ref) {
    ref.onChildAdded.listen((event) {
      debugPrint(event.snapshot.value.toString());
    });
  }

  FutureOr<String> add(String title) async {
    // state = const AsyncValue.loading();
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return '';
    // List<String> notificationItems = state.value!;
    try {
      final ref = _dbInstance.ref('Users/${currentUser.uid}/notifications');
      await ref.set([title]);
      // notificationItems = state.value!..add(title);
      // state = AsyncValue.data(notificationItems);
      return '';
    } on FirebaseException catch (e) {
      state = AsyncValue.error('', StackTrace.current);
      return e.toString();
    }
  }
}
