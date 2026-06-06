// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      int currentPage,
      bool hasMore,
    )
    loaded,
    required TResult Function(Product product) detail,
    required TResult Function(NetworkFailure failure) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult? Function(Product product)? detail,
    TResult? Function(NetworkFailure failure)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult Function(Product product)? detail,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductInitial value) initial,
    required TResult Function(ProductLoading value) loading,
    required TResult Function(ProductLoaded value) loaded,
    required TResult Function(ProductDetail value) detail,
    required TResult Function(ProductFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductInitial value)? initial,
    TResult? Function(ProductLoading value)? loading,
    TResult? Function(ProductLoaded value)? loaded,
    TResult? Function(ProductDetail value)? detail,
    TResult? Function(ProductFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductInitial value)? initial,
    TResult Function(ProductLoading value)? loading,
    TResult Function(ProductLoaded value)? loaded,
    TResult Function(ProductDetail value)? detail,
    TResult Function(ProductFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductStateCopyWith<$Res> {
  factory $ProductStateCopyWith(
    ProductState value,
    $Res Function(ProductState) then,
  ) = _$ProductStateCopyWithImpl<$Res, ProductState>;
}

/// @nodoc
class _$ProductStateCopyWithImpl<$Res, $Val extends ProductState>
    implements $ProductStateCopyWith<$Res> {
  _$ProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProductInitialImplCopyWith<$Res> {
  factory _$$ProductInitialImplCopyWith(
    _$ProductInitialImpl value,
    $Res Function(_$ProductInitialImpl) then,
  ) = __$$ProductInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProductInitialImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$ProductInitialImpl>
    implements _$$ProductInitialImplCopyWith<$Res> {
  __$$ProductInitialImplCopyWithImpl(
    _$ProductInitialImpl _value,
    $Res Function(_$ProductInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProductInitialImpl implements ProductInitial {
  const _$ProductInitialImpl();

  @override
  String toString() {
    return 'ProductState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProductInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      int currentPage,
      bool hasMore,
    )
    loaded,
    required TResult Function(Product product) detail,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult? Function(Product product)? detail,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult Function(Product product)? detail,
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
    required TResult Function(ProductInitial value) initial,
    required TResult Function(ProductLoading value) loading,
    required TResult Function(ProductLoaded value) loaded,
    required TResult Function(ProductDetail value) detail,
    required TResult Function(ProductFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductInitial value)? initial,
    TResult? Function(ProductLoading value)? loading,
    TResult? Function(ProductLoaded value)? loaded,
    TResult? Function(ProductDetail value)? detail,
    TResult? Function(ProductFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductInitial value)? initial,
    TResult Function(ProductLoading value)? loading,
    TResult Function(ProductLoaded value)? loaded,
    TResult Function(ProductDetail value)? detail,
    TResult Function(ProductFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ProductInitial implements ProductState {
  const factory ProductInitial() = _$ProductInitialImpl;
}

/// @nodoc
abstract class _$$ProductLoadingImplCopyWith<$Res> {
  factory _$$ProductLoadingImplCopyWith(
    _$ProductLoadingImpl value,
    $Res Function(_$ProductLoadingImpl) then,
  ) = __$$ProductLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProductLoadingImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$ProductLoadingImpl>
    implements _$$ProductLoadingImplCopyWith<$Res> {
  __$$ProductLoadingImplCopyWithImpl(
    _$ProductLoadingImpl _value,
    $Res Function(_$ProductLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProductLoadingImpl implements ProductLoading {
  const _$ProductLoadingImpl();

  @override
  String toString() {
    return 'ProductState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProductLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      int currentPage,
      bool hasMore,
    )
    loaded,
    required TResult Function(Product product) detail,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult? Function(Product product)? detail,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult Function(Product product)? detail,
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
    required TResult Function(ProductInitial value) initial,
    required TResult Function(ProductLoading value) loading,
    required TResult Function(ProductLoaded value) loaded,
    required TResult Function(ProductDetail value) detail,
    required TResult Function(ProductFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductInitial value)? initial,
    TResult? Function(ProductLoading value)? loading,
    TResult? Function(ProductLoaded value)? loaded,
    TResult? Function(ProductDetail value)? detail,
    TResult? Function(ProductFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductInitial value)? initial,
    TResult Function(ProductLoading value)? loading,
    TResult Function(ProductLoaded value)? loaded,
    TResult Function(ProductDetail value)? detail,
    TResult Function(ProductFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ProductLoading implements ProductState {
  const factory ProductLoading() = _$ProductLoadingImpl;
}

/// @nodoc
abstract class _$$ProductLoadedImplCopyWith<$Res> {
  factory _$$ProductLoadedImplCopyWith(
    _$ProductLoadedImpl value,
    $Res Function(_$ProductLoadedImpl) then,
  ) = __$$ProductLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Product> products, int currentPage, bool hasMore});
}

/// @nodoc
class __$$ProductLoadedImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$ProductLoadedImpl>
    implements _$$ProductLoadedImplCopyWith<$Res> {
  __$$ProductLoadedImplCopyWithImpl(
    _$ProductLoadedImpl _value,
    $Res Function(_$ProductLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(
      _$ProductLoadedImpl(
        products:
            null == products
                ? _value._products
                : products // ignore: cast_nullable_to_non_nullable
                    as List<Product>,
        currentPage:
            null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int,
        hasMore:
            null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$ProductLoadedImpl implements ProductLoaded {
  const _$ProductLoadedImpl({
    required final List<Product> products,
    required this.currentPage,
    required this.hasMore,
  }) : _products = products;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final int currentPage;
  @override
  final bool hasMore;

  @override
  String toString() {
    return 'ProductState.loaded(products: $products, currentPage: $currentPage, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductLoadedImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_products),
    currentPage,
    hasMore,
  );

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductLoadedImplCopyWith<_$ProductLoadedImpl> get copyWith =>
      __$$ProductLoadedImplCopyWithImpl<_$ProductLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      int currentPage,
      bool hasMore,
    )
    loaded,
    required TResult Function(Product product) detail,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loaded(products, currentPage, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult? Function(Product product)? detail,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loaded?.call(products, currentPage, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult Function(Product product)? detail,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(products, currentPage, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductInitial value) initial,
    required TResult Function(ProductLoading value) loading,
    required TResult Function(ProductLoaded value) loaded,
    required TResult Function(ProductDetail value) detail,
    required TResult Function(ProductFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductInitial value)? initial,
    TResult? Function(ProductLoading value)? loading,
    TResult? Function(ProductLoaded value)? loaded,
    TResult? Function(ProductDetail value)? detail,
    TResult? Function(ProductFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductInitial value)? initial,
    TResult Function(ProductLoading value)? loading,
    TResult Function(ProductLoaded value)? loaded,
    TResult Function(ProductDetail value)? detail,
    TResult Function(ProductFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ProductLoaded implements ProductState {
  const factory ProductLoaded({
    required final List<Product> products,
    required final int currentPage,
    required final bool hasMore,
  }) = _$ProductLoadedImpl;

  List<Product> get products;
  int get currentPage;
  bool get hasMore;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductLoadedImplCopyWith<_$ProductLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProductDetailImplCopyWith<$Res> {
  factory _$$ProductDetailImplCopyWith(
    _$ProductDetailImpl value,
    $Res Function(_$ProductDetailImpl) then,
  ) = __$$ProductDetailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$ProductDetailImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$ProductDetailImpl>
    implements _$$ProductDetailImplCopyWith<$Res> {
  __$$ProductDetailImplCopyWithImpl(
    _$ProductDetailImpl _value,
    $Res Function(_$ProductDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? product = null}) {
    return _then(
      _$ProductDetailImpl(
        null == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                as Product,
      ),
    );
  }

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc

class _$ProductDetailImpl implements ProductDetail {
  const _$ProductDetailImpl(this.product);

  @override
  final Product product;

  @override
  String toString() {
    return 'ProductState.detail(product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailImpl &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailImplCopyWith<_$ProductDetailImpl> get copyWith =>
      __$$ProductDetailImplCopyWithImpl<_$ProductDetailImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      int currentPage,
      bool hasMore,
    )
    loaded,
    required TResult Function(Product product) detail,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return detail(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult? Function(Product product)? detail,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return detail?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult Function(Product product)? detail,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (detail != null) {
      return detail(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductInitial value) initial,
    required TResult Function(ProductLoading value) loading,
    required TResult Function(ProductLoaded value) loaded,
    required TResult Function(ProductDetail value) detail,
    required TResult Function(ProductFailure value) failure,
  }) {
    return detail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductInitial value)? initial,
    TResult? Function(ProductLoading value)? loading,
    TResult? Function(ProductLoaded value)? loaded,
    TResult? Function(ProductDetail value)? detail,
    TResult? Function(ProductFailure value)? failure,
  }) {
    return detail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductInitial value)? initial,
    TResult Function(ProductLoading value)? loading,
    TResult Function(ProductLoaded value)? loaded,
    TResult Function(ProductDetail value)? detail,
    TResult Function(ProductFailure value)? failure,
    required TResult orElse(),
  }) {
    if (detail != null) {
      return detail(this);
    }
    return orElse();
  }
}

abstract class ProductDetail implements ProductState {
  const factory ProductDetail(final Product product) = _$ProductDetailImpl;

  Product get product;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductDetailImplCopyWith<_$ProductDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProductFailureImplCopyWith<$Res> {
  factory _$$ProductFailureImplCopyWith(
    _$ProductFailureImpl value,
    $Res Function(_$ProductFailureImpl) then,
  ) = __$$ProductFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkFailure failure});

  $NetworkFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$ProductFailureImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$ProductFailureImpl>
    implements _$$ProductFailureImplCopyWith<$Res> {
  __$$ProductFailureImplCopyWithImpl(
    _$ProductFailureImpl _value,
    $Res Function(_$ProductFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$ProductFailureImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as NetworkFailure,
      ),
    );
  }

  /// Create a copy of ProductState
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

class _$ProductFailureImpl implements ProductFailure {
  const _$ProductFailureImpl(this.failure);

  @override
  final NetworkFailure failure;

  @override
  String toString() {
    return 'ProductState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductFailureImplCopyWith<_$ProductFailureImpl> get copyWith =>
      __$$ProductFailureImplCopyWithImpl<_$ProductFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      int currentPage,
      bool hasMore,
    )
    loaded,
    required TResult Function(Product product) detail,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult? Function(Product product)? detail,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Product> products, int currentPage, bool hasMore)?
    loaded,
    TResult Function(Product product)? detail,
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
    required TResult Function(ProductInitial value) initial,
    required TResult Function(ProductLoading value) loading,
    required TResult Function(ProductLoaded value) loaded,
    required TResult Function(ProductDetail value) detail,
    required TResult Function(ProductFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductInitial value)? initial,
    TResult? Function(ProductLoading value)? loading,
    TResult? Function(ProductLoaded value)? loaded,
    TResult? Function(ProductDetail value)? detail,
    TResult? Function(ProductFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductInitial value)? initial,
    TResult Function(ProductLoading value)? loading,
    TResult Function(ProductLoaded value)? loaded,
    TResult Function(ProductDetail value)? detail,
    TResult Function(ProductFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ProductFailure implements ProductState {
  const factory ProductFailure(final NetworkFailure failure) =
      _$ProductFailureImpl;

  NetworkFailure get failure;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductFailureImplCopyWith<_$ProductFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
