// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Order> orders, bool hasMore, int currentPage)
    loaded,
    required TResult Function(List<Order> orders) checkoutSuccess,
    required TResult Function(Order order) deliverSuccess,
    required TResult Function(NetworkFailure failure) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Order> orders, bool hasMore, int currentPage)?
    loaded,
    TResult? Function(List<Order> orders)? checkoutSuccess,
    TResult? Function(Order order)? deliverSuccess,
    TResult? Function(NetworkFailure failure)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Order> orders, bool hasMore, int currentPage)? loaded,
    TResult Function(List<Order> orders)? checkoutSuccess,
    TResult Function(Order order)? deliverSuccess,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderInitial value) initial,
    required TResult Function(OrderLoading value) loading,
    required TResult Function(OrderLoaded value) loaded,
    required TResult Function(OrderCheckoutSuccess value) checkoutSuccess,
    required TResult Function(OrderDeliverSuccess value) deliverSuccess,
    required TResult Function(OrderFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderInitial value)? initial,
    TResult? Function(OrderLoading value)? loading,
    TResult? Function(OrderLoaded value)? loaded,
    TResult? Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult? Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult? Function(OrderFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderInitial value)? initial,
    TResult Function(OrderLoading value)? loading,
    TResult Function(OrderLoaded value)? loaded,
    TResult Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult Function(OrderFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStateCopyWith<$Res> {
  factory $OrderStateCopyWith(
    OrderState value,
    $Res Function(OrderState) then,
  ) = _$OrderStateCopyWithImpl<$Res, OrderState>;
}

/// @nodoc
class _$OrderStateCopyWithImpl<$Res, $Val extends OrderState>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OrderInitialImplCopyWith<$Res> {
  factory _$$OrderInitialImplCopyWith(
    _$OrderInitialImpl value,
    $Res Function(_$OrderInitialImpl) then,
  ) = __$$OrderInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrderInitialImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderInitialImpl>
    implements _$$OrderInitialImplCopyWith<$Res> {
  __$$OrderInitialImplCopyWithImpl(
    _$OrderInitialImpl _value,
    $Res Function(_$OrderInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OrderInitialImpl implements OrderInitial {
  const _$OrderInitialImpl();

  @override
  String toString() {
    return 'OrderState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OrderInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Order> orders, bool hasMore, int currentPage)
    loaded,
    required TResult Function(List<Order> orders) checkoutSuccess,
    required TResult Function(Order order) deliverSuccess,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Order> orders, bool hasMore, int currentPage)?
    loaded,
    TResult? Function(List<Order> orders)? checkoutSuccess,
    TResult? Function(Order order)? deliverSuccess,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Order> orders, bool hasMore, int currentPage)? loaded,
    TResult Function(List<Order> orders)? checkoutSuccess,
    TResult Function(Order order)? deliverSuccess,
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
    required TResult Function(OrderInitial value) initial,
    required TResult Function(OrderLoading value) loading,
    required TResult Function(OrderLoaded value) loaded,
    required TResult Function(OrderCheckoutSuccess value) checkoutSuccess,
    required TResult Function(OrderDeliverSuccess value) deliverSuccess,
    required TResult Function(OrderFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderInitial value)? initial,
    TResult? Function(OrderLoading value)? loading,
    TResult? Function(OrderLoaded value)? loaded,
    TResult? Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult? Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult? Function(OrderFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderInitial value)? initial,
    TResult Function(OrderLoading value)? loading,
    TResult Function(OrderLoaded value)? loaded,
    TResult Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult Function(OrderFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class OrderInitial implements OrderState {
  const factory OrderInitial() = _$OrderInitialImpl;
}

/// @nodoc
abstract class _$$OrderLoadingImplCopyWith<$Res> {
  factory _$$OrderLoadingImplCopyWith(
    _$OrderLoadingImpl value,
    $Res Function(_$OrderLoadingImpl) then,
  ) = __$$OrderLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrderLoadingImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderLoadingImpl>
    implements _$$OrderLoadingImplCopyWith<$Res> {
  __$$OrderLoadingImplCopyWithImpl(
    _$OrderLoadingImpl _value,
    $Res Function(_$OrderLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OrderLoadingImpl implements OrderLoading {
  const _$OrderLoadingImpl();

  @override
  String toString() {
    return 'OrderState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OrderLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Order> orders, bool hasMore, int currentPage)
    loaded,
    required TResult Function(List<Order> orders) checkoutSuccess,
    required TResult Function(Order order) deliverSuccess,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Order> orders, bool hasMore, int currentPage)?
    loaded,
    TResult? Function(List<Order> orders)? checkoutSuccess,
    TResult? Function(Order order)? deliverSuccess,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Order> orders, bool hasMore, int currentPage)? loaded,
    TResult Function(List<Order> orders)? checkoutSuccess,
    TResult Function(Order order)? deliverSuccess,
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
    required TResult Function(OrderInitial value) initial,
    required TResult Function(OrderLoading value) loading,
    required TResult Function(OrderLoaded value) loaded,
    required TResult Function(OrderCheckoutSuccess value) checkoutSuccess,
    required TResult Function(OrderDeliverSuccess value) deliverSuccess,
    required TResult Function(OrderFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderInitial value)? initial,
    TResult? Function(OrderLoading value)? loading,
    TResult? Function(OrderLoaded value)? loaded,
    TResult? Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult? Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult? Function(OrderFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderInitial value)? initial,
    TResult Function(OrderLoading value)? loading,
    TResult Function(OrderLoaded value)? loaded,
    TResult Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult Function(OrderFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OrderLoading implements OrderState {
  const factory OrderLoading() = _$OrderLoadingImpl;
}

/// @nodoc
abstract class _$$OrderLoadedImplCopyWith<$Res> {
  factory _$$OrderLoadedImplCopyWith(
    _$OrderLoadedImpl value,
    $Res Function(_$OrderLoadedImpl) then,
  ) = __$$OrderLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Order> orders, bool hasMore, int currentPage});
}

/// @nodoc
class __$$OrderLoadedImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderLoadedImpl>
    implements _$$OrderLoadedImplCopyWith<$Res> {
  __$$OrderLoadedImplCopyWithImpl(
    _$OrderLoadedImpl _value,
    $Res Function(_$OrderLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? hasMore = null,
    Object? currentPage = null,
  }) {
    return _then(
      _$OrderLoadedImpl(
        orders:
            null == orders
                ? _value._orders
                : orders // ignore: cast_nullable_to_non_nullable
                    as List<Order>,
        hasMore:
            null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                    as bool,
        currentPage:
            null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$OrderLoadedImpl implements OrderLoaded {
  const _$OrderLoadedImpl({
    required final List<Order> orders,
    required this.hasMore,
    required this.currentPage,
  }) : _orders = orders;

  final List<Order> _orders;
  @override
  List<Order> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  final bool hasMore;
  @override
  final int currentPage;

  @override
  String toString() {
    return 'OrderState.loaded(orders: $orders, hasMore: $hasMore, currentPage: $currentPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderLoadedImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_orders),
    hasMore,
    currentPage,
  );

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderLoadedImplCopyWith<_$OrderLoadedImpl> get copyWith =>
      __$$OrderLoadedImplCopyWithImpl<_$OrderLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Order> orders, bool hasMore, int currentPage)
    loaded,
    required TResult Function(List<Order> orders) checkoutSuccess,
    required TResult Function(Order order) deliverSuccess,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loaded(orders, hasMore, currentPage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Order> orders, bool hasMore, int currentPage)?
    loaded,
    TResult? Function(List<Order> orders)? checkoutSuccess,
    TResult? Function(Order order)? deliverSuccess,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loaded?.call(orders, hasMore, currentPage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Order> orders, bool hasMore, int currentPage)? loaded,
    TResult Function(List<Order> orders)? checkoutSuccess,
    TResult Function(Order order)? deliverSuccess,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(orders, hasMore, currentPage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderInitial value) initial,
    required TResult Function(OrderLoading value) loading,
    required TResult Function(OrderLoaded value) loaded,
    required TResult Function(OrderCheckoutSuccess value) checkoutSuccess,
    required TResult Function(OrderDeliverSuccess value) deliverSuccess,
    required TResult Function(OrderFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderInitial value)? initial,
    TResult? Function(OrderLoading value)? loading,
    TResult? Function(OrderLoaded value)? loaded,
    TResult? Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult? Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult? Function(OrderFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderInitial value)? initial,
    TResult Function(OrderLoading value)? loading,
    TResult Function(OrderLoaded value)? loaded,
    TResult Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult Function(OrderFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OrderLoaded implements OrderState {
  const factory OrderLoaded({
    required final List<Order> orders,
    required final bool hasMore,
    required final int currentPage,
  }) = _$OrderLoadedImpl;

  List<Order> get orders;
  bool get hasMore;
  int get currentPage;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderLoadedImplCopyWith<_$OrderLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OrderCheckoutSuccessImplCopyWith<$Res> {
  factory _$$OrderCheckoutSuccessImplCopyWith(
    _$OrderCheckoutSuccessImpl value,
    $Res Function(_$OrderCheckoutSuccessImpl) then,
  ) = __$$OrderCheckoutSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Order> orders});
}

/// @nodoc
class __$$OrderCheckoutSuccessImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderCheckoutSuccessImpl>
    implements _$$OrderCheckoutSuccessImplCopyWith<$Res> {
  __$$OrderCheckoutSuccessImplCopyWithImpl(
    _$OrderCheckoutSuccessImpl _value,
    $Res Function(_$OrderCheckoutSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orders = null}) {
    return _then(
      _$OrderCheckoutSuccessImpl(
        null == orders
            ? _value._orders
            : orders // ignore: cast_nullable_to_non_nullable
                as List<Order>,
      ),
    );
  }
}

/// @nodoc

class _$OrderCheckoutSuccessImpl implements OrderCheckoutSuccess {
  const _$OrderCheckoutSuccessImpl(final List<Order> orders) : _orders = orders;

  final List<Order> _orders;
  @override
  List<Order> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'OrderState.checkoutSuccess(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCheckoutSuccessImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderCheckoutSuccessImplCopyWith<_$OrderCheckoutSuccessImpl>
  get copyWith =>
      __$$OrderCheckoutSuccessImplCopyWithImpl<_$OrderCheckoutSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Order> orders, bool hasMore, int currentPage)
    loaded,
    required TResult Function(List<Order> orders) checkoutSuccess,
    required TResult Function(Order order) deliverSuccess,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return checkoutSuccess(orders);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Order> orders, bool hasMore, int currentPage)?
    loaded,
    TResult? Function(List<Order> orders)? checkoutSuccess,
    TResult? Function(Order order)? deliverSuccess,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return checkoutSuccess?.call(orders);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Order> orders, bool hasMore, int currentPage)? loaded,
    TResult Function(List<Order> orders)? checkoutSuccess,
    TResult Function(Order order)? deliverSuccess,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (checkoutSuccess != null) {
      return checkoutSuccess(orders);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderInitial value) initial,
    required TResult Function(OrderLoading value) loading,
    required TResult Function(OrderLoaded value) loaded,
    required TResult Function(OrderCheckoutSuccess value) checkoutSuccess,
    required TResult Function(OrderDeliverSuccess value) deliverSuccess,
    required TResult Function(OrderFailure value) failure,
  }) {
    return checkoutSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderInitial value)? initial,
    TResult? Function(OrderLoading value)? loading,
    TResult? Function(OrderLoaded value)? loaded,
    TResult? Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult? Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult? Function(OrderFailure value)? failure,
  }) {
    return checkoutSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderInitial value)? initial,
    TResult Function(OrderLoading value)? loading,
    TResult Function(OrderLoaded value)? loaded,
    TResult Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult Function(OrderFailure value)? failure,
    required TResult orElse(),
  }) {
    if (checkoutSuccess != null) {
      return checkoutSuccess(this);
    }
    return orElse();
  }
}

abstract class OrderCheckoutSuccess implements OrderState {
  const factory OrderCheckoutSuccess(final List<Order> orders) =
      _$OrderCheckoutSuccessImpl;

  List<Order> get orders;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderCheckoutSuccessImplCopyWith<_$OrderCheckoutSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OrderDeliverSuccessImplCopyWith<$Res> {
  factory _$$OrderDeliverSuccessImplCopyWith(
    _$OrderDeliverSuccessImpl value,
    $Res Function(_$OrderDeliverSuccessImpl) then,
  ) = __$$OrderDeliverSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Order order});

  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class __$$OrderDeliverSuccessImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderDeliverSuccessImpl>
    implements _$$OrderDeliverSuccessImplCopyWith<$Res> {
  __$$OrderDeliverSuccessImplCopyWithImpl(
    _$OrderDeliverSuccessImpl _value,
    $Res Function(_$OrderDeliverSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? order = null}) {
    return _then(
      _$OrderDeliverSuccessImpl(
        null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                as Order,
      ),
    );
  }

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderCopyWith<$Res> get order {
    return $OrderCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value));
    });
  }
}

