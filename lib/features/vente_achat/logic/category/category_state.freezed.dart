// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CategoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Category> categories) loaded,
    required TResult Function(NetworkFailure failure) failure,
    required TResult Function(
      String categoryUuid,
      List<CategoryFeature> features,
    )
    featuresLoaded,
    required TResult Function(String categoryUuid) featuresLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Category> categories)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
    TResult? Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult? Function(String categoryUuid)? featuresLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Category> categories)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    TResult Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult Function(String categoryUuid)? featuresLoading,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryInitial value) initial,
    required TResult Function(CategoryLoading value) loading,
    required TResult Function(CategoryLoaded value) loaded,
    required TResult Function(CategoryFailure value) failure,
    required TResult Function(CategoryFeaturesLoaded value) featuresLoaded,
    required TResult Function(CategoryFeaturesLoading value) featuresLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryInitial value)? initial,
    TResult? Function(CategoryLoading value)? loading,
    TResult? Function(CategoryLoaded value)? loaded,
    TResult? Function(CategoryFailure value)? failure,
    TResult? Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult? Function(CategoryFeaturesLoading value)? featuresLoading,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryInitial value)? initial,
    TResult Function(CategoryLoading value)? loading,
    TResult Function(CategoryLoaded value)? loaded,
    TResult Function(CategoryFailure value)? failure,
    TResult Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult Function(CategoryFeaturesLoading value)? featuresLoading,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryStateCopyWith<$Res> {
  factory $CategoryStateCopyWith(
    CategoryState value,
    $Res Function(CategoryState) then,
  ) = _$CategoryStateCopyWithImpl<$Res, CategoryState>;
}

