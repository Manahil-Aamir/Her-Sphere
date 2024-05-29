// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskstream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$toDosStreamHash() => r'8aad3727abd926c93c2c0802ad08be67834a0282';

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

/// See also [toDosStream].
@ProviderFor(toDosStream)
const toDosStreamProvider = ToDosStreamFamily();

/// See also [toDosStream].
class ToDosStreamFamily extends Family<AsyncValue<List<ToDos>>> {
  /// See also [toDosStream].
  const ToDosStreamFamily();

  /// See also [toDosStream].
  ToDosStreamProvider call(
    String taskId,
  ) {
    return ToDosStreamProvider(
      taskId,
    );
  }

  @override
  ToDosStreamProvider getProviderOverride(
    covariant ToDosStreamProvider provider,
  ) {
    return call(
      provider.taskId,
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
  String? get name => r'toDosStreamProvider';
}

/// See also [toDosStream].
class ToDosStreamProvider extends AutoDisposeStreamProvider<List<ToDos>> {
  /// See also [toDosStream].
  ToDosStreamProvider(
    String taskId,
  ) : this._internal(
          (ref) => toDosStream(
            ref as ToDosStreamRef,
            taskId,
          ),
          from: toDosStreamProvider,
          name: r'toDosStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$toDosStreamHash,
          dependencies: ToDosStreamFamily._dependencies,
          allTransitiveDependencies:
              ToDosStreamFamily._allTransitiveDependencies,
          taskId: taskId,
        );

  ToDosStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final String taskId;

  @override
  Override overrideWith(
    Stream<List<ToDos>> Function(ToDosStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ToDosStreamProvider._internal(
        (ref) => create(ref as ToDosStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ToDos>> createElement() {
    return _ToDosStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ToDosStreamProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ToDosStreamRef on AutoDisposeStreamProviderRef<List<ToDos>> {
  /// The parameter `taskId` of this provider.
  String get taskId;
}

class _ToDosStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<ToDos>> with ToDosStreamRef {
  _ToDosStreamProviderElement(super.provider);

  @override
  String get taskId => (origin as ToDosStreamProvider).taskId;
}

String _$remainingStreamHash() => r'd2e987a2c6f896cde42d0f689ddae01dc829d754';

/// See also [remainingStream].
@ProviderFor(remainingStream)
const remainingStreamProvider = RemainingStreamFamily();

/// See also [remainingStream].
class RemainingStreamFamily extends Family<AsyncValue<int>> {
  /// See also [remainingStream].
  const RemainingStreamFamily();

  /// See also [remainingStream].
  RemainingStreamProvider call(
    String uid,
  ) {
    return RemainingStreamProvider(
      uid,
    );
  }

  @override
  RemainingStreamProvider getProviderOverride(
    covariant RemainingStreamProvider provider,
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
  String? get name => r'remainingStreamProvider';
}

/// See also [remainingStream].
class RemainingStreamProvider extends AutoDisposeStreamProvider<int> {
  /// See also [remainingStream].
  RemainingStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => remainingStream(
            ref as RemainingStreamRef,
            uid,
          ),
          from: remainingStreamProvider,
          name: r'remainingStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$remainingStreamHash,
          dependencies: RemainingStreamFamily._dependencies,
          allTransitiveDependencies:
              RemainingStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  RemainingStreamProvider._internal(
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
    Stream<int> Function(RemainingStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemainingStreamProvider._internal(
        (ref) => create(ref as RemainingStreamRef),
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
  AutoDisposeStreamProviderElement<int> createElement() {
    return _RemainingStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemainingStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RemainingStreamRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _RemainingStreamProviderElement
    extends AutoDisposeStreamProviderElement<int> with RemainingStreamRef {
  _RemainingStreamProviderElement(super.provider);

  @override
  String get uid => (origin as RemainingStreamProvider).uid;
}

String _$taskStreamHash() => r'5a08db8d5ce05cef41ad271548c64e78d71f7a32';

/// See also [taskStream].
@ProviderFor(taskStream)
const taskStreamProvider = TaskStreamFamily();

/// See also [taskStream].
class TaskStreamFamily extends Family<AsyncValue<TaskModel>> {
  /// See also [taskStream].
  const TaskStreamFamily();

  /// See also [taskStream].
  TaskStreamProvider call(
    String uid,
  ) {
    return TaskStreamProvider(
      uid,
    );
  }

  @override
  TaskStreamProvider getProviderOverride(
    covariant TaskStreamProvider provider,
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
  String? get name => r'taskStreamProvider';
}

/// See also [taskStream].
class TaskStreamProvider extends AutoDisposeStreamProvider<TaskModel> {
  /// See also [taskStream].
  TaskStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => taskStream(
            ref as TaskStreamRef,
            uid,
          ),
          from: taskStreamProvider,
          name: r'taskStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskStreamHash,
          dependencies: TaskStreamFamily._dependencies,
          allTransitiveDependencies:
              TaskStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  TaskStreamProvider._internal(
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
    Stream<TaskModel> Function(TaskStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskStreamProvider._internal(
        (ref) => create(ref as TaskStreamRef),
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
  AutoDisposeStreamProviderElement<TaskModel> createElement() {
    return _TaskStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskStreamRef on AutoDisposeStreamProviderRef<TaskModel> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _TaskStreamProviderElement
    extends AutoDisposeStreamProviderElement<TaskModel> with TaskStreamRef {
  _TaskStreamProviderElement(super.provider);

  @override
  String get uid => (origin as TaskStreamProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
