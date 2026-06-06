// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CartItem {
  String get uuid =>
      throw _privateConstructorUsedError; // UUID de l'article panier (pour update/delete)
  int get quantity => throw _privateConstructorUsedError;
  int get unitPrice => throw _privateConstructorUsedError;
  int get subtotal => throw _privateConstructorUsedError;
  String get productUuid => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  int get effectivePrice => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  bool get purchasable => throw _privateConstructorUsedError;
  String? get merchantName => throw _privateConstructorUsedError;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call({
    String uuid,
    int quantity,
    int unitPrice,
    int subtotal,
    String productUuid,
    String productName,
    int effectivePrice,
    int stock,
    bool purchasable,
    String? merchantName,
  });
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? subtotal = null,
    Object? productUuid = null,
    Object? productName = null,
    Object? effectivePrice = null,
    Object? stock = null,
    Object? purchasable = null,
    Object? merchantName = freezed,
  }) {
    return _then(
      _value.copyWith(
            uuid:
                null == uuid
                    ? _value.uuid
                    : uuid // ignore: cast_nullable_to_non_nullable
                        as String,
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
            unitPrice:
                null == unitPrice
                    ? _value.unitPrice
                    : unitPrice // ignore: cast_nullable_to_non_nullable
                        as int,
            subtotal:
                null == subtotal
                    ? _value.subtotal
                    : subtotal // ignore: cast_nullable_to_non_nullable
                        as int,
            productUuid:
                null == productUuid
                    ? _value.productUuid
                    : productUuid // ignore: cast_nullable_to_non_nullable
                        as String,
            productName:
                null == productName
                    ? _value.productName
                    : productName // ignore: cast_nullable_to_non_nullable
                        as String,
            effectivePrice:
                null == effectivePrice
                    ? _value.effectivePrice
                    : effectivePrice // ignore: cast_nullable_to_non_nullable
                        as int,
            stock:
                null == stock
                    ? _value.stock
                    : stock // ignore: cast_nullable_to_non_nullable
                        as int,
            purchasable:
                null == purchasable
                    ? _value.purchasable
                    : purchasable // ignore: cast_nullable_to_non_nullable
                        as bool,
            merchantName:
                freezed == merchantName
                    ? _value.merchantName
                    : merchantName // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
    _$CartItemImpl value,
    $Res Function(_$CartItemImpl) then,
  ) = __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uuid,
    int quantity,
    int unitPrice,
    int subtotal,
    String productUuid,
    String productName,
    int effectivePrice,
    int stock,
    bool purchasable,
    String? merchantName,
  });
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
    _$CartItemImpl _value,
    $Res Function(_$CartItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? subtotal = null,
    Object? productUuid = null,
    Object? productName = null,
    Object? effectivePrice = null,
    Object? stock = null,
    Object? purchasable = null,
    Object? merchantName = freezed,
  }) {
    return _then(
      _$CartItemImpl(
        uuid:
            null == uuid
                ? _value.uuid
                : uuid // ignore: cast_nullable_to_non_nullable
                    as String,
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
        unitPrice:
            null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                    as int,
        subtotal:
            null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                    as int,
        productUuid:
            null == productUuid
                ? _value.productUuid
                : productUuid // ignore: cast_nullable_to_non_nullable
                    as String,
        productName:
            null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                    as String,
        effectivePrice:
            null == effectivePrice
                ? _value.effectivePrice
                : effectivePrice // ignore: cast_nullable_to_non_nullable
                    as int,
        stock:
            null == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                    as int,
        purchasable:
            null == purchasable
                ? _value.purchasable
                : purchasable // ignore: cast_nullable_to_non_nullable
                    as bool,
        merchantName:
            freezed == merchantName
                ? _value.merchantName
                : merchantName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$CartItemImpl extends _CartItem {
  const _$CartItemImpl({
    required this.uuid,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.productUuid,
    required this.productName,
    required this.effectivePrice,
    required this.stock,
    this.purchasable = false,
    this.merchantName,
  }) : super._();

  @override
  final String uuid;
  // UUID de l'article panier (pour update/delete)
  @override
  final int quantity;
  @override
  final int unitPrice;
  @override
  final int subtotal;
  @override
  final String productUuid;
  @override
  final String productName;
  @override
  final int effectivePrice;
  @override
  final int stock;
  @override
  @JsonKey()
  final bool purchasable;
  @override
  final String? merchantName;

  @override
  String toString() {
    return 'CartItem(uuid: $uuid, quantity: $quantity, unitPrice: $unitPrice, subtotal: $subtotal, productUuid: $productUuid, productName: $productName, effectivePrice: $effectivePrice, stock: $stock, purchasable: $purchasable, merchantName: $merchantName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.productUuid, productUuid) ||
                other.productUuid == productUuid) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.effectivePrice, effectivePrice) ||
                other.effectivePrice == effectivePrice) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.purchasable, purchasable) ||
                other.purchasable == purchasable) &&
            (identical(other.merchantName, merchantName) ||
                other.merchantName == merchantName));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uuid,
    quantity,
    unitPrice,
    subtotal,
    productUuid,
    productName,
    effectivePrice,
    stock,
    purchasable,
    merchantName,
  );

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);
}