/// @nodoc

class _$OrderDeliverSuccessImpl implements OrderDeliverSuccess {
  const _$OrderDeliverSuccessImpl(this.order);

  @override
  final Order order;

  @override
  String toString() {
    return 'OrderState.deliverSuccess(order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDeliverSuccessImpl &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, order);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDeliverSuccessImplCopyWith<_$OrderDeliverSuccessImpl> get copyWith =>
      __$$OrderDeliverSuccessImplCopyWithImpl<_$OrderDeliverSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Order> orders, bool hasMore, int currentPage)
    loaded,
    required TResult Function(List<Order> orders) checkoutSuccess,
    required TResult Function(Order order) deliverSuccess,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return deliverSuccess(order);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Order> orders, bool hasMore, int currentPage)?
    loaded,
    TResult? Function(List<Order> orders)? checkoutSuccess,
    TResult? Function(Order order)? deliverSuccess,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return deliverSuccess?.call(order);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Order> orders, bool hasMore, int currentPage)? loaded,
    TResult Function(List<Order> orders)? checkoutSuccess,
    TResult Function(Order order)? deliverSuccess,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (deliverSuccess != null) {
      return deliverSuccess(order);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderInitial value) initial,
    required TResult Function(OrderLoading value) loading,
    required TResult Function(OrderLoaded value) loaded,
    required TResult Function(OrderCheckoutSuccess value) checkoutSuccess,
    required TResult Function(OrderDeliverSuccess value) deliverSuccess,
    required TResult Function(OrderFailure value) failure,
  }) {
    return deliverSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderInitial value)? initial,
    TResult? Function(OrderLoading value)? loading,
    TResult? Function(OrderLoaded value)? loaded,
    TResult? Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult? Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult? Function(OrderFailure value)? failure,
  }) {
    return deliverSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderInitial value)? initial,
    TResult Function(OrderLoading value)? loading,
    TResult Function(OrderLoaded value)? loaded,
    TResult Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult Function(OrderFailure value)? failure,
    required TResult orElse(),
  }) {
    if (deliverSuccess != null) {
      return deliverSuccess(this);
    }
    return orElse();
  }
}

