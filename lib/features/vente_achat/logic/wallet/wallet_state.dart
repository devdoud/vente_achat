import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/failures.dart';
import '../../data/dto/wallet_dto.dart';

part 'wallet_state.freezed.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial()                                   = WalletInitial;
  const factory WalletState.loading()                                   = WalletLoading;

  /// Données wallet chargées
  const factory WalletState.loaded({
    required WalletBalanceDto          balance,
    @Default([]) List<WalletTransactionDto> transactions,
    @Default([]) List<WalletHoldDto>        holds,
  }) = WalletLoaded;

  /// Top-up initié — payment_url à ouvrir dans WebView
  const factory WalletState.topUpReady({
    required String paymentUrl,
    required double amount,
  }) = WalletTopUpReady;

  const factory WalletState.failure(NetworkFailure failure) = WalletFailure;
}
