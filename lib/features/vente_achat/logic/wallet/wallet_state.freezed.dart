// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WalletState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )
    loaded,
    required TResult Function(String paymentUrl, double amount) topUpReady,
    required TResult Function(NetworkFailure failure) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult? Function(String paymentUrl, double amount)? topUpReady,
    TResult? Function(NetworkFailure failure)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult Function(String paymentUrl, double amount)? topUpReady,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletInitial value) initial,
    required TResult Function(WalletLoading value) loading,
    required TResult Function(WalletLoaded value) loaded,
    required TResult Function(WalletTopUpReady value) topUpReady,
    required TResult Function(WalletFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletInitial value)? initial,
    TResult? Function(WalletLoading value)? loading,
    TResult? Function(WalletLoaded value)? loaded,
    TResult? Function(WalletTopUpReady value)? topUpReady,
    TResult? Function(WalletFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletInitial value)? initial,
    TResult Function(WalletLoading value)? loading,
    TResult Function(WalletLoaded value)? loaded,
    TResult Function(WalletTopUpReady value)? topUpReady,
    TResult Function(WalletFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
    WalletState value,
    $Res Function(WalletState) then,
  ) = _$WalletStateCopyWithImpl<$Res, WalletState>;
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$WalletInitialImplCopyWith<$Res> {
  factory _$$WalletInitialImplCopyWith(
    _$WalletInitialImpl value,
    $Res Function(_$WalletInitialImpl) then,
  ) = __$$WalletInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WalletInitialImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletInitialImpl>
    implements _$$WalletInitialImplCopyWith<$Res> {
  __$$WalletInitialImplCopyWithImpl(
    _$WalletInitialImpl _value,
    $Res Function(_$WalletInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WalletInitialImpl implements WalletInitial {
  const _$WalletInitialImpl();

  @override
  String toString() {
    return 'WalletState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WalletInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )
    loaded,
    required TResult Function(String paymentUrl, double amount) topUpReady,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult? Function(String paymentUrl, double amount)? topUpReady,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult Function(String paymentUrl, double amount)? topUpReady,
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
    required TResult Function(WalletInitial value) initial,
    required TResult Function(WalletLoading value) loading,
    required TResult Function(WalletLoaded value) loaded,
    required TResult Function(WalletTopUpReady value) topUpReady,
    required TResult Function(WalletFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletInitial value)? initial,
    TResult? Function(WalletLoading value)? loading,
    TResult? Function(WalletLoaded value)? loaded,
    TResult? Function(WalletTopUpReady value)? topUpReady,
    TResult? Function(WalletFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletInitial value)? initial,
    TResult Function(WalletLoading value)? loading,
    TResult Function(WalletLoaded value)? loaded,
    TResult Function(WalletTopUpReady value)? topUpReady,
    TResult Function(WalletFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class WalletInitial implements WalletState {
  const factory WalletInitial() = _$WalletInitialImpl;
}

/// @nodoc
abstract class _$$WalletLoadingImplCopyWith<$Res> {
  factory _$$WalletLoadingImplCopyWith(
    _$WalletLoadingImpl value,
    $Res Function(_$WalletLoadingImpl) then,
  ) = __$$WalletLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WalletLoadingImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletLoadingImpl>
    implements _$$WalletLoadingImplCopyWith<$Res> {
  __$$WalletLoadingImplCopyWithImpl(
    _$WalletLoadingImpl _value,
    $Res Function(_$WalletLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WalletLoadingImpl implements WalletLoading {
  const _$WalletLoadingImpl();

  @override
  String toString() {
    return 'WalletState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WalletLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )
    loaded,
    required TResult Function(String paymentUrl, double amount) topUpReady,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult? Function(String paymentUrl, double amount)? topUpReady,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult Function(String paymentUrl, double amount)? topUpReady,
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
    required TResult Function(WalletInitial value) initial,
    required TResult Function(WalletLoading value) loading,
    required TResult Function(WalletLoaded value) loaded,
    required TResult Function(WalletTopUpReady value) topUpReady,
    required TResult Function(WalletFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletInitial value)? initial,
    TResult? Function(WalletLoading value)? loading,
    TResult? Function(WalletLoaded value)? loaded,
    TResult? Function(WalletTopUpReady value)? topUpReady,
    TResult? Function(WalletFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletInitial value)? initial,
    TResult Function(WalletLoading value)? loading,
    TResult Function(WalletLoaded value)? loaded,
    TResult Function(WalletTopUpReady value)? topUpReady,
    TResult Function(WalletFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class WalletLoading implements WalletState {
  const factory WalletLoading() = _$WalletLoadingImpl;
}

/// @nodoc
abstract class _$$WalletLoadedImplCopyWith<$Res> {
  factory _$$WalletLoadedImplCopyWith(
    _$WalletLoadedImpl value,
    $Res Function(_$WalletLoadedImpl) then,
  ) = __$$WalletLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    WalletBalanceDto balance,
    List<WalletTransactionDto> transactions,
    List<WalletHoldDto> holds,
  });
}

/// @nodoc
class __$$WalletLoadedImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletLoadedImpl>
    implements _$$WalletLoadedImplCopyWith<$Res> {
  __$$WalletLoadedImplCopyWithImpl(
    _$WalletLoadedImpl _value,
    $Res Function(_$WalletLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? transactions = null,
    Object? holds = null,
  }) {
    return _then(
      _$WalletLoadedImpl(
        balance:
            null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                    as WalletBalanceDto,
        transactions:
            null == transactions
                ? _value._transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                    as List<WalletTransactionDto>,
        holds:
            null == holds
                ? _value._holds
                : holds // ignore: cast_nullable_to_non_nullable
                    as List<WalletHoldDto>,
      ),
    );
  }
}

/// @nodoc

class _$WalletLoadedImpl implements WalletLoaded {
  const _$WalletLoadedImpl({
    required this.balance,
    final List<WalletTransactionDto> transactions = const [],
    final List<WalletHoldDto> holds = const [],
  }) : _transactions = transactions,
       _holds = holds;

  @override
  final WalletBalanceDto balance;
  final List<WalletTransactionDto> _transactions;
  @override
  @JsonKey()
  List<WalletTransactionDto> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  final List<WalletHoldDto> _holds;
  @override
  @JsonKey()
  List<WalletHoldDto> get holds {
    if (_holds is EqualUnmodifiableListView) return _holds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holds);
  }

  @override
  String toString() {
    return 'WalletState.loaded(balance: $balance, transactions: $transactions, holds: $holds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletLoadedImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ) &&
            const DeepCollectionEquality().equals(other._holds, _holds));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    balance,
    const DeepCollectionEquality().hash(_transactions),
    const DeepCollectionEquality().hash(_holds),
  );

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletLoadedImplCopyWith<_$WalletLoadedImpl> get copyWith =>
      __$$WalletLoadedImplCopyWithImpl<_$WalletLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )
    loaded,
    required TResult Function(String paymentUrl, double amount) topUpReady,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return loaded(balance, transactions, holds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult? Function(String paymentUrl, double amount)? topUpReady,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return loaded?.call(balance, transactions, holds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult Function(String paymentUrl, double amount)? topUpReady,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(balance, transactions, holds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletInitial value) initial,
    required TResult Function(WalletLoading value) loading,
    required TResult Function(WalletLoaded value) loaded,
    required TResult Function(WalletTopUpReady value) topUpReady,
    required TResult Function(WalletFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletInitial value)? initial,
    TResult? Function(WalletLoading value)? loading,
    TResult? Function(WalletLoaded value)? loaded,
    TResult? Function(WalletTopUpReady value)? topUpReady,
    TResult? Function(WalletFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletInitial value)? initial,
    TResult Function(WalletLoading value)? loading,
    TResult Function(WalletLoaded value)? loaded,
    TResult Function(WalletTopUpReady value)? topUpReady,
    TResult Function(WalletFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class WalletLoaded implements WalletState {
  const factory WalletLoaded({
    required final WalletBalanceDto balance,
    final List<WalletTransactionDto> transactions,
    final List<WalletHoldDto> holds,
  }) = _$WalletLoadedImpl;

  WalletBalanceDto get balance;
  List<WalletTransactionDto> get transactions;
  List<WalletHoldDto> get holds;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletLoadedImplCopyWith<_$WalletLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WalletTopUpReadyImplCopyWith<$Res> {
  factory _$$WalletTopUpReadyImplCopyWith(
    _$WalletTopUpReadyImpl value,
    $Res Function(_$WalletTopUpReadyImpl) then,
  ) = __$$WalletTopUpReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String paymentUrl, double amount});
}

/// @nodoc
class __$$WalletTopUpReadyImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletTopUpReadyImpl>
    implements _$$WalletTopUpReadyImplCopyWith<$Res> {
  __$$WalletTopUpReadyImplCopyWithImpl(
    _$WalletTopUpReadyImpl _value,
    $Res Function(_$WalletTopUpReadyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? paymentUrl = null, Object? amount = null}) {
    return _then(
      _$WalletTopUpReadyImpl(
        paymentUrl:
            null == paymentUrl
                ? _value.paymentUrl
                : paymentUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc

class _$WalletTopUpReadyImpl implements WalletTopUpReady {
  const _$WalletTopUpReadyImpl({
    required this.paymentUrl,
    required this.amount,
  });

  @override
  final String paymentUrl;
  @override
  final double amount;

  @override
  String toString() {
    return 'WalletState.topUpReady(paymentUrl: $paymentUrl, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletTopUpReadyImpl &&
            (identical(other.paymentUrl, paymentUrl) ||
                other.paymentUrl == paymentUrl) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paymentUrl, amount);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletTopUpReadyImplCopyWith<_$WalletTopUpReadyImpl> get copyWith =>
      __$$WalletTopUpReadyImplCopyWithImpl<_$WalletTopUpReadyImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )
    loaded,
    required TResult Function(String paymentUrl, double amount) topUpReady,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return topUpReady(paymentUrl, amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult? Function(String paymentUrl, double amount)? topUpReady,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return topUpReady?.call(paymentUrl, amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult Function(String paymentUrl, double amount)? topUpReady,
    TResult Function(NetworkFailure failure)? failure,
    required TResult orElse(),
  }) {
    if (topUpReady != null) {
      return topUpReady(paymentUrl, amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletInitial value) initial,
    required TResult Function(WalletLoading value) loading,
    required TResult Function(WalletLoaded value) loaded,
    required TResult Function(WalletTopUpReady value) topUpReady,
    required TResult Function(WalletFailure value) failure,
  }) {
    return topUpReady(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletInitial value)? initial,
    TResult? Function(WalletLoading value)? loading,
    TResult? Function(WalletLoaded value)? loaded,
    TResult? Function(WalletTopUpReady value)? topUpReady,
    TResult? Function(WalletFailure value)? failure,
  }) {
    return topUpReady?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletInitial value)? initial,
    TResult Function(WalletLoading value)? loading,
    TResult Function(WalletLoaded value)? loaded,
    TResult Function(WalletTopUpReady value)? topUpReady,
    TResult Function(WalletFailure value)? failure,
    required TResult orElse(),
  }) {
    if (topUpReady != null) {
      return topUpReady(this);
    }
    return orElse();
  }
}

abstract class WalletTopUpReady implements WalletState {
  const factory WalletTopUpReady({
    required final String paymentUrl,
    required final double amount,
  }) = _$WalletTopUpReadyImpl;

  String get paymentUrl;
  double get amount;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletTopUpReadyImplCopyWith<_$WalletTopUpReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WalletFailureImplCopyWith<$Res> {
  factory _$$WalletFailureImplCopyWith(
    _$WalletFailureImpl value,
    $Res Function(_$WalletFailureImpl) then,
  ) = __$$WalletFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkFailure failure});

  $NetworkFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$WalletFailureImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletFailureImpl>
    implements _$$WalletFailureImplCopyWith<$Res> {
  __$$WalletFailureImplCopyWithImpl(
    _$WalletFailureImpl _value,
    $Res Function(_$WalletFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$WalletFailureImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as NetworkFailure,
      ),
    );
  }

  /// Create a copy of WalletState
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

class _$WalletFailureImpl implements WalletFailure {
  const _$WalletFailureImpl(this.failure);

  @override
  final NetworkFailure failure;

  @override
  String toString() {
    return 'WalletState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletFailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletFailureImplCopyWith<_$WalletFailureImpl> get copyWith =>
      __$$WalletFailureImplCopyWithImpl<_$WalletFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )
    loaded,
    required TResult Function(String paymentUrl, double amount) topUpReady,
    required TResult Function(NetworkFailure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult? Function(String paymentUrl, double amount)? topUpReady,
    TResult? Function(NetworkFailure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      WalletBalanceDto balance,
      List<WalletTransactionDto> transactions,
      List<WalletHoldDto> holds,
    )?
    loaded,
    TResult Function(String paymentUrl, double amount)? topUpReady,
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
    required TResult Function(WalletInitial value) initial,
    required TResult Function(WalletLoading value) loading,
    required TResult Function(WalletLoaded value) loaded,
    required TResult Function(WalletTopUpReady value) topUpReady,
    required TResult Function(WalletFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletInitial value)? initial,
    TResult? Function(WalletLoading value)? loading,
    TResult? Function(WalletLoaded value)? loaded,
    TResult? Function(WalletTopUpReady value)? topUpReady,
    TResult? Function(WalletFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletInitial value)? initial,
    TResult Function(WalletLoading value)? loading,
    TResult Function(WalletLoaded value)? loaded,
    TResult Function(WalletTopUpReady value)? topUpReady,
    TResult Function(WalletFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class WalletFailure implements WalletState {
  const factory WalletFailure(final NetworkFailure failure) =
      _$WalletFailureImpl;

  NetworkFailure get failure;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletFailureImplCopyWith<_$WalletFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
