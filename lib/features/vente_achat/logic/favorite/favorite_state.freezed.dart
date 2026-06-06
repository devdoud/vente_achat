// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FavoriteState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStateCopyWith<$Res> {
  factory $FavoriteStateCopyWith(
    FavoriteState value,
    $Res Function(FavoriteState) then,
  ) = _$FavoriteStateCopyWithImpl<$Res, FavoriteState>;
}

/// @nodoc
class _$FavoriteStateCopyWithImpl<$Res, $Val extends FavoriteState>
    implements $FavoriteStateCopyWith<$Res> {
  _$FavoriteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FavoriteInitialImplCopyWith<$Res> {
  factory _$$FavoriteInitialImplCopyWith(
    _$FavoriteInitialImpl value,
    $Res Function(_$FavoriteInitialImpl) then,
  ) = __$$FavoriteInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoriteInitialImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteInitialImpl>
    implements _$$FavoriteInitialImplCopyWith<$Res> {
  __$$FavoriteInitialImplCopyWithImpl(
    _$FavoriteInitialImpl _value,
    $Res Function(_$FavoriteInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FavoriteInitialImpl implements FavoriteInitial {
  const _$FavoriteInitialImpl();

  @override
  String toString() {
    return 'FavoriteState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FavoriteInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
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
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class FavoriteInitial implements FavoriteState {
  const factory FavoriteInitial() = _$FavoriteInitialImpl;
}

/// @nodoc
abstract class _$$FavoriteLoadingImplCopyWith<$Res> {
  factory _$$FavoriteLoadingImplCopyWith(
    _$FavoriteLoadingImpl value,
    $Res Function(_$FavoriteLoadingImpl) then,
  ) = __$$FavoriteLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoriteLoadingImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteLoadingImpl>
    implements _$$FavoriteLoadingImplCopyWith<$Res> {
  __$$FavoriteLoadingImplCopyWithImpl(
    _$FavoriteLoadingImpl _value,
    $Res Function(_$FavoriteLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FavoriteLoadingImpl implements FavoriteLoading {
  const _$FavoriteLoadingImpl();

  @override
  String toString() {
    return 'FavoriteState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FavoriteLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
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
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FavoriteLoading implements FavoriteState {
  const factory FavoriteLoading() = _$FavoriteLoadingImpl;
}

/// @nodoc
abstract class _$$FavoriteLoadedImplCopyWith<$Res> {
  factory _$$FavoriteLoadedImplCopyWith(
    _$FavoriteLoadedImpl value,
    $Res Function(_$FavoriteLoadedImpl) then,
  ) = __$$FavoriteLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Product> products});
}

/// @nodoc
class __$$FavoriteLoadedImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteLoadedImpl>
    implements _$$FavoriteLoadedImplCopyWith<$Res> {
  __$$FavoriteLoadedImplCopyWithImpl(
    _$FavoriteLoadedImpl _value,
    $Res Function(_$FavoriteLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? products = null}) {
    return _then(
      _$FavoriteLoadedImpl(
        null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                as List<Product>,
      ),
    );
  }
}

/// @nodoc

class _$FavoriteLoadedImpl implements FavoriteLoaded {
  const _$FavoriteLoadedImpl(final List<Product> products)
    : _products = products;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'FavoriteState.loaded(products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteLoadedImpl &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteLoadedImplCopyWith<_$FavoriteLoadedImpl> get copyWith =>
      __$$FavoriteLoadedImplCopyWithImpl<_$FavoriteLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loaded(products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loaded?.call(products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FavoriteLoaded implements FavoriteState {
  const factory FavoriteLoaded(final List<Product> products) =
      _$FavoriteLoadedImpl;

  List<Product> get products;

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteLoadedImplCopyWith<_$FavoriteLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FavoriteFailureImplCopyWith<$Res> {
  factory _$$FavoriteFailureImplCopyWith(
    _$FavoriteFailureImpl value,
    $Res Function(_$FavoriteFailureImpl) then,
  ) = __$$FavoriteFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkFailure failure});

  $NetworkFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$FavoriteFailureImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteFailureImpl>
    implements _$$FavoriteFailureImplCopyWith<$Res> {
  __$$FavoriteFailureImplCopyWithImpl(
    _$FavoriteFailureImpl _value,
    $Res Function(_$FavoriteFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$FavoriteFailureImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as NetworkFailure,
      ),
    );
  }

  /// Create a copy of FavoriteState
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

class _$FavoriteFailureImpl implements FavoriteFailure {
  const _$FavoriteFailureImpl(this.failure);

  @override
  final NetworkFailure failure;

  @override
  String toString() {
    return 'FavoriteState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteFailureImplCopyWith<_$FavoriteFailureImpl> get copyWith =>
      __$$FavoriteFailureImplCopyWithImpl<_$FavoriteFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Product> products) loaded,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products)? loaded,
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
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FavoriteFailure implements FavoriteState {
  const factory FavoriteFailure(final NetworkFailure failure) =
      _$FavoriteFailureImpl;

  NetworkFailure get failure;

  /// Create a copy of FavoriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteFailureImplCopyWith<_$FavoriteFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