/// @nodoc
class _$CategoryStateCopyWithImpl<$Res, $Val extends CategoryState>
    implements $CategoryStateCopyWith<$Res> {
  _$CategoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CategoryInitialImplCopyWith<$Res> {
  factory _$$CategoryInitialImplCopyWith(
    _$CategoryInitialImpl value,
    $Res Function(_$CategoryInitialImpl) then,
  ) = __$$CategoryInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CategoryInitialImplCopyWithImpl<$Res>
    extends _$CategoryStateCopyWithImpl<$Res, _$CategoryInitialImpl>
    implements _$$CategoryInitialImplCopyWith<$Res> {
  __$$CategoryInitialImplCopyWithImpl(
    _$CategoryInitialImpl _value,
    $Res Function(_$CategoryInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CategoryInitialImpl implements CategoryInitial {
  const _$CategoryInitialImpl();

  @override
  String toString() {
    return 'CategoryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CategoryInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Category> categories) loaded,
    required TResult Function(NetworkFailure failure) failure,
    required TResult Function(
      String categoryUuid,
      List<CategoryFeature> features,
    )
    featuresLoaded,
    required TResult Function(String categoryUuid) featuresLoading,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Category> categories)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
    TResult? Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult? Function(String categoryUuid)? featuresLoading,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Category> categories)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    TResult Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult Function(String categoryUuid)? featuresLoading,
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
    required TResult Function(CategoryInitial value) initial,
    required TResult Function(CategoryLoading value) loading,
    required TResult Function(CategoryLoaded value) loaded,
    required TResult Function(CategoryFailure value) failure,
    required TResult Function(CategoryFeaturesLoaded value) featuresLoaded,
    required TResult Function(CategoryFeaturesLoading value) featuresLoading,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryInitial value)? initial,
    TResult? Function(CategoryLoading value)? loading,
    TResult? Function(CategoryLoaded value)? loaded,
    TResult? Function(CategoryFailure value)? failure,
    TResult? Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult? Function(CategoryFeaturesLoading value)? featuresLoading,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryInitial value)? initial,
    TResult Function(CategoryLoading value)? loading,
    TResult Function(CategoryLoaded value)? loaded,
    TResult Function(CategoryFailure value)? failure,
    TResult Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult Function(CategoryFeaturesLoading value)? featuresLoading,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CategoryInitial implements CategoryState {
  const factory CategoryInitial() = _$CategoryInitialImpl;
}

/// @nodoc
abstract class _$$CategoryLoadingImplCopyWith<$Res> {
  factory _$$CategoryLoadingImplCopyWith(
    _$CategoryLoadingImpl value,
    $Res Function(_$CategoryLoadingImpl) then,
  ) = __$$CategoryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CategoryLoadingImplCopyWithImpl<$Res>
    extends _$CategoryStateCopyWithImpl<$Res, _$CategoryLoadingImpl>
    implements _$$CategoryLoadingImplCopyWith<$Res> {
  __$$CategoryLoadingImplCopyWithImpl(
    _$CategoryLoadingImpl _value,
    $Res Function(_$CategoryLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CategoryLoadingImpl implements CategoryLoading {
  const _$CategoryLoadingImpl();

  @override
  String toString() {
    return 'CategoryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CategoryLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Category> categories) loaded,
    required TResult Function(NetworkFailure failure) failure,
    required TResult Function(
      String categoryUuid,
      List<CategoryFeature> features,
    )
    featuresLoaded,
    required TResult Function(String categoryUuid) featuresLoading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Category> categories)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
    TResult? Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult? Function(String categoryUuid)? featuresLoading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Category> categories)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    TResult Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult Function(String categoryUuid)? featuresLoading,
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
    required TResult Function(CategoryInitial value) initial,
    required TResult Function(CategoryLoading value) loading,
    required TResult Function(CategoryLoaded value) loaded,
    required TResult Function(CategoryFailure value) failure,
    required TResult Function(CategoryFeaturesLoaded value) featuresLoaded,
    required TResult Function(CategoryFeaturesLoading value) featuresLoading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryInitial value)? initial,
    TResult? Function(CategoryLoading value)? loading,
    TResult? Function(CategoryLoaded value)? loaded,
    TResult? Function(CategoryFailure value)? failure,
    TResult? Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult? Function(CategoryFeaturesLoading value)? featuresLoading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryInitial value)? initial,
    TResult Function(CategoryLoading value)? loading,
    TResult Function(CategoryLoaded value)? loaded,
    TResult Function(CategoryFailure value)? failure,
    TResult Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult Function(CategoryFeaturesLoading value)? featuresLoading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CategoryLoading implements CategoryState {
  const factory CategoryLoading() = _$CategoryLoadingImpl;
}

/// @nodoc
abstract class _$$CategoryLoadedImplCopyWith<$Res> {
  factory _$$CategoryLoadedImplCopyWith(
    _$CategoryLoadedImpl value,
    $Res Function(_$CategoryLoadedImpl) then,
  ) = __$$CategoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Category> categories});
}

/// @nodoc
class __$$CategoryLoadedImplCopyWithImpl<$Res>
    extends _$CategoryStateCopyWithImpl<$Res, _$CategoryLoadedImpl>
    implements _$$CategoryLoadedImplCopyWith<$Res> {
  __$$CategoryLoadedImplCopyWithImpl(
    _$CategoryLoadedImpl _value,
    $Res Function(_$CategoryLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categories = null}) {
    return _then(
      _$CategoryLoadedImpl(
        null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                as List<Category>,
      ),
    );
  }
}

/// @nodoc

class _$CategoryLoadedImpl implements CategoryLoaded {
  const _$CategoryLoadedImpl(final List<Category> categories)
    : _categories = categories;

  final List<Category> _categories;
  @override
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  String toString() {
    return 'CategoryState.loaded(categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_categories),
  );

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryLoadedImplCopyWith<_$CategoryLoadedImpl> get copyWith =>
      __$$CategoryLoadedImplCopyWithImpl<_$CategoryLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Category> categories) loaded,
    required TResult Function(NetworkFailure failure) failure,
    required TResult Function(
      String categoryUuid,
      List<CategoryFeature> features,
    )
    featuresLoaded,
    required TResult Function(String categoryUuid) featuresLoading,
  }) {
    return loaded(categories);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Category> categories)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
    TResult? Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult? Function(String categoryUuid)? featuresLoading,
  }) {
    return loaded?.call(categories);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Category> categories)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    TResult Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult Function(String categoryUuid)? featuresLoading,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(categories);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryInitial value) initial,
    required TResult Function(CategoryLoading value) loading,
    required TResult Function(CategoryLoaded value) loaded,
    required TResult Function(CategoryFailure value) failure,
    required TResult Function(CategoryFeaturesLoaded value) featuresLoaded,
    required TResult Function(CategoryFeaturesLoading value) featuresLoading,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryInitial value)? initial,
    TResult? Function(CategoryLoading value)? loading,
    TResult? Function(CategoryLoaded value)? loaded,
    TResult? Function(CategoryFailure value)? failure,
    TResult? Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult? Function(CategoryFeaturesLoading value)? featuresLoading,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryInitial value)? initial,
    TResult Function(CategoryLoading value)? loading,
    TResult Function(CategoryLoaded value)? loaded,
    TResult Function(CategoryFailure value)? failure,
    TResult Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult Function(CategoryFeaturesLoading value)? featuresLoading,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CategoryLoaded implements CategoryState {
  const factory CategoryLoaded(final List<Category> categories) =
      _$CategoryLoadedImpl;

  List<Category> get categories;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryLoadedImplCopyWith<_$CategoryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CategoryFailureImplCopyWith<$Res> {
  factory _$$CategoryFailureImplCopyWith(
    _$CategoryFailureImpl value,
    $Res Function(_$CategoryFailureImpl) then,
  ) = __$$CategoryFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkFailure failure});

  $NetworkFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$CategoryFailureImplCopyWithImpl<$Res>
    extends _$CategoryStateCopyWithImpl<$Res, _$CategoryFailureImpl>
    implements _$$CategoryFailureImplCopyWith<$Res> {
  __$$CategoryFailureImplCopyWithImpl(
    _$CategoryFailureImpl _value,
    $Res Function(_$CategoryFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$CategoryFailureImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as NetworkFailure,
      ),
    );
  }

  /// Create a copy of CategoryState
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

