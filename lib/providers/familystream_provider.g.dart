// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'familystream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$numbersStreamHash() => r'c9ef700955f16f09ab2ea91ff4dcdba4ac2f28ea';

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

/// See also [numbersStream].
@ProviderFor(numbersStream)
const numbersStreamProvider = NumbersStreamFamily();

/// See also [numbersStream].
class NumbersStreamFamily extends Family<AsyncValue<List<int>>> {
  /// See also [numbersStream].
  const NumbersStreamFamily();

  /// See also [numbersStream].
  NumbersStreamProvider call(
    String uid,
  ) {
    return NumbersStreamProvider(
      uid,
    );
  }

  @override
  NumbersStreamProvider getProviderOverride(
    covariant NumbersStreamProvider provider,
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
  String? get name => r'numbersStreamProvider';
}

/// See also [numbersStream].
class NumbersStreamProvider extends AutoDisposeStreamProvider<List<int>> {
  /// See also [numbersStream].
  NumbersStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => numbersStream(
            ref as NumbersStreamRef,
            uid,
          ),
          from: numbersStreamProvider,
          name: r'numbersStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$numbersStreamHash,
          dependencies: NumbersStreamFamily._dependencies,
          allTransitiveDependencies:
              NumbersStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  NumbersStreamProvider._internal(
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
    Stream<List<int>> Function(NumbersStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NumbersStreamProvider._internal(
        (ref) => create(ref as NumbersStreamRef),
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
  AutoDisposeStreamProviderElement<List<int>> createElement() {
    return _NumbersStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NumbersStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NumbersStreamRef on AutoDisposeStreamProviderRef<List<int>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _NumbersStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<int>> with NumbersStreamRef {
  _NumbersStreamProviderElement(super.provider);

  @override
  String get uid => (origin as NumbersStreamProvider).uid;
}

String _$photoUrlsStreamHash() => r'badd102bc386bf37aa626be77f5d9c00ff289df8';

/// See also [photoUrlsStream].
@ProviderFor(photoUrlsStream)
const photoUrlsStreamProvider = PhotoUrlsStreamFamily();

/// See also [photoUrlsStream].
class PhotoUrlsStreamFamily extends Family<AsyncValue<List<String>>> {
  /// See also [photoUrlsStream].
  const PhotoUrlsStreamFamily();

  /// See also [photoUrlsStream].
  PhotoUrlsStreamProvider call(
    String uid,
  ) {
    return PhotoUrlsStreamProvider(
      uid,
    );
  }

  @override
  PhotoUrlsStreamProvider getProviderOverride(
    covariant PhotoUrlsStreamProvider provider,
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
  String? get name => r'photoUrlsStreamProvider';
}

/// See also [photoUrlsStream].
class PhotoUrlsStreamProvider extends AutoDisposeStreamProvider<List<String>> {
  /// See also [photoUrlsStream].
  PhotoUrlsStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => photoUrlsStream(
            ref as PhotoUrlsStreamRef,
            uid,
          ),
          from: photoUrlsStreamProvider,
          name: r'photoUrlsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$photoUrlsStreamHash,
          dependencies: PhotoUrlsStreamFamily._dependencies,
          allTransitiveDependencies:
              PhotoUrlsStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  PhotoUrlsStreamProvider._internal(
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
    Stream<List<String>> Function(PhotoUrlsStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PhotoUrlsStreamProvider._internal(
        (ref) => create(ref as PhotoUrlsStreamRef),
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
  AutoDisposeStreamProviderElement<List<String>> createElement() {
    return _PhotoUrlsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PhotoUrlsStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PhotoUrlsStreamRef on AutoDisposeStreamProviderRef<List<String>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _PhotoUrlsStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<String>>
    with PhotoUrlsStreamRef {
  _PhotoUrlsStreamProviderElement(super.provider);

  @override
  String get uid => (origin as PhotoUrlsStreamProvider).uid;
}

String _$birthdaysStreamHash() => r'35e1d31f38282b3721950c72bbb3e3e9a824fd93';

/// See also [birthdaysStream].
@ProviderFor(birthdaysStream)
const birthdaysStreamProvider = BirthdaysStreamFamily();

/// See also [birthdaysStream].
class BirthdaysStreamFamily extends Family<AsyncValue<List<Birthday>>> {
  /// See also [birthdaysStream].
  const BirthdaysStreamFamily();

  /// See also [birthdaysStream].
  BirthdaysStreamProvider call(
    String uid,
  ) {
    return BirthdaysStreamProvider(
      uid,
    );
  }

  @override
  BirthdaysStreamProvider getProviderOverride(
    covariant BirthdaysStreamProvider provider,
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
  String? get name => r'birthdaysStreamProvider';
}

/// See also [birthdaysStream].
class BirthdaysStreamProvider
    extends AutoDisposeStreamProvider<List<Birthday>> {
  /// See also [birthdaysStream].
  BirthdaysStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => birthdaysStream(
            ref as BirthdaysStreamRef,
            uid,
          ),
          from: birthdaysStreamProvider,
          name: r'birthdaysStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$birthdaysStreamHash,
          dependencies: BirthdaysStreamFamily._dependencies,
          allTransitiveDependencies:
              BirthdaysStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  BirthdaysStreamProvider._internal(
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
    Stream<List<Birthday>> Function(BirthdaysStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BirthdaysStreamProvider._internal(
        (ref) => create(ref as BirthdaysStreamRef),
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
  AutoDisposeStreamProviderElement<List<Birthday>> createElement() {
    return _BirthdaysStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BirthdaysStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BirthdaysStreamRef on AutoDisposeStreamProviderRef<List<Birthday>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _BirthdaysStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Birthday>>
    with BirthdaysStreamRef {
  _BirthdaysStreamProviderElement(super.provider);

  @override
  String get uid => (origin as BirthdaysStreamProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
