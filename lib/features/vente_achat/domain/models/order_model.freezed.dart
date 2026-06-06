// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Order {
  String get uuid => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get merchantUuid => throw _privateConstructorUsedError;
  String? get merchantName => throw _privateConstructorUsedError;
  String? get deliveryCode => throw _privateConstructorUsedError;
  List<String> get itemUuids => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    String uuid,
    String status,
    int totalAmount,
    String? currency,
    String? note,
    String? merchantUuid,
    String? merchantName,
    String? deliveryCode,
    List<String> itemUuids,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? status = null,
    Object? totalAmount = null,
    Object? currency = freezed,
    Object? note = freezed,
    Object? merchantUuid = freezed,
    Object? merchantName = freezed,
    Object? deliveryCode = freezed,
    Object? itemUuids = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            uuid:
                null == uuid
                    ? _value.uuid
                    : uuid // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            totalAmount:
                null == totalAmount
                    ? _value.totalAmount
                    : totalAmount // ignore: cast_nullable_to_non_nullable
                        as int,
            currency:
                freezed == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String?,
            note:
                freezed == note
                    ? _value.note
                    : note // ignore: cast_nullable_to_non_nullable
                        as String?,
            merchantUuid:
                freezed == merchantUuid
                    ? _value.merchantUuid
                    : merchantUuid // ignore: cast_nullable_to_non_nullable
                        as String?,
            merchantName:
                freezed == merchantName
                    ? _value.merchantName
                    : merchantName // ignore: cast_nullable_to_non_nullable
                        as String?,
            deliveryCode:
                freezed == deliveryCode
                    ? _value.deliveryCode
                    : deliveryCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            itemUuids:
                null == itemUuids
                    ? _value.itemUuids
                    : itemUuids // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uuid,
    String status,
    int totalAmount,
    String? currency,
    String? note,
    String? merchantUuid,
    String? merchantName,
    String? deliveryCode,
    List<String> itemUuids,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? status = null,
    Object? totalAmount = null,
    Object? currency = freezed,
    Object? note = freezed,
    Object? merchantUuid = freezed,
    Object? merchantName = freezed,
    Object? deliveryCode = freezed,
    Object? itemUuids = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$OrderImpl(
        uuid:
            null == uuid
                ? _value.uuid
                : uuid // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        totalAmount:
            null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        currency:
            freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String?,
        note:
            freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                    as String?,
        merchantUuid:
            freezed == merchantUuid
                ? _value.merchantUuid
                : merchantUuid // ignore: cast_nullable_to_non_nullable
                    as String?,
        merchantName:
            freezed == merchantName
                ? _value.merchantName
                : merchantName // ignore: cast_nullable_to_non_nullable
                    as String?,
        deliveryCode:
            freezed == deliveryCode
                ? _value.deliveryCode
                : deliveryCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        itemUuids:
            null == itemUuids
                ? _value._itemUuids
                : itemUuids // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$OrderImpl extends _Order {
  const _$OrderImpl({
    required this.uuid,
    required this.status,
    required this.totalAmount,
    this.currency,
    this.note,
    this.merchantUuid,
    this.merchantName,
    this.deliveryCode,
    final List<String> itemUuids = const [],
    required this.createdAt,
    this.updatedAt,
  }) : _itemUuids = itemUuids,
       super._();

  @override
  final String uuid;
  @override
  final String status;
  @override
  final int totalAmount;
  @override
  final String? currency;
  @override
  final String? note;
  @override
  final String? merchantUuid;
  @override
  final String? merchantName;
  @override
  final String? deliveryCode;
  final List<String> _itemUuids;
  @override
  @JsonKey()
  List<String> get itemUuids {
    if (_itemUuids is EqualUnmodifiableListView) return _itemUuids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemUuids);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Order(uuid: $uuid, status: $status, totalAmount: $totalAmount, currency: $currency, note: $note, merchantUuid: $merchantUuid, merchantName: $merchantName, deliveryCode: $deliveryCode, itemUuids: $itemUuids, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.merchantUuid, merchantUuid) ||
                other.merchantUuid == merchantUuid) &&
            (identical(other.merchantName, merchantName) ||
                other.merchantName == merchantName) &&
            (identical(other.deliveryCode, deliveryCode) ||
                other.deliveryCode == deliveryCode) &&
            const DeepCollectionEquality().equals(
              other._itemUuids,
              _itemUuids,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uuid,
    status,
    totalAmount,
    currency,
    note,
    merchantUuid,
    merchantName,
    deliveryCode,
    const DeepCollectionEquality().hash(_itemUuids),
    createdAt,
    updatedAt,
  );

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);
}

abstract class _Order extends Order {
  const factory _Order({
    required final String uuid,
    required final String status,
    required final int totalAmount,
    final String? currency,
    final String? note,
    final String? merchantUuid,
    final String? merchantName,
    final String? deliveryCode,
    final List<String> itemUuids,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$OrderImpl;
  const _Order._() : super._();

  @override
  String get uuid;
  @override
  String get status;
  @override
  int get totalAmount;
  @override
  String? get currency;
  @override
  String? get note;
  @override
  String? get merchantUuid;
  @override
  String? get merchantName;
  @override
  String? get deliveryCode;
  @override
  List<String> get itemUuids;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
