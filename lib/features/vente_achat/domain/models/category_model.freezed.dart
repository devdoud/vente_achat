// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Category {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  List<Category> get children => throw _privateConstructorUsedError;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call({
    String uuid,
    String name,
    int position,
    String? slug,
    String? icon,
    List<Category> children,
  });
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? position = null,
    Object? slug = freezed,
    Object? icon = freezed,
    Object? children = null,
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
            position:
                null == position
                    ? _value.position
                    : position // ignore: cast_nullable_to_non_nullable
                        as int,
            slug:
                freezed == slug
                    ? _value.slug
                    : slug // ignore: cast_nullable_to_non_nullable
                        as String?,
            icon:
                freezed == icon
                    ? _value.icon
                    : icon // ignore: cast_nullable_to_non_nullable
                        as String?,
            children:
                null == children
                    ? _value.children
                    : children // ignore: cast_nullable_to_non_nullable
                        as List<Category>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
    _$CategoryImpl value,
    $Res Function(_$CategoryImpl) then,
  ) = __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uuid,
    String name,
    int position,
    String? slug,
    String? icon,
    List<Category> children,
  });
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
    _$CategoryImpl _value,
    $Res Function(_$CategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? position = null,
    Object? slug = freezed,
    Object? icon = freezed,
    Object? children = null,
  }) {
    return _then(
      _$CategoryImpl(
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
        position:
            null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                    as int,
        slug:
            freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                    as String?,
        icon:
            freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                    as String?,
        children:
            null == children
                ? _value._children
                : children // ignore: cast_nullable_to_non_nullable
                    as List<Category>,
      ),
    );
  }
}

/// @nodoc

class _$CategoryImpl implements _Category {
  const _$CategoryImpl({
    required this.uuid,
    required this.name,
    required this.position,
    this.slug,
    this.icon,
    final List<Category> children = const [],
  }) : _children = children;

  @override
  final String uuid;
  @override
  final String name;
  @override
  final int position;
  @override
  final String? slug;
  @override
  final String? icon;
  final List<Category> _children;
  @override
  @JsonKey()
  List<Category> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'Category(uuid: $uuid, name: $name, position: $position, slug: $slug, icon: $icon, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    uuid,
    name,
    position,
    slug,
    icon,
    const DeepCollectionEquality().hash(_children),
  );

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);
}

abstract class _Category implements Category {
  const factory _Category({
    required final String uuid,
    required final String name,
    required final int position,
    final String? slug,
    final String? icon,
    final List<Category> children,
  }) = _$CategoryImpl;

  @override
  String get uuid;
  @override
  String get name;
  @override
  int get position;
  @override
  String? get slug;
  @override
  String? get icon;
  @override
  List<Category> get children;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CategoryFeature {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  Map<String, dynamic>? get valueConfig => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;

  /// Create a copy of CategoryFeature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryFeatureCopyWith<CategoryFeature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryFeatureCopyWith<$Res> {
  factory $CategoryFeatureCopyWith(
    CategoryFeature value,
    $Res Function(CategoryFeature) then,
  ) = _$CategoryFeatureCopyWithImpl<$Res, CategoryFeature>;
  @useResult
  $Res call({
    String code,
    String name,
    String type,
    String? unit,
    Map<String, dynamic>? valueConfig,
    bool isRequired,
    int position,
  });
}

/// @nodoc
class _$CategoryFeatureCopyWithImpl<$Res, $Val extends CategoryFeature>
    implements $CategoryFeatureCopyWith<$Res> {
  _$CategoryFeatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryFeature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? type = null,
    Object? unit = freezed,
    Object? valueConfig = freezed,
    Object? isRequired = null,
    Object? position = null,
  }) {
    return _then(
      _value.copyWith(
            code:
                null == code
                    ? _value.code
                    : code // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            unit:
                freezed == unit
                    ? _value.unit
                    : unit // ignore: cast_nullable_to_non_nullable
                        as String?,
            valueConfig:
                freezed == valueConfig
                    ? _value.valueConfig
                    : valueConfig // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
            isRequired:
                null == isRequired
                    ? _value.isRequired
                    : isRequired // ignore: cast_nullable_to_non_nullable
                        as bool,
            position:
                null == position
                    ? _value.position
                    : position // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryFeatureImplCopyWith<$Res>
    implements $CategoryFeatureCopyWith<$Res> {
  factory _$$CategoryFeatureImplCopyWith(
    _$CategoryFeatureImpl value,
    $Res Function(_$CategoryFeatureImpl) then,
  ) = __$$CategoryFeatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String name,
    String type,
    String? unit,
    Map<String, dynamic>? valueConfig,
    bool isRequired,
    int position,
  });
}

/// @nodoc
class __$$CategoryFeatureImplCopyWithImpl<$Res>
    extends _$CategoryFeatureCopyWithImpl<$Res, _$CategoryFeatureImpl>
    implements _$$CategoryFeatureImplCopyWith<$Res> {
  __$$CategoryFeatureImplCopyWithImpl(
    _$CategoryFeatureImpl _value,
    $Res Function(_$CategoryFeatureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryFeature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? type = null,
    Object? unit = freezed,
    Object? valueConfig = freezed,
    Object? isRequired = null,
    Object? position = null,
  }) {
    return _then(
      _$CategoryFeatureImpl(
        code:
            null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        unit:
            freezed == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                    as String?,
        valueConfig:
            freezed == valueConfig
                ? _value._valueConfig
                : valueConfig // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
        isRequired:
            null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                    as bool,
        position:
            null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$CategoryFeatureImpl extends _CategoryFeature {
  const _$CategoryFeatureImpl({
    required this.code,
    required this.name,
    required this.type,
    this.unit,
    final Map<String, dynamic>? valueConfig,
    this.isRequired = false,
    this.position = 0,
  }) : _valueConfig = valueConfig,
       super._();

  @override
  final String code;
  @override
  final String name;
  @override
  final String type;
  @override
  final String? unit;
  final Map<String, dynamic>? _valueConfig;
  @override
  Map<String, dynamic>? get valueConfig {
    final value = _valueConfig;
    if (value == null) return null;
    if (_valueConfig is EqualUnmodifiableMapView) return _valueConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool isRequired;
  @override
  @JsonKey()
  final int position;

  @override
  String toString() {
    return 'CategoryFeature(code: $code, name: $name, type: $type, unit: $unit, valueConfig: $valueConfig, isRequired: $isRequired, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryFeatureImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(
              other._valueConfig,
              _valueConfig,
            ) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    name,
    type,
    unit,
    const DeepCollectionEquality().hash(_valueConfig),
    isRequired,
    position,
  );

  /// Create a copy of CategoryFeature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryFeatureImplCopyWith<_$CategoryFeatureImpl> get copyWith =>
      __$$CategoryFeatureImplCopyWithImpl<_$CategoryFeatureImpl>(
        this,
        _$identity,
      );
}

abstract class _CategoryFeature extends CategoryFeature {
  const factory _CategoryFeature({
    required final String code,
    required final String name,
    required final String type,
    final String? unit,
    final Map<String, dynamic>? valueConfig,
    final bool isRequired,
    final int position,
  }) = _$CategoryFeatureImpl;
  const _CategoryFeature._() : super._();

  @override
  String get code;
  @override
  String get name;
  @override
  String get type;
  @override
  String? get unit;
  @override
  Map<String, dynamic>? get valueConfig;
  @override
  bool get isRequired;
  @override
  int get position;

  /// Create a copy of CategoryFeature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryFeatureImplCopyWith<_$CategoryFeatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
