import '../../domain/models/export.dart';

class ProductDto {
  final String  uuid;
  final String  name;
  final String  description;
  final int     price;
  final int?    discountedPrice;
  final int?    effectivePrice;
  final bool    inStock;
  final int     stock;
  final String  status;
  final String  categoryUuid;
  final String  categoryName;
  final String  shopUuid;
  final String? shopName;
  final String? shopLogo;
  final double? avgRating;
  final int?    reviewCount;
  final String? createdAt;
  final String? bannerUrl;
  final List<String> imageUrls;

  const ProductDto({
    required this.uuid,
    required this.name,
    required this.description,
    required this.price,
    this.discountedPrice,
    this.effectivePrice,
    required this.inStock,
    required this.stock,
    this.status = 'active',
    required this.categoryUuid,
    required this.categoryName,
    required this.shopUuid,
    this.shopName,
    this.shopLogo,
    this.avgRating,
    this.reviewCount,
    this.createdAt,
    this.bannerUrl,
    this.imageUrls = const [],
  });

  factory ProductDto.fromJson(Map<String, dynamic> j) {
    final cat         = j['category']    as Map<String, dynamic>?;
    final shop        = j['shop']        as Map<String, dynamic>?;
    final stockDetail = j['stock_detail'] as Map<String, dynamic>?;
    final banner      = j['banner']      as Map<String, dynamic>?;
    final images      = j['images']      as List?;

    return ProductDto(
      uuid:            j['uuid']         as String? ?? '',
      name:            j['name']         as String? ?? '',
      description:     j['description']  as String? ?? '',
      price:           (j['price']       as num?)?.toInt() ?? 0,
      discountedPrice: (j['discounted_price'] as num?)?.toInt(),
      effectivePrice:  (j['effective_price']  as num?)?.toInt(),
      inStock:         stockDetail?['in_stock'] as bool? ?? true,
      stock:           (stockDetail?['quantity'] as num?)?.toInt() ?? 0,
      status:          j['status']             as String? ?? 'active',
      categoryUuid:    cat?['uuid'] as String? ?? j['category_uuid'] as String? ?? '',
      categoryName:    cat?['name'] as String? ?? '',
      shopUuid:        shop?['uuid'] as String? ?? j['shop_uuid'] as String? ?? '',
      shopName:        shop?['name'] as String?,
      shopLogo:        shop?['logo'] as String?,
      avgRating:       (j['avg_rating']   as num?)?.toDouble(),
      reviewCount:     j['review_count']  as int?,
      createdAt:       j['created_at']    as String?,
      bannerUrl:       banner?['image']   as String?,
      imageUrls: images
              ?.whereType<Map>()
              .map((img) => img['image'] as String? ?? '')
              .where((s) => s.isNotEmpty)
              .toList() ??
          [],
    );
  }

  Product toDomain() => Product(
        uuid:            uuid,
        name:            name,
        price:           price,
        discountedPrice: discountedPrice,
        description:     description,
        stock:           stock,
        status:          status,
        categoryUuid:    categoryUuid,
        categoryName:    categoryName,
        shopUuid:        shopUuid,
        shopName:        shopName,
        shopLogo:        shopLogo,
        avgRating:       avgRating,
        reviewCount:     reviewCount,
        createdAt:       createdAt != null ? DateTime.tryParse(createdAt!) : null,
        bannerUrl:       bannerUrl,
        imageUrls:       imageUrls,
      );
}
