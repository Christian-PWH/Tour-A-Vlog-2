// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBookingHistoryHash() => r'd97be586b7d18b5efb25ac7a14f5375fb032c679';

/// See also [getBookingHistory].
@ProviderFor(getBookingHistory)
final getBookingHistoryProvider =
    AutoDisposeFutureProvider<List<OrderModel>>.internal(
  getBookingHistory,
  name: r'getBookingHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBookingHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetBookingHistoryRef = AutoDisposeFutureProviderRef<List<OrderModel>>;
String _$orderControllerHash() => r'bc56a2630746c48e3641d04f0afb71b11898286b';

/// See also [orderController].
@ProviderFor(orderController)
final orderControllerProvider = Provider<OrderController>.internal(
  orderController,
  name: r'orderControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderControllerRef = ProviderRef<OrderController>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
