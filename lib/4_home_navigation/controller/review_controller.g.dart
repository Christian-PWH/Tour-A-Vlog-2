// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getReviewByTourIdHash() => r'34637fe4627d34466ea3e23e002d09e177c89b1c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef GetReviewByTourIdRef = AutoDisposeFutureProviderRef<List<ReviewModel>>;

/// See also [getReviewByTourId].
@ProviderFor(getReviewByTourId)
const getReviewByTourIdProvider = GetReviewByTourIdFamily();

/// See also [getReviewByTourId].
class GetReviewByTourIdFamily extends Family<AsyncValue<List<ReviewModel>>> {
  /// See also [getReviewByTourId].
  const GetReviewByTourIdFamily();

  /// See also [getReviewByTourId].
  GetReviewByTourIdProvider call({
    required String tourId,
  }) {
    return GetReviewByTourIdProvider(
      tourId: tourId,
    );
  }

  @override
  GetReviewByTourIdProvider getProviderOverride(
    covariant GetReviewByTourIdProvider provider,
  ) {
    return call(
      tourId: provider.tourId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getReviewByTourIdProvider';
}

/// See also [getReviewByTourId].
class GetReviewByTourIdProvider
    extends AutoDisposeFutureProvider<List<ReviewModel>> {
  /// See also [getReviewByTourId].
  GetReviewByTourIdProvider({
    required this.tourId,
  }) : super.internal(
          (ref) => getReviewByTourId(
            ref,
            tourId: tourId,
          ),
          from: getReviewByTourIdProvider,
          name: r'getReviewByTourIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getReviewByTourIdHash,
          dependencies: GetReviewByTourIdFamily._dependencies,
          allTransitiveDependencies:
              GetReviewByTourIdFamily._allTransitiveDependencies,
        );

  final String tourId;

  @override
  bool operator ==(Object other) {
    return other is GetReviewByTourIdProvider && other.tourId == tourId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$reviewControllerHash() => r'9293c143ac438f5ab4c6a8f99a7e386d52960ab4';

/// See also [reviewController].
@ProviderFor(reviewController)
final reviewControllerProvider = Provider<ReviewController>.internal(
  reviewController,
  name: r'reviewControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReviewControllerRef = ProviderRef<ReviewController>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
