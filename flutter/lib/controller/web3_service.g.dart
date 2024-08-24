// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web3_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBalanceHash() => r'88559bae4b07057737382c0e7c8606e96cfc6fa0';

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

/// See also [getBalance].
@ProviderFor(getBalance)
const getBalanceProvider = GetBalanceFamily();

/// See also [getBalance].
class GetBalanceFamily extends Family<AsyncValue<String>> {
  /// See also [getBalance].
  const GetBalanceFamily();

  /// See also [getBalance].
  GetBalanceProvider call(
    String address,
  ) {
    return GetBalanceProvider(
      address,
    );
  }

  @override
  GetBalanceProvider getProviderOverride(
    covariant GetBalanceProvider provider,
  ) {
    return call(
      provider.address,
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
  String? get name => r'getBalanceProvider';
}

/// See also [getBalance].
class GetBalanceProvider extends AutoDisposeFutureProvider<String> {
  /// See also [getBalance].
  GetBalanceProvider(
    String address,
  ) : this._internal(
          (ref) => getBalance(
            ref as GetBalanceRef,
            address,
          ),
          from: getBalanceProvider,
          name: r'getBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBalanceHash,
          dependencies: GetBalanceFamily._dependencies,
          allTransitiveDependencies:
              GetBalanceFamily._allTransitiveDependencies,
          address: address,
        );

  GetBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<String> Function(GetBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBalanceProvider._internal(
        (ref) => create(ref as GetBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _GetBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBalanceProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBalanceRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `address` of this provider.
  String get address;
}

class _GetBalanceProviderElement
    extends AutoDisposeFutureProviderElement<String> with GetBalanceRef {
  _GetBalanceProviderElement(super.provider);

  @override
  String get address => (origin as GetBalanceProvider).address;
}

String _$getTokenBalanceHash() => r'03fab21232e57c48ca9b06280ff9d01d82f27ac5';

/// See also [getTokenBalance].
@ProviderFor(getTokenBalance)
const getTokenBalanceProvider = GetTokenBalanceFamily();

/// See also [getTokenBalance].
class GetTokenBalanceFamily extends Family<AsyncValue<String>> {
  /// See also [getTokenBalance].
  const GetTokenBalanceFamily();

  /// See also [getTokenBalance].
  GetTokenBalanceProvider call(
    String address,
    String tokenAddress,
  ) {
    return GetTokenBalanceProvider(
      address,
      tokenAddress,
    );
  }

  @override
  GetTokenBalanceProvider getProviderOverride(
    covariant GetTokenBalanceProvider provider,
  ) {
    return call(
      provider.address,
      provider.tokenAddress,
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
  String? get name => r'getTokenBalanceProvider';
}

/// See also [getTokenBalance].
class GetTokenBalanceProvider extends AutoDisposeFutureProvider<String> {
  /// See also [getTokenBalance].
  GetTokenBalanceProvider(
    String address,
    String tokenAddress,
  ) : this._internal(
          (ref) => getTokenBalance(
            ref as GetTokenBalanceRef,
            address,
            tokenAddress,
          ),
          from: getTokenBalanceProvider,
          name: r'getTokenBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTokenBalanceHash,
          dependencies: GetTokenBalanceFamily._dependencies,
          allTransitiveDependencies:
              GetTokenBalanceFamily._allTransitiveDependencies,
          address: address,
          tokenAddress: tokenAddress,
        );

  GetTokenBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
    required this.tokenAddress,
  }) : super.internal();

  final String address;
  final String tokenAddress;

  @override
  Override overrideWith(
    FutureOr<String> Function(GetTokenBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTokenBalanceProvider._internal(
        (ref) => create(ref as GetTokenBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
        tokenAddress: tokenAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _GetTokenBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTokenBalanceProvider &&
        other.address == address &&
        other.tokenAddress == tokenAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, tokenAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTokenBalanceRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `address` of this provider.
  String get address;

  /// The parameter `tokenAddress` of this provider.
  String get tokenAddress;
}

class _GetTokenBalanceProviderElement
    extends AutoDisposeFutureProviderElement<String> with GetTokenBalanceRef {
  _GetTokenBalanceProviderElement(super.provider);

  @override
  String get address => (origin as GetTokenBalanceProvider).address;
  @override
  String get tokenAddress => (origin as GetTokenBalanceProvider).tokenAddress;
}

String _$allOrdersHash() => r'd999976da445c0099c878b3664b9aa1ae16e6cc8';

/// See also [allOrders].
@ProviderFor(allOrders)
final allOrdersProvider = AutoDisposeFutureProvider<List<Order>>.internal(
  allOrders,
  name: r'allOrdersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllOrdersRef = AutoDisposeFutureProviderRef<List<Order>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
