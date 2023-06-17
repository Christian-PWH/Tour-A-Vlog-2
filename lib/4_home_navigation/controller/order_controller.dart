import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_controller.g.dart';

@Riverpod(keepAlive: true)
OrderController orderController(OrderControllerRef ref) {
  return OrderController(FirebaseDatabase.instance);
}

class OrderController {
  final FirebaseDatabase dbInstance;
  OrderController(this.dbInstance);

  Future<String> save({
    required String tourId,
    required String userId,
    required String status,
    required String fullName,
    required String email,
    required int quantity,
    required double price,
    required double totalPrice,
    required String bookingDate,
  }) async {
    try {
      final uid = FirebaseDatabase.instance.ref("Orders").push().key;
      final ref = FirebaseDatabase.instance.ref("Orders/$uid");

      await ref.set({
        'tourId': tourId,
        'userId': userId,
        'status': status,
        'fullName': fullName,
        'email': email,
        'quantity': quantity,
        'price': price,
        'totalPrice': totalPrice,
        'bookingDate': bookingDate,
      });
      return '';
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }
}
