// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$getBookingHistoryHash() => r'f0fee415ddf1af6e4d07b697fc5ea3d21e941658';

/// See also [GetBookingHistory].
@ProviderFor(GetBookingHistory)
final getBookingHistoryProvider = AutoDisposeAsyncNotifierProvider<
    GetBookingHistory, List<OrderModel>>.internal(
  GetBookingHistory.new,
  name: r'getBookingHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBookingHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GetBookingHistory = AutoDisposeAsyncNotifier<List<OrderModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
