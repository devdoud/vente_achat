/// DTO de réponse du top-up — contient l'URL de paiement externe
class WalletTopUpDto {
  final Map<String, dynamic>? intent;
  final String? paymentUrl;

  const WalletTopUpDto({this.intent, this.paymentUrl});

  factory WalletTopUpDto.fromJson(Map<String, dynamic> j) => WalletTopUpDto(
        intent:     j['intent']      as Map<String, dynamic>?,
        paymentUrl: j['payment_url'] as String?,
      );
}

/// DTO du solde du wallet
class WalletBalanceDto {
  final double balance;
  final String? currency;

  const WalletBalanceDto({required this.balance, this.currency});

  factory WalletBalanceDto.fromJson(Map<String, dynamic> j) => WalletBalanceDto(
        balance:  (j['balance'] as num?)?.toDouble() ?? 0,
        currency: j['currency'] as String?,
      );
}

/// DTO d'une transaction wallet
class WalletTransactionDto {
  final String  uuid;
  final double  amount;
  final String  type;
  final String  status;
  final String? description;
  final String  createdAt;

  const WalletTransactionDto({
    required this.uuid,
    required this.amount,
    required this.type,
    required this.status,
    this.description,
    required this.createdAt,
  });

  factory WalletTransactionDto.fromJson(Map<String, dynamic> j) => WalletTransactionDto(
        uuid:        j['uuid']        as String? ?? '',
        amount:      (j['amount']     as num?)?.toDouble() ?? 0,
        type:        j['type']        as String? ?? '',
        status:      j['status']      as String? ?? '',
        description: j['description'] as String?,
        createdAt:   j['created_at']  as String? ?? '',
      );
}

/// DTO d'un hold (blocage) wallet
class WalletHoldDto {
  final String  uuid;
  final double  amount;
  final String  status;
  final String? reason;
  final String  createdAt;

  const WalletHoldDto({
    required this.uuid,
    required this.amount,
    required this.status,
    this.reason,
    required this.createdAt,
  });

  factory WalletHoldDto.fromJson(Map<String, dynamic> j) => WalletHoldDto(
        uuid:      j['uuid']       as String? ?? '',
        amount:    (j['amount']    as num?)?.toDouble() ?? 0,
        status:    j['status']     as String? ?? '',
        reason:    j['reason']     as String?,
        createdAt: j['created_at'] as String? ?? '',
      );
}
