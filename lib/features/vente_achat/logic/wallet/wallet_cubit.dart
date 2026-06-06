import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../data/repositories/repo_utils.dart';
import '../../data/sources/wallet_remote_source.dart';
import '../../data/dto/wallet_dto.dart';
import 'wallet_state.dart';

@injectable
class WalletCubit extends Cubit<WalletState> {
  final WalletRemoteSource _source;
  WalletCubit(this._source) : super(const WalletState.initial());

  /// Charge solde + transactions + holds en parallèle
  Future<void> load() async {
    emit(const WalletState.loading());
    try {
      final results = await Future.wait([
        _source.getBalance(),
        _source.getTransactions(),
        _source.getHolds(),
      ]);
      emit(WalletState.loaded(
        balance:      results[0] as WalletBalanceDto,
        transactions: results[1] as List<WalletTransactionDto>,
        holds:        results[2] as List<WalletHoldDto>,
      ));
    } on DioException catch (e) {
      emit(WalletState.failure(toNetworkFailure(e)));
    } catch (_) {
      emit(const WalletState.failure(NetworkFailure.unexpectedError()));
    }
  }

  /// Initie un rechargement — émet l'URL de paiement à ouvrir
  Future<void> topUp({required double amount}) async {
    emit(const WalletState.loading());
    try {
      final dto = await _source.topUp(amount: amount);
      final url = dto.paymentUrl;
      if (url == null || url.isEmpty) {
        emit(const WalletState.failure(
            NetworkFailure.failure('URL de paiement introuvable')));
        return;
      }
      emit(WalletState.topUpReady(paymentUrl: url, amount: amount));
    } on DioException catch (e) {
      emit(WalletState.failure(toNetworkFailure(e)));
    } catch (_) {
      emit(const WalletState.failure(NetworkFailure.unexpectedError()));
    }
  }
}
