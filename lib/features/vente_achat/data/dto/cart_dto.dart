import '../../domain/models/cart_model.dart';

class CartItemDto {
  final String uuid;       // UUID de l'article dans le panier (pour update/delete)
  final int    quantity;
  final int    unitPrice;
  final int    subtotal;
  final String productUuid;
  final String productName;
  final int    effectivePrice;
  final int    stock;
  final bool   purchasable;
  final String? merchantName;

  const CartItemDto({
    required this.uuid,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.productUuid,
    required this.productName,
    required this.effectivePrice,
    required this.stock,
    required this.purchasable,
    this.merchantName,
  });

  factory CartItemDto.fromJson(Map<String, dynamic> j) {
    final product  = j['product']  as Map<String, dynamic>?;
    final merchant = product?['merchant'] as Map<String, dynamic>?;
    return CartItemDto(
      uuid:           j['uuid']       as String? ?? '',
      quantity:       (j['quantity']  as num?)?.toInt() ?? 1,
      unitPrice:      (j['unit_price'] as num?)?.toInt() ?? 0,
      subtotal:       (j['subtotal']  as num?)?.toInt() ?? 0,
      productUuid:    product?['uuid'] as String? ?? '',
      productName:    product?['name'] as String? ?? '',
      effectivePrice: (product?['effective_price'] as num?)?.toInt() ?? 0,
      stock:          (product?['stock'] as num?)?.toInt() ?? 0,
      purchasable:    product?['purchasable'] as bool? ?? false,
      merchantName:   merchant?['name'] as String?,
    );
  }

  CartItem toDomain() => CartItem(
        uuid:           uuid,
        quantity:       quantity,
        unitPrice:      unitPrice,
        subtotal:       subtotal,
        productUuid:    productUuid,
        productName:    productName,
        effectivePrice: effectivePrice,
        stock:          stock,
        purchasable:    purchasable,
        merchantName:   merchantName,
      );
}

class CartDto {
  final String         uuid;
  final List<CartItemDto> items;
  final int            itemCount;
  final int            total;
  final String?        updatedAt;

  const CartDto({
    required this.uuid,
    required this.items,
    required this.itemCount,
    required this.total,
    this.updatedAt,
  });

  factory CartDto.fromJson(Map<String, dynamic> j) {
    final rawItems = j['items'] as List? ?? [];
    return CartDto(
      uuid:      j['uuid']       as String? ?? '',
      items:     rawItems
          .whereType<Map<String, dynamic>>()
          .map((e) => CartItemDto.fromJson(e))
          .toList(),
      itemCount: (j['item_count'] as num?)?.toInt() ?? 0,
      total:     (j['total']     as num?)?.toInt() ?? 0,
      updatedAt: j['updated_at'] as String?,
    );
  }

  Cart toDomain() => Cart(
        uuid:      uuid,
        items:     items.map((i) => i.toDomain()).toList(),
        itemCount: itemCount,
        total:     total,
        updatedAt: updatedAt,
      );
}
