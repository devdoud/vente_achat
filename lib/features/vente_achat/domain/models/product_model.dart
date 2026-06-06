import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    required String uuid,
    required String name,
    required int    price,
    int?    discountedPrice,
    required String description,
    required int    stock,
    required String status,
    required String categoryUuid,
    @Default('') String categoryName,
    required String shopUuid,
    String? shopName,
    String? shopLogo,
    double?   avgRating,
    int?      reviewCount,
    DateTime? createdAt,
    String?   bannerUrl,
    @Default([]) List<String> imageUrls,
    Map<String, dynamic>? features,
  }) = _Product;

  bool get isActive => status == 'active';
  bool get hasDiscount => discountedPrice != null;

  String get formattedPrice => _fmt(price);
  String? get formattedDiscountedPrice =>
      discountedPrice != null ? _fmt(discountedPrice!) : null;

  int? get discountPercent => discountedPrice != null
      ? (((price - discountedPrice!) / price) * 100).round()
      : null;

  static String _fmt(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M F';
    if (v >= 1000) {
      final e = v ~/ 1000;
      final r = (v % 1000);
      return r == 0 ? '$e 000 F' : '$e ${r.toString().padLeft(3, '0')} F';
    }
    return '$v F';
  }
}
