import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String uuid,          // UUID de l'article panier (pour update/delete)
    required int    quantity,
    required int    unitPrice,
    required int    subtotal,
    required String productUuid,
    required String productName,
    required int    effectivePrice,
    required int    stock,
    @Default(false) bool purchasable,
    String? merchantName,
  }) = _CartItem;

  const CartItem._();

  String get formattedUnitPrice  => _fmt(unitPrice);
  String get formattedSubtotal   => _fmt(subtotal);

  static String _fmt(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M F';
    if (v >= 1000) {
      final e = v ~/ 1000;
      final r = v % 1000;
      return r == 0 ? '$e 000 F' : '$e ${r.toString().padLeft(3, '0')} F';
    }
    return '$v F';
  }
}

@freezed
class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    required String          uuid,
    @Default([]) List<CartItem> items,
    @Default(0) int          itemCount,
    @Default(0) int          total,
    String?                  updatedAt,
  }) = _Cart;

  bool get isEmpty => itemCount == 0;

  String get formattedTotal {
    if (total >= 1000000) return '${(total / 1000000).toStringAsFixed(1)}M F';
    if (total >= 1000) {
      final e = total ~/ 1000;
      final r = total % 1000;
      return r == 0 ? '$e 000 F' : '$e ${r.toString().padLeft(3, '0')} F';
    }
    return '$total F';
  }
}
