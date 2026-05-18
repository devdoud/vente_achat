// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InfiniteList<T> {
  List<T> get data => throw _privateConstructorUsedError;
  String? get first => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get last => throw _privateConstructorUsedError;

  /// Create a copy of InfiniteList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InfiniteListCopyWith<T, InfiniteList<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfiniteListCopyWith<T, $Res> {
  factory $InfiniteListCopyWith(
    InfiniteList<T> value,
    $Res Function(InfiniteList<T>) then,
  ) = _$InfiniteListCopyWithImpl<T, $Res, InfiniteList<T>>;
  @useResult
  $Res call({List<T> data, String? first, String? next, String? last});
}

/// @nodoc
class _$InfiniteListCopyWithImpl<T, $Res, $Val extends InfiniteList<T>>
    implements $InfiniteListCopyWith<T, $Res> {
  _$InfiniteListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InfiniteList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? first = freezed,
    Object? next = freezed,
    Object? last = freezed,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<T>,
            first:
                freezed == first
                    ? _value.first
                    : first // ignore: cast_nullable_to_non_nullable
                        as String?,
            next:
                freezed == next
                    ? _value.next
                    : next // ignore: cast_nullable_to_non_nullable
                        as String?,
            last:
                freezed == last
                    ? _value.last
                    : last // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InfiniteListImplCopyWith<T, $Res>
    implements $InfiniteListCopyWith<T, $Res> {
  factory _$$InfiniteListImplCopyWith(
    _$InfiniteListImpl<T> value,
    $Res Function(_$InfiniteListImpl<T>) then,
  ) = __$$InfiniteListImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T> data, String? first, String? next, String? last});
}

/// @nodoc
class __$$InfiniteListImplCopyWithImpl<T, $Res>
    extends _$InfiniteListCopyWithImpl<T, $Res, _$InfiniteListImpl<T>>
    implements _$$InfiniteListImplCopyWith<T, $Res> {
  __$$InfiniteListImplCopyWithImpl(
    _$InfiniteListImpl<T> _value,
    $Res Function(_$InfiniteListImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of InfiniteList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? first = freezed,
    Object? next = freezed,
    Object? last = freezed,
  }) {
    return _then(
      _$InfiniteListImpl<T>(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<T>,
        first:
            freezed == first
                ? _value.first
                : first // ignore: cast_nullable_to_non_nullable
                    as String?,
        next:
            freezed == next
                ? _value.next
                : next // ignore: cast_nullable_to_non_nullable
                    as String?,
        last:
            freezed == last
                ? _value.last
                : last // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$InfiniteListImpl<T> extends _InfiniteList<T> {
  const _$InfiniteListImpl({
    required final List<T> data,
    required this.first,
    required this.next,
    required this.last,
  }) : _data = data,
       super._();

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final String? first;
  @override
  final String? next;
  @override
  final String? last;

  @override
  String toString() {
    return 'InfiniteList<$T>(data: $data, first: $first, next: $next, last: $last)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfiniteListImpl<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.last, last) || other.last == last));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    first,
    next,
    last,
  );

  /// Create a copy of InfiniteList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InfiniteListImplCopyWith<T, _$InfiniteListImpl<T>> get copyWith =>
      __$$InfiniteListImplCopyWithImpl<T, _$InfiniteListImpl<T>>(
        this,
        _$identity,
      );
}

abstract class _InfiniteList<T> extends InfiniteList<T> {
  const factory _InfiniteList({
    required final List<T> data,
    required final String? first,
    required final String? next,
    required final String? last,
  }) = _$InfiniteListImpl<T>;
  const _InfiniteList._() : super._();

  @override
  List<T> get data;
  @override
  String? get first;
  @override
  String? get next;
  @override
  String? get last;

  /// Create a copy of InfiniteList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InfiniteListImplCopyWith<T, _$InfiniteListImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
