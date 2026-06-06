// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ActivityItem> items) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ActivityItem> items)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ActivityItem> items)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationInitial value) initial,
    required TResult Function(NotificationLoading value) loading,
    required TResult Function(NotificationLoaded value) loaded,
    required TResult Function(NotificationFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationInitial value)? initial,
    TResult? Function(NotificationLoading value)? loading,
    TResult? Function(NotificationLoaded value)? loaded,
    TResult? Function(NotificationFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationInitial value)? initial,
    TResult Function(NotificationLoading value)? loading,
    TResult Function(NotificationLoaded value)? loaded,
    TResult Function(NotificationFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationStateCopyWith<$Res> {
  factory $NotificationStateCopyWith(
    NotificationState value,
    $Res Function(NotificationState) then,
  ) = _$NotificationStateCopyWithImpl<$Res, NotificationState>;
}

/// @nodoc
class _$NotificationStateCopyWithImpl<$Res, $Val extends NotificationState>
    implements $NotificationStateCopyWith<$Res> {
  _$NotificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NotificationInitialImplCopyWith<$Res> {
  factory _$$NotificationInitialImplCopyWith(
    _$NotificationInitialImpl value,
    $Res Function(_$NotificationInitialImpl) then,
  ) = __$$NotificationInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationInitialImplCopyWithImpl<$Res>
    extends _$NotificationStateCopyWithImpl<$Res, _$NotificationInitialImpl>
    implements _$$NotificationInitialImplCopyWith<$Res> {
  __$$NotificationInitialImplCopyWithImpl(
    _$NotificationInitialImpl _value,
    $Res Function(_$NotificationInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationInitialImpl implements NotificationInitial {
  const _$NotificationInitialImpl();

  @override
  String toString() {
    return 'NotificationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ActivityItem> items) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ActivityItem> items)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ActivityItem> items)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationInitial value) initial,
    required TResult Function(NotificationLoading value) loading,
    required TResult Function(NotificationLoaded value) loaded,
    required TResult Function(NotificationFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationInitial value)? initial,
    TResult? Function(NotificationLoading value)? loading,
    TResult? Function(NotificationLoaded value)? loaded,
    TResult? Function(NotificationFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationInitial value)? initial,
    TResult Function(NotificationLoading value)? loading,
    TResult Function(NotificationLoaded value)? loaded,
    TResult Function(NotificationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class NotificationInitial implements NotificationState {
  const factory NotificationInitial() = _$NotificationInitialImpl;
}

/// @nodoc
abstract class _$$NotificationLoadingImplCopyWith<$Res> {
  factory _$$NotificationLoadingImplCopyWith(
    _$NotificationLoadingImpl value,
    $Res Function(_$NotificationLoadingImpl) then,
  ) = __$$NotificationLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationLoadingImplCopyWithImpl<$Res>
    extends _$NotificationStateCopyWithImpl<$Res, _$NotificationLoadingImpl>
    implements _$$NotificationLoadingImplCopyWith<$Res> {
  __$$NotificationLoadingImplCopyWithImpl(
    _$NotificationLoadingImpl _value,
    $Res Function(_$NotificationLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationLoadingImpl implements NotificationLoading {
  const _$NotificationLoadingImpl();

  @override
  String toString() {
    return 'NotificationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ActivityItem> items) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ActivityItem> items)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ActivityItem> items)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationInitial value) initial,
    required TResult Function(NotificationLoading value) loading,
    required TResult Function(NotificationLoaded value) loaded,
    required TResult Function(NotificationFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationInitial value)? initial,
    TResult? Function(NotificationLoading value)? loading,
    TResult? Function(NotificationLoaded value)? loaded,
    TResult? Function(NotificationFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationInitial value)? initial,
    TResult Function(NotificationLoading value)? loading,
    TResult Function(NotificationLoaded value)? loaded,
    TResult Function(NotificationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NotificationLoading implements NotificationState {
  const factory NotificationLoading() = _$NotificationLoadingImpl;
}

/// @nodoc
abstract class _$$NotificationLoadedImplCopyWith<$Res> {
  factory _$$NotificationLoadedImplCopyWith(
    _$NotificationLoadedImpl value,
    $Res Function(_$NotificationLoadedImpl) then,
  ) = __$$NotificationLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ActivityItem> items});
}

/// @nodoc
class __$$NotificationLoadedImplCopyWithImpl<$Res>
    extends _$NotificationStateCopyWithImpl<$Res, _$NotificationLoadedImpl>
    implements _$$NotificationLoadedImplCopyWith<$Res> {
  __$$NotificationLoadedImplCopyWithImpl(
    _$NotificationLoadedImpl _value,
    $Res Function(_$NotificationLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null}) {
    return _then(
      _$NotificationLoadedImpl(
        null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                as List<ActivityItem>,
      ),
    );
  }
}

/// @nodoc

class _$NotificationLoadedImpl implements NotificationLoaded {
  const _$NotificationLoadedImpl(final List<ActivityItem> items)
    : _items = items;

  final List<ActivityItem> _items;
  @override
  List<ActivityItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'NotificationState.loaded(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationLoadedImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationLoadedImplCopyWith<_$NotificationLoadedImpl> get copyWith =>
      __$$NotificationLoadedImplCopyWithImpl<_$NotificationLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ActivityItem> items) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loaded(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ActivityItem> items)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loaded?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ActivityItem> items)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationInitial value) initial,
    required TResult Function(NotificationLoading value) loading,
    required TResult Function(NotificationLoaded value) loaded,
    required TResult Function(NotificationFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationInitial value)? initial,
    TResult? Function(NotificationLoading value)? loading,
    TResult? Function(NotificationLoaded value)? loaded,
    TResult? Function(NotificationFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationInitial value)? initial,
    TResult Function(NotificationLoading value)? loading,
    TResult Function(NotificationLoaded value)? loaded,
    TResult Function(NotificationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class NotificationLoaded implements NotificationState {
  const factory NotificationLoaded(final List<ActivityItem> items) =
      _$NotificationLoadedImpl;

  List<ActivityItem> get items;

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationLoadedImplCopyWith<_$NotificationLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotificationFailureImplCopyWith<$Res> {
  factory _$$NotificationFailureImplCopyWith(
    _$NotificationFailureImpl value,
    $Res Function(_$NotificationFailureImpl) then,
  ) = __$$NotificationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkFailure failure});

  $NetworkFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$NotificationFailureImplCopyWithImpl<$Res>
    extends _$NotificationStateCopyWithImpl<$Res, _$NotificationFailureImpl>
    implements _$$NotificationFailureImplCopyWith<$Res> {
  __$$NotificationFailureImplCopyWithImpl(
    _$NotificationFailureImpl _value,
    $Res Function(_$NotificationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$NotificationFailureImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as NetworkFailure,
      ),
    );
  }

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkFailureCopyWith<$Res> get failure {
    return $NetworkFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$NotificationFailureImpl implements NotificationFailure {
  const _$NotificationFailureImpl(this.failure);

  @override
  final NetworkFailure failure;

  @override
  String toString() {
    return 'NotificationState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationFailureImplCopyWith<_$NotificationFailureImpl> get copyWith =>
      __$$NotificationFailureImplCopyWithImpl<_$NotificationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ActivityItem> items) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ActivityItem> items)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ActivityItem> items)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationInitial value) initial,
    required TResult Function(NotificationLoading value) loading,
    required TResult Function(NotificationLoaded value) loaded,
    required TResult Function(NotificationFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationInitial value)? initial,
    TResult? Function(NotificationLoading value)? loading,
    TResult? Function(NotificationLoaded value)? loaded,
    TResult? Function(NotificationFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationInitial value)? initial,
    TResult Function(NotificationLoading value)? loading,
    TResult Function(NotificationLoaded value)? loaded,
    TResult Function(NotificationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class NotificationFailure implements NotificationState {
  const factory NotificationFailure(final NetworkFailure failure) =
      _$NotificationFailureImpl;

  NetworkFailure get failure;

  /// Create a copy of NotificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationFailureImplCopyWith<_$NotificationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
