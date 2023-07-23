import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/notification_model.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';

part 'notification_controller.g.dart';

// @Riverpod(keepAlive: true)
// int notificationCount(NotificationCountRef ref) {
//   return 0;
// }

@Riverpod(keepAlive: true)
class NotificationController extends _$NotificationController {
  late final FirebaseDatabase _dbInstance;
  late final UserController _userController;

  @override
  FutureOr<List<NotificationModel>> build() {
    _dbInstance = FirebaseDatabase.instance;
    _userController = ref.watch(userControllerProvider.notifier);
    _listenForChildEvent();
    // return _get()
    return [];
  }

  // Future<List<NotificationModel>> _get() async {
  //   final currentUser = await _userController.getCurrentUser();
  //   if (currentUser == null) return [];
  //   final ref = _dbInstance.ref('Users/${currentUser.uid}/notifications');
  //   final query = ref.orderByKey();
  //   final snapshot = await query.get();
  //   if (!snapshot.exists) return [];

  //   Map newMap = snapshot.value as Map;

  //   final notifications = _extractFromFirebase(newMap);

  //   _listenForChildEvent(ref);

  //   return notifications;
  // }

  void _listenForChildEvent() async {
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return;

    final ref = _dbInstance
        .ref('Users/${currentUser.uid}/notifications')
        .orderByChild('date');
    ref.onChildAdded.listen((event) {
      debugPrint("Listen onChildAdded");
      debugPrint(event.snapshot.value.toString());
      debugPrint(event.snapshot.key.toString());
      if (!event.snapshot.exists) return;
      Map<dynamic, dynamic> extractedMap = event.snapshot.value as Map;
      extractedMap['id'] = event.snapshot.key;
      final notifications = NotificationModel.fromMap(extractedMap);
      final oldNotifications = state.asData?.value ?? [];
      state = AsyncValue.data([notifications, ...oldNotifications]);
    });

    ref.onChildRemoved.listen((event) {
      debugPrint("Listen onChildRemoved");
      debugPrint(event.snapshot.value.toString());
      debugPrint(event.snapshot.key.toString());
      if (!event.snapshot.exists) return;
      final notifications = state.asData?.value ?? [];
      notifications.removeWhere((e) => e.id == event.snapshot.key);
      state = AsyncValue.data(notifications);
    });
  }

  // List<NotificationModel> _extractFromFirebase(Map newMap) {
  //   debugPrint(newMap.toString());
  //   List<NotificationModel> extractedListOfNotification = [];
  //   newMap.forEach((key, value) {
  //     Map<dynamic, dynamic> extractedMap = newMap[key];
  //     extractedMap['id'] = key;
  //     extractedListOfNotification.add(NotificationModel.fromMap(extractedMap));
  //   });
  //   return extractedListOfNotification;
  // }

  FutureOr<String> add({
    required String title,
    required String description,
  }) async {
    // state = const AsyncValue.loading();
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return '';
    // List<String> notificationItems = state.value!;
    try {
      final ref = _dbInstance.ref('Users/${currentUser.uid}/notifications');
      // await ref.set([title]);
      await ref.push().set({
        'title': title,
        'description': description,
        'date': DateTime.now().toIso8601String(),
      });
      // notificationItems = state.value!..add(title);
      // state = AsyncValue.data(notificationItems);
      return '';
    } on FirebaseException catch (e) {
      state = AsyncValue.error('', StackTrace.current);
      return e.toString();
    }
  }

  FutureOr<String> remove(NotificationModel notification) async {
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return '';
    try {
      final ref = _dbInstance
          .ref('Users/${currentUser.uid}/notifications/${notification.id}');
      await ref.remove();
      return '';
    } on FirebaseException catch (e) {
      state = AsyncValue.error('', StackTrace.current);
      return e.toString();
    }
  }
}