class _$CategoryFailureImpl implements CategoryFailure {
  const _$CategoryFailureImpl(this.failure);

  @override
  final NetworkFailure failure;

  @override
  String toString() {
    return 'CategoryState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryFailureImplCopyWith<_$CategoryFailureImpl> get copyWith =>
      __$$CategoryFailureImplCopyWithImpl<_$CategoryFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Category> categories) loaded,
    required TResult Function(NetworkFailure failure) failure,
    required TResult Function(
      String categoryUuid,
      List<CategoryFeature> features,
    )
    featuresLoaded,
    required TResult Function(String categoryUuid) featuresLoading,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Category> categories)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
    TResult? Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult? Function(String categoryUuid)? featuresLoading,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Category> categories)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    TResult Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult Function(String categoryUuid)? featuresLoading,
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
    required TResult Function(CategoryInitial value) initial,
    required TResult Function(CategoryLoading value) loading,
    required TResult Function(CategoryLoaded value) loaded,
    required TResult Function(CategoryFailure value) failure,
    required TResult Function(CategoryFeaturesLoaded value) featuresLoaded,
    required TResult Function(CategoryFeaturesLoading value) featuresLoading,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryInitial value)? initial,
    TResult? Function(CategoryLoading value)? loading,
    TResult? Function(CategoryLoaded value)? loaded,
    TResult? Function(CategoryFailure value)? failure,
    TResult? Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult? Function(CategoryFeaturesLoading value)? featuresLoading,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryInitial value)? initial,
    TResult Function(CategoryLoading value)? loading,
    TResult Function(CategoryLoaded value)? loaded,
    TResult Function(CategoryFailure value)? failure,
    TResult Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult Function(CategoryFeaturesLoading value)? featuresLoading,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class CategoryFailure implements CategoryState {
  const factory CategoryFailure(final NetworkFailure failure) =
      _$CategoryFailureImpl;

  NetworkFailure get failure;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryFailureImplCopyWith<_$CategoryFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CategoryFeaturesLoadedImplCopyWith<$Res> {
  factory _$$CategoryFeaturesLoadedImplCopyWith(
    _$CategoryFeaturesLoadedImpl value,
    $Res Function(_$CategoryFeaturesLoadedImpl) then,
  ) = __$$CategoryFeaturesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String categoryUuid, List<CategoryFeature> features});
}

