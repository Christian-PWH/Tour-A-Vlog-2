// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTourByDealHash() => r'713c69672f7a0ee35267d5e7f5c7f2f94361cc82';

/// See also [getTourByDeal].
@ProviderFor(getTourByDeal)
final getTourByDealProvider =
    AutoDisposeFutureProvider<List<TourModel>>.internal(
  getTourByDeal,
  name: r'getTourByDealProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTourByDealHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetTourByDealRef = AutoDisposeFutureProviderRef<List<TourModel>>;
String _$getTourByCityHash() => r'6625308d9142df32996db2252274c4831552db8f';

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

typedef GetTourByCityRef = AutoDisposeFutureProviderRef<List<TourModel>>;

/// See also [getTourByCity].
@ProviderFor(getTourByCity)
const getTourByCityProvider = GetTourByCityFamily();

/// See also [getTourByCity].
class GetTourByCityFamily extends Family<AsyncValue<List<TourModel>>> {
  /// See also [getTourByCity].
  const GetTourByCityFamily();

  /// See also [getTourByCity].
  GetTourByCityProvider call({
    required String cityTitle,
  }) {
    return GetTourByCityProvider(
      cityTitle: cityTitle,
    );
  }

  @override
  GetTourByCityProvider getProviderOverride(
    covariant GetTourByCityProvider provider,
  ) {
    return call(
      cityTitle: provider.cityTitle,
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
  String? get name => r'getTourByCityProvider';
}

/// See also [getTourByCity].
class GetTourByCityProvider extends AutoDisposeFutureProvider<List<TourModel>> {
  /// See also [getTourByCity].
  GetTourByCityProvider({
    required this.cityTitle,
  }) : super.internal(
          (ref) => getTourByCity(
            ref,
            cityTitle: cityTitle,
          ),
          from: getTourByCityProvider,
          name: r'getTourByCityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTourByCityHash,
          dependencies: GetTourByCityFamily._dependencies,
          allTransitiveDependencies:
              GetTourByCityFamily._allTransitiveDependencies,
        );

  final String cityTitle;

  @override
  bool operator ==(Object other) {
    return other is GetTourByCityProvider && other.cityTitle == cityTitle;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityTitle.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$recommendationHash() => r'5058b94f334653f25e25ea23aab5972625dfda77';

/// See also [recommendation].
@ProviderFor(recommendation)
final recommendationProvider =
    AutoDisposeFutureProvider<List<TourModel>>.internal(
  recommendation,
  name: r'recommendationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recommendationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecommendationRef = AutoDisposeFutureProviderRef<List<TourModel>>;
String _$discoverByCategoryControllerHash() =>
    r'2e63307f2cf63fd2fe230331ef1b98d9354182a8';
typedef DiscoverByCategoryControllerRef
    = AutoDisposeFutureProviderRef<List<TourModel>>;

/// See also [discoverByCategoryController].
@ProviderFor(discoverByCategoryController)
const discoverByCategoryControllerProvider =
    DiscoverByCategoryControllerFamily();

/// See also [discoverByCategoryController].
class DiscoverByCategoryControllerFamily
    extends Family<AsyncValue<List<TourModel>>> {
  /// See also [discoverByCategoryController].
  const DiscoverByCategoryControllerFamily();

  /// See also [discoverByCategoryController].
  DiscoverByCategoryControllerProvider call({
    required String categorTitle,
  }) {
    return DiscoverByCategoryControllerProvider(
      categorTitle: categorTitle,
    );
  }

  @override
  DiscoverByCategoryControllerProvider getProviderOverride(
    covariant DiscoverByCategoryControllerProvider provider,
  ) {
    return call(
      categorTitle: provider.categorTitle,
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
  String? get name => r'discoverByCategoryControllerProvider';
}

/// See also [discoverByCategoryController].
class DiscoverByCategoryControllerProvider
    extends AutoDisposeFutureProvider<List<TourModel>> {
  /// See also [discoverByCategoryController].
  DiscoverByCategoryControllerProvider({
    required this.categorTitle,
  }) : super.internal(
          (ref) => discoverByCategoryController(
            ref,
            categorTitle: categorTitle,
          ),
          from: discoverByCategoryControllerProvider,
          name: r'discoverByCategoryControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$discoverByCategoryControllerHash,
          dependencies: DiscoverByCategoryControllerFamily._dependencies,
          allTransitiveDependencies:
              DiscoverByCategoryControllerFamily._allTransitiveDependencies,
        );

  final String categorTitle;

  @override
  bool operator ==(Object other) {
    return other is DiscoverByCategoryControllerProvider &&
        other.categorTitle == categorTitle;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categorTitle.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getTourByTypeHash() => r'3981d256546784f92c4e603d8de745a2208ad1ca';
typedef GetTourByTypeRef = AutoDisposeFutureProviderRef<List<TourModel>>;

/// See also [getTourByType].
@ProviderFor(getTourByType)
const getTourByTypeProvider = GetTourByTypeFamily();

/// See also [getTourByType].
class GetTourByTypeFamily extends Family<AsyncValue<List<TourModel>>> {
  /// See also [getTourByType].
  const GetTourByTypeFamily();

  /// See also [getTourByType].
  GetTourByTypeProvider call({
    required String type,
  }) {
    return GetTourByTypeProvider(
      type: type,
    );
  }

  @override
  GetTourByTypeProvider getProviderOverride(
    covariant GetTourByTypeProvider provider,
  ) {
    return call(
      type: provider.type,
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
  String? get name => r'getTourByTypeProvider';
}

/// See also [getTourByType].
class GetTourByTypeProvider extends AutoDisposeFutureProvider<List<TourModel>> {
  /// See also [getTourByType].
  GetTourByTypeProvider({
    required this.type,
  }) : super.internal(
          (ref) => getTourByType(
            ref,
            type: type,
          ),
          from: getTourByTypeProvider,
          name: r'getTourByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTourByTypeHash,
          dependencies: GetTourByTypeFamily._dependencies,
          allTransitiveDependencies:
              GetTourByTypeFamily._allTransitiveDependencies,
        );

  final String type;

  @override
  bool operator ==(Object other) {
    return other is GetTourByTypeProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$tourControllerHash() => r'd1cdbf9b01b81db9a6617de1522bddda0dee549b';

/// See also [tourController].
@ProviderFor(tourController)
final tourControllerProvider = Provider<TourController>.internal(
  tourController,
  name: r'tourControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tourControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TourControllerRef = ProviderRef<TourController>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
