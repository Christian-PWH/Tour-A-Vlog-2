import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/order_model.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/notification_controller.dart';

part 'order_controller.g.dart';

// @riverpod
// FutureOr<List<OrderModel>> getBookingHistory(GetBookingHistoryRef ref) {
//   final orderController = ref.watch(orderControllerProvider);
//   return orderController.getByCurrentUser();
// }

@riverpod
class GetBookingHistory extends _$GetBookingHistory {
  late final OrderController _orderController;
  late final NotificationController _notificationController;
  @override
  FutureOr<List<OrderModel>> build() {
    _orderController = ref.watch(orderControllerProvider);
    _notificationController =
        ref.watch(notificationControllerProvider.notifier);
    return _orderController.getByCurrentUser();
  }

  FutureOr<String> delete(OrderModel order) async {
    state = await AsyncValue.guard(() async {
      await _orderController.delete(order);
      _notificationController.add(
          title: "New Order Canceled",
          description:
              "Order to ${order.tour.title} with orderId ${order.id} has been canceled");
      return _orderController.getByCurrentUser();
    });
    return '';
  }
}

@Riverpod(keepAlive: true)
OrderController orderController(OrderControllerRef ref) {
  return OrderController(
    FirebaseDatabase.instance,
    ref.watch(userControllerProvider.notifier),
    ref.watch(notificationControllerProvider.notifier),
  );
}

class OrderController {
  final FirebaseDatabase dbInstance;
  final UserController userController;
  final NotificationController notificationController;

  OrderController(
    this.dbInstance,
    this.userController,
    this.notificationController,
  );

  Future<List<OrderModel>> getByCurrentUser() async {
    final user = await userController.getCurrentUser();
    if (user == null) return [];
    final snapshot = await dbInstance
        .ref()
        .child('Orders')
        .orderByChild('userId')
        .equalTo(user.uid)
        .get();

    if (!snapshot.exists) return [];

    Map newMap = snapshot.value as Map;
    List<OrderModel> extractedListOfOrder = [];
    newMap.forEach((key, value) {
      Map<dynamic, dynamic> extractedMap = newMap[key];
      extractedMap['id'] = key;
      extractedListOfOrder.add(OrderModel.fromMap(extractedMap));
    });
    return extractedListOfOrder;
  }

  Future<String> delete(OrderModel order) async {
    if (order.status != 'new') {
      return 'Only new / pending order can be canceled';
    }
    final ref = FirebaseDatabase.instance.ref('Orders/${order.id}');
    await ref.remove();
    return '';
  }

  Future<String> save({
    required TourModel tour,
    required String userId,
    required String status,
    required String fullName,
    required String numberPhone,
    required String email,
    required int quantity,
    required double price,
    required double totalPrice,
    required DateTime bookingDate,
  }) async {
    try {
      final uid = FirebaseDatabase.instance.ref("Orders").push().key;
      final ref = FirebaseDatabase.instance.ref("Orders/$uid");

      await ref.set({
        // 'tourId': tourId,
        'tour': tour.toMap(),
        'userId': userId,
        'status': status,
        'fullName': fullName,
        'numberPhone': numberPhone,
        'email': email,
        'quantity': quantity,
        'price': price,
        'totalPrice': totalPrice,
        'bookingDate': bookingDate.toString(),
      });

      final errMsg = await notificationController.add(
        title: 'New Order Added',
        description: 'Journey to ${tour.title} with orderId $uid',
      );
      return errMsg;
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }
}