/// @nodoc
class __$$CategoryFeaturesLoadedImplCopyWithImpl<$Res>
    extends _$CategoryStateCopyWithImpl<$Res, _$CategoryFeaturesLoadedImpl>
    implements _$$CategoryFeaturesLoadedImplCopyWith<$Res> {
  __$$CategoryFeaturesLoadedImplCopyWithImpl(
    _$CategoryFeaturesLoadedImpl _value,
    $Res Function(_$CategoryFeaturesLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categoryUuid = null, Object? features = null}) {
    return _then(
      _$CategoryFeaturesLoadedImpl(
        categoryUuid:
            null == categoryUuid
                ? _value.categoryUuid
                : categoryUuid // ignore: cast_nullable_to_non_nullable
                    as String,
        features:
            null == features
                ? _value._features
                : features // ignore: cast_nullable_to_non_nullable
                    as List<CategoryFeature>,
      ),
    );
  }
}

/// @nodoc

class _$CategoryFeaturesLoadedImpl implements CategoryFeaturesLoaded {
  const _$CategoryFeaturesLoadedImpl({
    required this.categoryUuid,
    required final List<CategoryFeature> features,
  }) : _features = features;

  @override
  final String categoryUuid;
  final List<CategoryFeature> _features;
  @override
  List<CategoryFeature> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  String toString() {
    return 'CategoryState.featuresLoaded(categoryUuid: $categoryUuid, features: $features)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryFeaturesLoadedImpl &&
            (identical(other.categoryUuid, categoryUuid) ||
                other.categoryUuid == categoryUuid) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryUuid,
    const DeepCollectionEquality().hash(_features),
  );

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryFeaturesLoadedImplCopyWith<_$CategoryFeaturesLoadedImpl>
  get copyWith =>
      __$$CategoryFeaturesLoadedImplCopyWithImpl<_$CategoryFeaturesLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Category> categories) loaded,
    required TResult Function(NetworkFailure failure) failure,
    required TResult Function(
      String categoryUuid,
      List<CategoryFeature> features,
    )
    featuresLoaded,
    required TResult Function(String categoryUuid) featuresLoading,
  }) {
    return featuresLoaded(categoryUuid, features);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Category> categories)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
    TResult? Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult? Function(String categoryUuid)? featuresLoading,
  }) {
    return featuresLoaded?.call(categoryUuid, features);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Category> categories)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    TResult Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult Function(String categoryUuid)? featuresLoading,
    required TResult orElse(),
  }) {
    if (featuresLoaded != null) {
      return featuresLoaded(categoryUuid, features);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryInitial value) initial,
    required TResult Function(CategoryLoading value) loading,
    required TResult Function(CategoryLoaded value) loaded,
    required TResult Function(CategoryFailure value) failure,
    required TResult Function(CategoryFeaturesLoaded value) featuresLoaded,
    required TResult Function(CategoryFeaturesLoading value) featuresLoading,
  }) {
    return featuresLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryInitial value)? initial,
    TResult? Function(CategoryLoading value)? loading,
    TResult? Function(CategoryLoaded value)? loaded,
    TResult? Function(CategoryFailure value)? failure,
    TResult? Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult? Function(CategoryFeaturesLoading value)? featuresLoading,
  }) {
    return featuresLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryInitial value)? initial,
    TResult Function(CategoryLoading value)? loading,
    TResult Function(CategoryLoaded value)? loaded,
    TResult Function(CategoryFailure value)? failure,
    TResult Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult Function(CategoryFeaturesLoading value)? featuresLoading,
    required TResult orElse(),
  }) {
    if (featuresLoaded != null) {
      return featuresLoaded(this);
    }
    return orElse();
  }
}

abstract class CategoryFeaturesLoaded implements CategoryState {
  const factory CategoryFeaturesLoaded({
    required final String categoryUuid,
    required final List<CategoryFeature> features,
  }) = _$CategoryFeaturesLoadedImpl;