abstract class OrderDeliverSuccess implements OrderState {
  const factory OrderDeliverSuccess(final Order order) =
      _$OrderDeliverSuccessImpl;

  Order get order;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDeliverSuccessImplCopyWith<_$OrderDeliverSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OrderFailureImplCopyWith<$Res> {
  factory _$$OrderFailureImplCopyWith(
    _$OrderFailureImpl value,
    $Res Function(_$OrderFailureImpl) then,
  ) = __$$OrderFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkFailure failure});

  $NetworkFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$OrderFailureImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderFailureImpl>
    implements _$$OrderFailureImplCopyWith<$Res> {
  __$$OrderFailureImplCopyWithImpl(
    _$OrderFailureImpl _value,
    $Res Function(_$OrderFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$OrderFailureImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as NetworkFailure,
      ),
    );
  }

  /// Create a copy of OrderState
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

class _$OrderFailureImpl implements OrderFailure {
  const _$OrderFailureImpl(this.failure);

  @override
  final NetworkFailure failure;

  @override
  String toString() {
    return 'OrderState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderFailureImplCopyWith<_$OrderFailureImpl> get copyWith =>
      __$$OrderFailureImplCopyWithImpl<_$OrderFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Order> orders, bool hasMore, int currentPage)
    loaded,
    required TResult Function(List<Order> orders) checkoutSuccess,
    required TResult Function(Order order) deliverSuccess,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Order> orders, bool hasMore, int currentPage)?
    loaded,
    TResult? Function(List<Order> orders)? checkoutSuccess,
    TResult? Function(Order order)? deliverSuccess,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Order> orders, bool hasMore, int currentPage)? loaded,
    TResult Function(List<Order> orders)? checkoutSuccess,
    TResult Function(Order order)? deliverSuccess,
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
    required TResult Function(OrderInitial value) initial,
    required TResult Function(OrderLoading value) loading,
    required TResult Function(OrderLoaded value) loaded,
    required TResult Function(OrderCheckoutSuccess value) checkoutSuccess,
    required TResult Function(OrderDeliverSuccess value) deliverSuccess,
    required TResult Function(OrderFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderInitial value)? initial,
    TResult? Function(OrderLoading value)? loading,
    TResult? Function(OrderLoaded value)? loaded,
    TResult? Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult? Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult? Function(OrderFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderInitial value)? initial,
    TResult Function(OrderLoading value)? loading,
    TResult Function(OrderLoaded value)? loaded,
    TResult Function(OrderCheckoutSuccess value)? checkoutSuccess,
    TResult Function(OrderDeliverSuccess value)? deliverSuccess,
    TResult Function(OrderFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class OrderFailure implements OrderState {
  const factory OrderFailure(final NetworkFailure failure) = _$OrderFailureImpl;

  NetworkFailure get failure;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderFailureImplCopyWith<_$OrderFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