abstract class _CartItem extends CartItem {
  const factory _CartItem({
    required final String uuid,
    required final int quantity,
    required final int unitPrice,
    required final int subtotal,
    required final String productUuid,
    required final String productName,
    required final int effectivePrice,
    required final int stock,
    final bool purchasable,
    final String? merchantName,
  }) = _$CartItemImpl;
  const _CartItem._() : super._();

  @override
  String get uuid; // UUID de l'article panier (pour update/delete)
  @override
  int get quantity;
  @override
  int get unitPrice;
  @override
  int get subtotal;
  @override
  String get productUuid;
  @override
  String get productName;
  @override
  int get effectivePrice;
  @override
  int get stock;
  @override
  bool get purchasable;
  @override
  String? get merchantName;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Cart {
  String get uuid => throw _privateConstructorUsedError;
  List<CartItem> get items => throw _privateConstructorUsedError;
  int get itemCount => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartCopyWith<Cart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCopyWith<$Res> {
  factory $CartCopyWith(Cart value, $Res Function(Cart) then) =
      _$CartCopyWithImpl<$Res, Cart>;
  @useResult
  $Res call({
    String uuid,
    List<CartItem> items,
    int itemCount,
    int total,
    String? updatedAt,
  });
}

/// @nodoc
class _$CartCopyWithImpl<$Res, $Val extends Cart>
    implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? items = null,
    Object? itemCount = null,
    Object? total = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            uuid:
                null == uuid
                    ? _value.uuid
                    : uuid // ignore: cast_nullable_to_non_nullable
                        as String,
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<CartItem>,
            itemCount:
                null == itemCount
                    ? _value.itemCount
                    : itemCount // ignore: cast_nullable_to_non_nullable
                        as int,
            total:
                null == total
                    ? _value.total
                    : total // ignore: cast_nullable_to_non_nullable
                        as int,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CartImplCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$$CartImplCopyWith(
    _$CartImpl value,
    $Res Function(_$CartImpl) then,
  ) = __$$CartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uuid,
    List<CartItem> items,
    int itemCount,
    int total,
    String? updatedAt,
  });
}

/// @nodoc
class __$$CartImplCopyWithImpl<$Res>
    extends _$CartCopyWithImpl<$Res, _$CartImpl>
    implements _$$CartImplCopyWith<$Res> {
  __$$CartImplCopyWithImpl(_$CartImpl _value, $Res Function(_$CartImpl) _then)
    : super(_value, _then);

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? items = null,
    Object? itemCount = null,
    Object? total = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$CartImpl(
        uuid:
            null == uuid
                ? _value.uuid
                : uuid // ignore: cast_nullable_to_non_nullable
                    as String,
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<CartItem>,
        itemCount:
            null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                    as int,
        total:
            null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                    as int,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$CartImpl extends _Cart {
  const _$CartImpl({
    required this.uuid,
    final List<CartItem> items = const [],
    this.itemCount = 0,
    this.total = 0,
    this.updatedAt,
  }) : _items = items,
       super._();

  @override
  final String uuid;
  final List<CartItem> _items;
  @override
  @JsonKey()
  List<CartItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int itemCount;
  @override
  @JsonKey()
  final int total;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'Cart(uuid: $uuid, items: $items, itemCount: $itemCount, total: $total, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uuid,
    const DeepCollectionEquality().hash(_items),
    itemCount,
    total,
    updatedAt,
  );

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartImplCopyWith<_$CartImpl> get copyWith =>
      __$$CartImplCopyWithImpl<_$CartImpl>(this, _$identity);
}

abstract class _Cart extends Cart {
  const factory _Cart({
    required final String uuid,
    final List<CartItem> items,
    final int itemCount,
    final int total,
    final String? updatedAt,
  }) = _$CartImpl;
  const _Cart._() : super._();

  @override
  String get uuid;
  @override
  List<CartItem> get items;
  @override
  int get itemCount;
  @override
  int get total;
  @override
  String? get updatedAt;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartImplCopyWith<_$CartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
