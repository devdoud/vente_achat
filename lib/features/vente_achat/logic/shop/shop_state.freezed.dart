// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ShopState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String shopUuid) created,
    required TResult Function() updated,
    required TResult Function(NetworkFailure failure) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String shopUuid)? created,
    TResult? Function()? updated,
    TResult? Function(NetworkFailure failure)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String shopUuid)? created,
    TResult Function()? updated,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShopInitial value) initial,
    required TResult Function(ShopLoading value) loading,
    required TResult Function(ShopCreated value) created,
    required TResult Function(ShopUpdated value) updated,
    required TResult Function(ShopFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShopInitial value)? initial,
    TResult? Function(ShopLoading value)? loading,
    TResult? Function(ShopCreated value)? created,
    TResult? Function(ShopUpdated value)? updated,
    TResult? Function(ShopFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShopInitial value)? initial,
    TResult Function(ShopLoading value)? loading,
    TResult Function(ShopCreated value)? created,
    TResult Function(ShopUpdated value)? updated,
    TResult Function(ShopFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopStateCopyWith<$Res> {
  factory $ShopStateCopyWith(ShopState value, $Res Function(ShopState) then) =
      _$ShopStateCopyWithImpl<$Res, ShopState>;
}

/// @nodoc
class _$ShopStateCopyWithImpl<$Res, $Val extends ShopState>
    implements $ShopStateCopyWith<$Res> {
  _$ShopStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ShopInitialImplCopyWith<$Res> {
  factory _$$ShopInitialImplCopyWith(
    _$ShopInitialImpl value,
    $Res Function(_$ShopInitialImpl) then,
  ) = __$$ShopInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShopInitialImplCopyWithImpl<$Res>
    extends _$ShopStateCopyWithImpl<$Res, _$ShopInitialImpl>
    implements _$$ShopInitialImplCopyWith<$Res> {
  __$$ShopInitialImplCopyWithImpl(
    _$ShopInitialImpl _value,
    $Res Function(_$ShopInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShopInitialImpl implements ShopInitial {
  const _$ShopInitialImpl();

  @override
  String toString() {
    return 'ShopState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShopInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String shopUuid) created,
    required TResult Function() updated,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String shopUuid)? created,
    TResult? Function()? updated,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String shopUuid)? created,
    TResult Function()? updated,
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
    required TResult Function(ShopInitial value) initial,
    required TResult Function(ShopLoading value) loading,
    required TResult Function(ShopCreated value) created,
    required TResult Function(ShopUpdated value) updated,
    required TResult Function(ShopFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShopInitial value)? initial,
    TResult? Function(ShopLoading value)? loading,
    TResult? Function(ShopCreated value)? created,
    TResult? Function(ShopUpdated value)? updated,
    TResult? Function(ShopFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShopInitial value)? initial,
    TResult Function(ShopLoading value)? loading,
    TResult Function(ShopCreated value)? created,
    TResult Function(ShopUpdated value)? updated,
    TResult Function(ShopFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ShopInitial implements ShopState {
  const factory ShopInitial() = _$ShopInitialImpl;
}

/// @nodoc
abstract class _$$ShopLoadingImplCopyWith<$Res> {
  factory _$$ShopLoadingImplCopyWith(
    _$ShopLoadingImpl value,
    $Res Function(_$ShopLoadingImpl) then,
  ) = __$$ShopLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShopLoadingImplCopyWithImpl<$Res>
    extends _$ShopStateCopyWithImpl<$Res, _$ShopLoadingImpl>
    implements _$$ShopLoadingImplCopyWith<$Res> {
  __$$ShopLoadingImplCopyWithImpl(
    _$ShopLoadingImpl _value,
    $Res Function(_$ShopLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShopLoadingImpl implements ShopLoading {
  const _$ShopLoadingImpl();

  @override
  String toString() {
    return 'ShopState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShopLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String shopUuid) created,
    required TResult Function() updated,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String shopUuid)? created,
    TResult? Function()? updated,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String shopUuid)? created,
    TResult Function()? updated,
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
    required TResult Function(ShopInitial value) initial,
    required TResult Function(ShopLoading value) loading,
    required TResult Function(ShopCreated value) created,
    required TResult Function(ShopUpdated value) updated,
    required TResult Function(ShopFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShopInitial value)? initial,
    TResult? Function(ShopLoading value)? loading,
    TResult? Function(ShopCreated value)? created,
    TResult? Function(ShopUpdated value)? updated,
    TResult? Function(ShopFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShopInitial value)? initial,
    TResult Function(ShopLoading value)? loading,
    TResult Function(ShopCreated value)? created,
    TResult Function(ShopUpdated value)? updated,
    TResult Function(ShopFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ShopLoading implements ShopState {
  const factory ShopLoading() = _$ShopLoadingImpl;
}

/// @nodoc
abstract class _$$ShopCreatedImplCopyWith<$Res> {
  factory _$$ShopCreatedImplCopyWith(
    _$ShopCreatedImpl value,
    $Res Function(_$ShopCreatedImpl) then,
  ) = __$$ShopCreatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String shopUuid});
}

/// @nodoc
class __$$ShopCreatedImplCopyWithImpl<$Res>
    extends _$ShopStateCopyWithImpl<$Res, _$ShopCreatedImpl>
    implements _$$ShopCreatedImplCopyWith<$Res> {
  __$$ShopCreatedImplCopyWithImpl(
    _$ShopCreatedImpl _value,
    $Res Function(_$ShopCreatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? shopUuid = null}) {
    return _then(
      _$ShopCreatedImpl(
        shopUuid:
            null == shopUuid
                ? _value.shopUuid
                : shopUuid // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ShopCreatedImpl implements ShopCreated {
  const _$ShopCreatedImpl({required this.shopUuid});

  @override
  final String shopUuid;

  @override
  String toString() {
    return 'ShopState.created(shopUuid: $shopUuid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopCreatedImpl &&
            (identical(other.shopUuid, shopUuid) ||
                other.shopUuid == shopUuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shopUuid);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopCreatedImplCopyWith<_$ShopCreatedImpl> get copyWith =>
      __$$ShopCreatedImplCopyWithImpl<_$ShopCreatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String shopUuid) created,
    required TResult Function() updated,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return created(shopUuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String shopUuid)? created,
    TResult? Function()? updated,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return created?.call(shopUuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String shopUuid)? created,
    TResult Function()? updated,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(shopUuid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShopInitial value) initial,
    required TResult Function(ShopLoading value) loading,
    required TResult Function(ShopCreated value) created,
    required TResult Function(ShopUpdated value) updated,
    required TResult Function(ShopFailure value) failure,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShopInitial value)? initial,
    TResult? Function(ShopLoading value)? loading,
    TResult? Function(ShopCreated value)? created,
    TResult? Function(ShopUpdated value)? updated,
    TResult? Function(ShopFailure value)? failure,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShopInitial value)? initial,
    TResult Function(ShopLoading value)? loading,
    TResult Function(ShopCreated value)? created,
    TResult Function(ShopUpdated value)? updated,
    TResult Function(ShopFailure value)? failure,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }
}

abstract class ShopCreated implements ShopState {
  const factory ShopCreated({required final String shopUuid}) =
      _$ShopCreatedImpl;

  String get shopUuid;

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopCreatedImplCopyWith<_$ShopCreatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShopUpdatedImplCopyWith<$Res> {
  factory _$$ShopUpdatedImplCopyWith(
    _$ShopUpdatedImpl value,
    $Res Function(_$ShopUpdatedImpl) then,
  ) = __$$ShopUpdatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShopUpdatedImplCopyWithImpl<$Res>
    extends _$ShopStateCopyWithImpl<$Res, _$ShopUpdatedImpl>
    implements _$$ShopUpdatedImplCopyWith<$Res> {
  __$$ShopUpdatedImplCopyWithImpl(
    _$ShopUpdatedImpl _value,
    $Res Function(_$ShopUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShopUpdatedImpl implements ShopUpdated {
  const _$ShopUpdatedImpl();

  @override
  String toString() {
    return 'ShopState.updated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShopUpdatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String shopUuid) created,
    required TResult Function() updated,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return updated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String shopUuid)? created,
    TResult? Function()? updated,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return updated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String shopUuid)? created,
    TResult Function()? updated,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShopInitial value) initial,
    required TResult Function(ShopLoading value) loading,
    required TResult Function(ShopCreated value) created,
    required TResult Function(ShopUpdated value) updated,
    required TResult Function(ShopFailure value) failure,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShopInitial value)? initial,
    TResult? Function(ShopLoading value)? loading,
    TResult? Function(ShopCreated value)? created,
    TResult? Function(ShopUpdated value)? updated,
    TResult? Function(ShopFailure value)? failure,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShopInitial value)? initial,
    TResult Function(ShopLoading value)? loading,
    TResult Function(ShopCreated value)? created,
    TResult Function(ShopUpdated value)? updated,
    TResult Function(ShopFailure value)? failure,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class ShopUpdated implements ShopState {
  const factory ShopUpdated() = _$ShopUpdatedImpl;
}

/// @nodoc
abstract class _$$ShopFailureImplCopyWith<$Res> {
  factory _$$ShopFailureImplCopyWith(
    _$ShopFailureImpl value,
    $Res Function(_$ShopFailureImpl) then,
  ) = __$$ShopFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkFailure failure});

  $NetworkFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$ShopFailureImplCopyWithImpl<$Res>
    extends _$ShopStateCopyWithImpl<$Res, _$ShopFailureImpl>
    implements _$$ShopFailureImplCopyWith<$Res> {
  __$$ShopFailureImplCopyWithImpl(
    _$ShopFailureImpl _value,
    $Res Function(_$ShopFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$ShopFailureImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as NetworkFailure,
      ),
    );
  }

  /// Create a copy of ShopState
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

class _$ShopFailureImpl implements ShopFailure {
  const _$ShopFailureImpl(this.failure);

  @override
  final NetworkFailure failure;

  @override
  String toString() {
    return 'ShopState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopFailureImplCopyWith<_$ShopFailureImpl> get copyWith =>
      __$$ShopFailureImplCopyWithImpl<_$ShopFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String shopUuid) created,
    required TResult Function() updated,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String shopUuid)? created,
    TResult? Function()? updated,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String shopUuid)? created,
    TResult Function()? updated,
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
    required TResult Function(ShopInitial value) initial,
    required TResult Function(ShopLoading value) loading,
    required TResult Function(ShopCreated value) created,
    required TResult Function(ShopUpdated value) updated,
    required TResult Function(ShopFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShopInitial value)? initial,
    TResult? Function(ShopLoading value)? loading,
    TResult? Function(ShopCreated value)? created,
    TResult? Function(ShopUpdated value)? updated,
    TResult? Function(ShopFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShopInitial value)? initial,
    TResult Function(ShopLoading value)? loading,
    TResult Function(ShopCreated value)? created,
    TResult Function(ShopUpdated value)? updated,
    TResult Function(ShopFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ShopFailure implements ShopState {
  const factory ShopFailure(final NetworkFailure failure) = _$ShopFailureImpl;

  NetworkFailure get failure;

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopFailureImplCopyWith<_$ShopFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
