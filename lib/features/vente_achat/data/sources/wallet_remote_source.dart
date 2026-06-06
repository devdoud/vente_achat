import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../dto/wallet_dto.dart';

@lazySingleton
class WalletRemoteSource {
  final ApiClient _client;
  WalletRemoteSource(this._client);

  /// Initie un rechargement — retourne l'URL de paiement externe
  Future<WalletTopUpDto> topUp({required double amount}) async {
    final resp = await _client.call().post('/api/wallet/top-up', data: {
      'amount': amount.toInt(),
    });
    return WalletTopUpDto.fromJson(resp.data as Map<String, dynamic>);
  }

  /// Solde actuel du wallet
  Future<WalletBalanceDto> getBalance() async {
    final resp = await _client.call().get('/api/wallet/balance');
    return WalletBalanceDto.fromJson(resp.data as Map<String, dynamic>);
  }

  /// Historique des transactions
  Future<List<WalletTransactionDto>> getTransactions() async {
    final resp = await _client.call().get('/api/wallet/transactions');
    final raw = resp.data;
    // Gère liste directe ou objet paginé {items: [...]}
    final list = raw is List ? raw : (raw as Map?)?['items'] as List? ?? [];
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => WalletTransactionDto.fromJson(e))
        .toList();
  }

  /// Blocages en cours (holds)
  Future<List<WalletHoldDto>> getHolds() async {
    final resp = await _client.call().get('/api/wallet/holds');
    final raw = resp.data;
    final list = raw is List ? raw : (raw as Map?)?['items'] as List? ?? [];
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => WalletHoldDto.fromJson(e))
        .toList();
  }
}
