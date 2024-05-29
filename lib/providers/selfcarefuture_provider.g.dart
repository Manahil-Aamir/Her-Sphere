// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selfcarefuture_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wakeupHash() => r'189b16c0f6e8b93bbdf45721da56891d9bbd8cee';

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

/// See also [wakeup].
@ProviderFor(wakeup)
const wakeupProvider = WakeupFamily();

/// See also [wakeup].
class WakeupFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [wakeup].
  const WakeupFamily();

  /// See also [wakeup].
  WakeupProvider call(
    String uid,
  ) {
    return WakeupProvider(
      uid,
    );
  }

  @override
  WakeupProvider getProviderOverride(
    covariant WakeupProvider provider,
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
  String? get name => r'wakeupProvider';
}

/// See also [wakeup].
class WakeupProvider extends AutoDisposeFutureProvider<DateTime?> {
  /// See also [wakeup].
  WakeupProvider(
    String uid,
  ) : this._internal(
          (ref) => wakeup(
            ref as WakeupRef,
            uid,
          ),
          from: wakeupProvider,
          name: r'wakeupProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wakeupHash,
          dependencies: WakeupFamily._dependencies,
          allTransitiveDependencies: WakeupFamily._allTransitiveDependencies,
          uid: uid,
        );

  WakeupProvider._internal(
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
    FutureOr<DateTime?> Function(WakeupRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WakeupProvider._internal(
        (ref) => create(ref as WakeupRef),
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
  AutoDisposeFutureProviderElement<DateTime?> createElement() {
    return _WakeupProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WakeupProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WakeupRef on AutoDisposeFutureProviderRef<DateTime?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _WakeupProviderElement extends AutoDisposeFutureProviderElement<DateTime?>
    with WakeupRef {
  _WakeupProviderElement(super.provider);

  @override
  String get uid => (origin as WakeupProvider).uid;
}

String _$sleepHash() => r'116df1e8c99d50a4fb58e0749b5fbd5499f4b030';

/// See also [sleep].
@ProviderFor(sleep)
const sleepProvider = SleepFamily();

/// See also [sleep].
class SleepFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [sleep].
  const SleepFamily();

  /// See also [sleep].
  SleepProvider call(
    String uid,
  ) {
    return SleepProvider(
      uid,
    );
  }

  @override
  SleepProvider getProviderOverride(
    covariant SleepProvider provider,
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
  String? get name => r'sleepProvider';
}

/// See also [sleep].
class SleepProvider extends AutoDisposeFutureProvider<DateTime?> {
  /// See also [sleep].
  SleepProvider(
    String uid,
  ) : this._internal(
          (ref) => sleep(
            ref as SleepRef,
            uid,
          ),
          from: sleepProvider,
          name: r'sleepProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sleepHash,
          dependencies: SleepFamily._dependencies,
          allTransitiveDependencies: SleepFamily._allTransitiveDependencies,
          uid: uid,
        );

  SleepProvider._internal(
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
    FutureOr<DateTime?> Function(SleepRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SleepProvider._internal(
        (ref) => create(ref as SleepRef),
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
  AutoDisposeFutureProviderElement<DateTime?> createElement() {
    return _SleepProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SleepProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SleepRef on AutoDisposeFutureProviderRef<DateTime?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _SleepProviderElement extends AutoDisposeFutureProviderElement<DateTime?>
    with SleepRef {
  _SleepProviderElement(super.provider);

  @override
  String get uid => (origin as SleepProvider).uid;
}

String _$notifyHash() => r'94445ced53c850666b669adb9bf7d99bfe3eb24f';

/// See also [notify].
@ProviderFor(notify)
const notifyProvider = NotifyFamily();

/// See also [notify].
class NotifyFamily extends Family<AsyncValue<bool>> {
  /// See also [notify].
  const NotifyFamily();

  /// See also [notify].
  NotifyProvider call(
    String uid,
  ) {
    return NotifyProvider(
      uid,
    );
  }

  @override
  NotifyProvider getProviderOverride(
    covariant NotifyProvider provider,
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
  String? get name => r'notifyProvider';
}

/// See also [notify].
class NotifyProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [notify].
  NotifyProvider(
    String uid,
  ) : this._internal(
          (ref) => notify(
            ref as NotifyRef,
            uid,
          ),
          from: notifyProvider,
          name: r'notifyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$notifyHash,
          dependencies: NotifyFamily._dependencies,
          allTransitiveDependencies: NotifyFamily._allTransitiveDependencies,
          uid: uid,
        );

  NotifyProvider._internal(
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
    FutureOr<bool> Function(NotifyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NotifyProvider._internal(
        (ref) => create(ref as NotifyRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _NotifyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NotifyProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NotifyRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _NotifyProviderElement extends AutoDisposeFutureProviderElement<bool>
    with NotifyRef {
  _NotifyProviderElement(super.provider);

  @override
  String get uid => (origin as NotifyProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
