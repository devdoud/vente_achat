import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';

@freezed
class Order with _$Order {
  const Order._();

  const factory Order({
    required String       uuid,
    required String       status,
    required int          totalAmount,
    String?               currency,
    String?               note,
    String?               merchantUuid,
    String?               merchantName,
    String?               deliveryCode,
    @Default([]) List<String> itemUuids,
    required DateTime     createdAt,
    DateTime?             updatedAt,
  }) = _Order;

  String get formattedTotal {
    if (totalAmount >= 1000000) return '${(totalAmount / 1000000).toStringAsFixed(1)}M F';
    if (totalAmount >= 1000) {
      final e = totalAmount ~/ 1000;
      final r = totalAmount % 1000;
      return r == 0 ? '$e 000 F' : '$e ${r.toString().padLeft(3, '0')} F';
    }
    return '$totalAmount F';
  }

  String get shortRef => uuid.length >= 8 ? uuid.substring(0, 8).toUpperCase() : uuid.toUpperCase();

  /// Code de livraison 4 chiffres — depuis l'API ou dérivé de l'UUID
  List<String> get codeDigits {
    if (deliveryCode != null && deliveryCode!.isNotEmpty) {
      final d = deliveryCode!.replaceAll(RegExp(r'\D'), '');
      if (d.length >= 4) return d.substring(0, 4).split('');
      if (d.isNotEmpty) return d.padLeft(4, '0').split('');
    }
    final hex = uuid.replaceAll('-', '');
    if (hex.length >= 8) {
      final n = int.tryParse(hex.substring(0, 8), radix: 16) ?? 0;
      return (n % 10000).toString().padLeft(4, '0').split('');
    }
    return ['0', '0', '0', '0'];
  }
}
