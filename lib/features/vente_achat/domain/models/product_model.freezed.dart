// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Product {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int? get discountedPrice => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get categoryUuid => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  String get shopUuid => throw _privateConstructorUsedError;
  String? get shopName => throw _privateConstructorUsedError;
  String? get shopLogo => throw _privateConstructorUsedError;
  double? get avgRating => throw _privateConstructorUsedError;
  int? get reviewCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get bannerUrl => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  Map<String, dynamic>? get features => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    String uuid,
    String name,
    int price,
    int? discountedPrice,
    String description,
    int stock,
    String status,
    String categoryUuid,
    String categoryName,
    String shopUuid,
    String? shopName,
    String? shopLogo,
    double? avgRating,
    int? reviewCount,
    DateTime? createdAt,
    String? bannerUrl,
    List<String> imageUrls,
    Map<String, dynamic>? features,
  });
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? price = null,
    Object? discountedPrice = freezed,
    Object? description = null,
    Object? stock = null,
    Object? status = null,
    Object? categoryUuid = null,
    Object? categoryName = null,
    Object? shopUuid = null,
    Object? shopName = freezed,
    Object? shopLogo = freezed,
    Object? avgRating = freezed,
    Object? reviewCount = freezed,
    Object? createdAt = freezed,
    Object? bannerUrl = freezed,
    Object? imageUrls = null,
    Object? features = freezed,
  }) {
    return _then(
      _value.copyWith(
            uuid:
                null == uuid
                    ? _value.uuid
                    : uuid // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as int,
            discountedPrice:
                freezed == discountedPrice
                    ? _value.discountedPrice
                    : discountedPrice // ignore: cast_nullable_to_non_nullable
                        as int?,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            stock:
                null == stock
                    ? _value.stock
                    : stock // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            categoryUuid:
                null == categoryUuid
                    ? _value.categoryUuid
                    : categoryUuid // ignore: cast_nullable_to_non_nullable
                        as String,
            categoryName:
                null == categoryName
                    ? _value.categoryName
                    : categoryName // ignore: cast_nullable_to_non_nullable
                        as String,
            shopUuid:
                null == shopUuid
                    ? _value.shopUuid
                    : shopUuid // ignore: cast_nullable_to_non_nullable
                        as String,
            shopName:
                freezed == shopName
                    ? _value.shopName
                    : shopName // ignore: cast_nullable_to_non_nullable
                        as String?,
            shopLogo:
                freezed == shopLogo
                    ? _value.shopLogo
                    : shopLogo // ignore: cast_nullable_to_non_nullable
                        as String?,
            avgRating:
                freezed == avgRating
                    ? _value.avgRating
                    : avgRating // ignore: cast_nullable_to_non_nullable
                        as double?,
            reviewCount:
                freezed == reviewCount
                    ? _value.reviewCount
                    : reviewCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            bannerUrl:
                freezed == bannerUrl
                    ? _value.bannerUrl
                    : bannerUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            imageUrls:
                null == imageUrls
                    ? _value.imageUrls
                    : imageUrls // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            features:
                freezed == features
                    ? _value.features
                    : features // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uuid,
    String name,
    int price,
    int? discountedPrice,
    String description,
    int stock,
    String status,
    String categoryUuid,
    String categoryName,
    String shopUuid,
    String? shopName,
    String? shopLogo,
    double? avgRating,
    int? reviewCount,
    DateTime? createdAt,
    String? bannerUrl,
    List<String> imageUrls,
    Map<String, dynamic>? features,
  });
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? price = null,
    Object? discountedPrice = freezed,
    Object? description = null,
    Object? stock = null,
    Object? status = null,
    Object? categoryUuid = null,
    Object? categoryName = null,
    Object? shopUuid = null,
    Object? shopName = freezed,
    Object? shopLogo = freezed,
    Object? avgRating = freezed,
    Object? reviewCount = freezed,
    Object? createdAt = freezed,
    Object? bannerUrl = freezed,
    Object? imageUrls = null,
    Object? features = freezed,
  }) {
    return _then(
      _$ProductImpl(
        uuid:
            null == uuid
                ? _value.uuid
                : uuid // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as int,
        discountedPrice:
            freezed == discountedPrice
                ? _value.discountedPrice
                : discountedPrice // ignore: cast_nullable_to_non_nullable
                    as int?,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        stock:
            null == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        categoryUuid:
            null == categoryUuid
                ? _value.categoryUuid
                : categoryUuid // ignore: cast_nullable_to_non_nullable
                    as String,
        categoryName:
            null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                    as String,
        shopUuid:
            null == shopUuid
                ? _value.shopUuid
                : shopUuid // ignore: cast_nullable_to_non_nullable
                    as String,
        shopName:
            freezed == shopName
                ? _value.shopName
                : shopName // ignore: cast_nullable_to_non_nullable
                    as String?,
        shopLogo:
            freezed == shopLogo
                ? _value.shopLogo
                : shopLogo // ignore: cast_nullable_to_non_nullable
                    as String?,
        avgRating:
            freezed == avgRating
                ? _value.avgRating
                : avgRating // ignore: cast_nullable_to_non_nullable
                    as double?,
        reviewCount:
            freezed == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        bannerUrl:
            freezed == bannerUrl
                ? _value.bannerUrl
                : bannerUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        imageUrls:
            null == imageUrls
                ? _value._imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        features:
            freezed == features
                ? _value._features
                : features // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

class _$ProductImpl extends _Product {
  const _$ProductImpl({
    required this.uuid,
    required this.name,
    required this.price,
    this.discountedPrice,
    required this.description,
    required this.stock,
    required this.status,
    required this.categoryUuid,
    this.categoryName = '',
    required this.shopUuid,
    this.shopName,
    this.shopLogo,
    this.avgRating,
    this.reviewCount,
    this.createdAt,
    this.bannerUrl,
    final List<String> imageUrls = const [],
    final Map<String, dynamic>? features,
  }) : _imageUrls = imageUrls,
       _features = features,
       super._();

  @override
  final String uuid;
  @override
  final String name;
  @override
  final int price;
  @override
  final int? discountedPrice;
  @override
  final String description;
  @override
  final int stock;
  @override
  final String status;
  @override
  final String categoryUuid;
  @override
  @JsonKey()
  final String categoryName;
  @override
  final String shopUuid;
  @override
  final String? shopName;
  @override
  final String? shopLogo;
  @override
  final double? avgRating;
  @override
  final int? reviewCount;
  @override
  final DateTime? createdAt;
  @override
  final String? bannerUrl;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  final Map<String, dynamic>? _features;
  @override
  Map<String, dynamic>? get features {
    final value = _features;
    if (value == null) return null;
    if (_features is EqualUnmodifiableMapView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Product(uuid: $uuid, name: $name, price: $price, discountedPrice: $discountedPrice, description: $description, stock: $stock, status: $status, categoryUuid: $categoryUuid, categoryName: $categoryName, shopUuid: $shopUuid, shopName: $shopName, shopLogo: $shopLogo, avgRating: $avgRating, reviewCount: $reviewCount, createdAt: $createdAt, bannerUrl: $bannerUrl, imageUrls: $imageUrls, features: $features)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.discountedPrice, discountedPrice) ||
                other.discountedPrice == discountedPrice) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.categoryUuid, categoryUuid) ||
                other.categoryUuid == categoryUuid) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.shopUuid, shopUuid) ||
                other.shopUuid == shopUuid) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.shopLogo, shopLogo) ||
                other.shopLogo == shopLogo) &&
            (identical(other.avgRating, avgRating) ||
                other.avgRating == avgRating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.bannerUrl, bannerUrl) ||
                other.bannerUrl == bannerUrl) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uuid,
    name,
    price,
    discountedPrice,
    description,
    stock,
    status,
    categoryUuid,
    categoryName,
    shopUuid,
    shopName,
    shopLogo,
    avgRating,
    reviewCount,
    createdAt,
    bannerUrl,
    const DeepCollectionEquality().hash(_imageUrls),
    const DeepCollectionEquality().hash(_features),
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);
}

abstract class _Product extends Product {
  const factory _Product({
    required final String uuid,
    required final String name,
    required final int price,
    final int? discountedPrice,
    required final String description,
    required final int stock,
    required final String status,
    required final String categoryUuid,
    final String categoryName,
    required final String shopUuid,
    final String? shopName,
    final String? shopLogo,
    final double? avgRating,
    final int? reviewCount,
    final DateTime? createdAt,
    final String? bannerUrl,
    final List<String> imageUrls,
    final Map<String, dynamic>? features,
  }) = _$ProductImpl;
  const _Product._() : super._();

  @override
  String get uuid;
  @override
  String get name;
  @override
  int get price;
  @override
  int? get discountedPrice;
  @override
  String get description;
  @override
  int get stock;
  @override
  String get status;
  @override
  String get categoryUuid;
  @override
  String get categoryName;
  @override
  String get shopUuid;
  @override
  String? get shopName;
  @override
  String? get shopLogo;
  @override
  double? get avgRating;
  @override
  int? get reviewCount;
  @override
  DateTime? get createdAt;
  @override
  String? get bannerUrl;
  @override
  List<String> get imageUrls;
  @override
  Map<String, dynamic>? get features;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
