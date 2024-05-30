// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selfcarestream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journalsStreamHash() => r'8083a89c04be35305f4dce59f518452cea70004a';

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

/// See also [journalsStream].
@ProviderFor(journalsStream)
const journalsStreamProvider = JournalsStreamFamily();

/// See also [journalsStream].
class JournalsStreamFamily extends Family<AsyncValue<List<JournalModel>>> {
  /// See also [journalsStream].
  const JournalsStreamFamily();

  /// See also [journalsStream].
  JournalsStreamProvider call(
    String uid,
  ) {
    return JournalsStreamProvider(
      uid,
    );
  }

  @override
  JournalsStreamProvider getProviderOverride(
    covariant JournalsStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'journalsStreamProvider';
}

/// See also [journalsStream].
class JournalsStreamProvider
    extends AutoDisposeStreamProvider<List<JournalModel>> {
  /// See also [journalsStream].
  JournalsStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => journalsStream(
            ref as JournalsStreamRef,
            uid,
          ),
          from: journalsStreamProvider,
          name: r'journalsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$journalsStreamHash,
          dependencies: JournalsStreamFamily._dependencies,
          allTransitiveDependencies:
              JournalsStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  JournalsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<List<JournalModel>> Function(JournalsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JournalsStreamProvider._internal(
        (ref) => create(ref as JournalsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<JournalModel>> createElement() {
    return _JournalsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalsStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin JournalsStreamRef on AutoDisposeStreamProviderRef<List<JournalModel>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _JournalsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<JournalModel>>
    with JournalsStreamRef {
  _JournalsStreamProviderElement(super.provider);

  @override
  String get uid => (origin as JournalsStreamProvider).uid;
}

String _$checkedStreamHash() => r'c0d54f5bbdd8b631b775bf78ae6cbfdb0427826d';

/// See also [checkedStream].
@ProviderFor(checkedStream)
const checkedStreamProvider = CheckedStreamFamily();

/// See also [checkedStream].
class CheckedStreamFamily extends Family<AsyncValue<List<bool>>> {
  /// See also [checkedStream].
  const CheckedStreamFamily();

  /// See also [checkedStream].
  CheckedStreamProvider call(
    String uid,
  ) {
    return CheckedStreamProvider(
      uid,
    );
  }

  @override
  CheckedStreamProvider getProviderOverride(
    covariant CheckedStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'checkedStreamProvider';
}

/// See also [checkedStream].
class CheckedStreamProvider extends AutoDisposeStreamProvider<List<bool>> {
  /// See also [checkedStream].
  CheckedStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => checkedStream(
            ref as CheckedStreamRef,
            uid,
          ),
          from: checkedStreamProvider,
          name: r'checkedStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkedStreamHash,
          dependencies: CheckedStreamFamily._dependencies,
          allTransitiveDependencies:
              CheckedStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  CheckedStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<List<bool>> Function(CheckedStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckedStreamProvider._internal(
        (ref) => create(ref as CheckedStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<bool>> createElement() {
    return _CheckedStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckedStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CheckedStreamRef on AutoDisposeStreamProviderRef<List<bool>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _CheckedStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<bool>> with CheckedStreamRef {
  _CheckedStreamProviderElement(super.provider);

  @override
  String get uid => (origin as CheckedStreamProvider).uid;
}

String _$hydrationStreamHash() => r'554940ad587b8dc54d19e0afd7aa24d62809e1f8';

/// See also [hydrationStream].
@ProviderFor(hydrationStream)
const hydrationStreamProvider = HydrationStreamFamily();

/// See also [hydrationStream].
class HydrationStreamFamily extends Family<AsyncValue<SelfCareModel>> {
  /// See also [hydrationStream].
  const HydrationStreamFamily();

  /// See also [hydrationStream].
  HydrationStreamProvider call(
    String uid,
  ) {
    return HydrationStreamProvider(
      uid,
    );
  }

  @override
  HydrationStreamProvider getProviderOverride(
    covariant HydrationStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'hydrationStreamProvider';
}

/// See also [hydrationStream].
class HydrationStreamProvider extends AutoDisposeStreamProvider<SelfCareModel> {
  /// See also [hydrationStream].
  HydrationStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => hydrationStream(
            ref as HydrationStreamRef,
            uid,
          ),
          from: hydrationStreamProvider,
          name: r'hydrationStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hydrationStreamHash,
          dependencies: HydrationStreamFamily._dependencies,
          allTransitiveDependencies:
              HydrationStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  HydrationStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<SelfCareModel> Function(HydrationStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HydrationStreamProvider._internal(
        (ref) => create(ref as HydrationStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SelfCareModel> createElement() {
    return _HydrationStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HydrationStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HydrationStreamRef on AutoDisposeStreamProviderRef<SelfCareModel> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _HydrationStreamProviderElement
    extends AutoDisposeStreamProviderElement<SelfCareModel>
    with HydrationStreamRef {
  _HydrationStreamProviderElement(super.provider);

  @override
  String get uid => (origin as HydrationStreamProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