  String get categoryUuid;
  List<CategoryFeature> get features;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryFeaturesLoadedImplCopyWith<_$CategoryFeaturesLoadedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CategoryFeaturesLoadingImplCopyWith<$Res> {
  factory _$$CategoryFeaturesLoadingImplCopyWith(
    _$CategoryFeaturesLoadingImpl value,
    $Res Function(_$CategoryFeaturesLoadingImpl) then,
  ) = __$$CategoryFeaturesLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String categoryUuid});
}

/// @nodoc
class __$$CategoryFeaturesLoadingImplCopyWithImpl<$Res>
    extends _$CategoryStateCopyWithImpl<$Res, _$CategoryFeaturesLoadingImpl>
    implements _$$CategoryFeaturesLoadingImplCopyWith<$Res> {
  __$$CategoryFeaturesLoadingImplCopyWithImpl(
    _$CategoryFeaturesLoadingImpl _value,
    $Res Function(_$CategoryFeaturesLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categoryUuid = null}) {
    return _then(
      _$CategoryFeaturesLoadingImpl(
        null == categoryUuid
            ? _value.categoryUuid
            : categoryUuid // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$CategoryFeaturesLoadingImpl implements CategoryFeaturesLoading {
  const _$CategoryFeaturesLoadingImpl(this.categoryUuid);

  @override
  final String categoryUuid;

  @override
  String toString() {
    return 'CategoryState.featuresLoading(categoryUuid: $categoryUuid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryFeaturesLoadingImpl &&
            (identical(other.categoryUuid, categoryUuid) ||
                other.categoryUuid == categoryUuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categoryUuid);

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryFeaturesLoadingImplCopyWith<_$CategoryFeaturesLoadingImpl>
  get copyWith => __$$CategoryFeaturesLoadingImplCopyWithImpl<
    _$CategoryFeaturesLoadingImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Category> categories) loaded,
    required TResult Function(NetworkFailure failure) failure,
    required TResult Function(
      String categoryUuid,
      List<CategoryFeature> features,
    )
    featuresLoaded,
    required TResult Function(String categoryUuid) featuresLoading,
  }) {
    return featuresLoading(categoryUuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Category> categories)? loaded,
    TResult? Function(NetworkFailure failure)? failure,
    TResult? Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult? Function(String categoryUuid)? featuresLoading,
  }) {
    return featuresLoading?.call(categoryUuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Category> categories)? loaded,
    TResult Function(NetworkFailure failure)? failure,
    TResult Function(String categoryUuid, List<CategoryFeature> features)?
    featuresLoaded,
    TResult Function(String categoryUuid)? featuresLoading,
    required TResult orElse(),
  }) {
    if (featuresLoading != null) {
      return featuresLoading(categoryUuid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CategoryInitial value) initial,
    required TResult Function(CategoryLoading value) loading,
    required TResult Function(CategoryLoaded value) loaded,
    required TResult Function(CategoryFailure value) failure,
    required TResult Function(CategoryFeaturesLoaded value) featuresLoaded,
    required TResult Function(CategoryFeaturesLoading value) featuresLoading,
  }) {
    return featuresLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CategoryInitial value)? initial,
    TResult? Function(CategoryLoading value)? loading,
    TResult? Function(CategoryLoaded value)? loaded,
    TResult? Function(CategoryFailure value)? failure,
    TResult? Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult? Function(CategoryFeaturesLoading value)? featuresLoading,
  }) {
    return featuresLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CategoryInitial value)? initial,
    TResult Function(CategoryLoading value)? loading,
    TResult Function(CategoryLoaded value)? loaded,
    TResult Function(CategoryFailure value)? failure,
    TResult Function(CategoryFeaturesLoaded value)? featuresLoaded,
    TResult Function(CategoryFeaturesLoading value)? featuresLoading,
    required TResult orElse(),
  }) {
    if (featuresLoading != null) {
      return featuresLoading(this);
    }
    return orElse();
  }
}

abstract class CategoryFeaturesLoading implements CategoryState {
  const factory CategoryFeaturesLoading(final String categoryUuid) =
      _$CategoryFeaturesLoadingImpl;

  String get categoryUuid;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryFeaturesLoadingImplCopyWith<_$CategoryFeaturesLoadingImpl>
  get copyWith => throw _privateConstructorUsedError;
}
