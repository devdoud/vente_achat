import '../../domain/models/order_model.dart';

class OrderDto {
  final String       uuid;
  final String       status;
  final int          totalAmount;
  final String?      currency;
  final String?      note;
  final String?      merchantUuid;
  final String?      merchantName;
  final String?      deliveryCode;
  final List<String> itemUuids;
  final String       createdAt;
  final String?      updatedAt;

  const OrderDto({
    required this.uuid,
    required this.status,
    required this.totalAmount,
    this.currency,
    this.note,
    this.merchantUuid,
    this.merchantName,
    this.deliveryCode,
    this.itemUuids = const [],
    required this.createdAt,
    this.updatedAt,
  });

  factory OrderDto.fromJson(Map<String, dynamic> j) {
    final merchant = j['merchant'] as Map<String, dynamic>?;
    final rawItems = j['items']    as List?;
    return OrderDto(
      uuid:         j['uuid']          as String? ?? '',
      status:       j['status']        as String? ?? '',
      totalAmount:  (j['total_amount'] as num?)?.toInt()
                    ?? (j['total']     as num?)?.toInt() ?? 0,
      currency:     j['currency']      as String?,
      note:         j['note']          as String?,
      merchantUuid: merchant?['uuid']  as String?,
      merchantName: merchant?['name']  as String?,
      deliveryCode: j['delivery_code'] as String?,
      itemUuids:    rawItems?.map((e) => e.toString()).toList() ?? [],
      createdAt:    j['created_at']    as String? ?? '',
      updatedAt:    j['updated_at']    as String?,
    );
  }

  Order toDomain() => Order(
        uuid:         uuid,
        status:       status,
        totalAmount:  totalAmount,
        currency:     currency,
        note:         note,
        merchantUuid: merchantUuid,
        merchantName: merchantName,
        deliveryCode: deliveryCode,
        itemUuids:    itemUuids,
        createdAt:    DateTime.tryParse(createdAt) ?? DateTime.now(),
        updatedAt:    updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
      );
}
