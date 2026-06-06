class ShopDto {
  final String  uuid;
  final String  name;
  final String? description;
  final String? logo;
  final String  status;
  final double? avgRating;
  final int?    reviewCount;
  final String? createdAt;

  const ShopDto({
    required this.uuid,
    required this.name,
    this.description,
    this.logo,
    required this.status,
    this.avgRating,
    this.reviewCount,
    this.createdAt,
  });

  factory ShopDto.fromJson(Map<String, dynamic> j) => ShopDto(
        uuid:        j['uuid']         as String? ?? '',
        name:        j['name']         as String? ?? '',
        description: j['description']  as String?,
        logo:        j['logo']         as String?,
        status:      j['status']       as String? ?? 'active',
        avgRating:   (j['avg_rating']  as num?)?.toDouble(),
        reviewCount: j['review_count'] as int?,
        createdAt:   j['created_at']   as String?,
      );
}
