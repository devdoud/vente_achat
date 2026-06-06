import '../../domain/models/export.dart';

class CategoryDto {
  final String  uuid;
  final String  name;
  final String? slug;
  final String? icon;
  final int     position;
  final List<CategoryDto> children;

  const CategoryDto({
    required this.uuid,
    required this.name,
    this.slug,
    this.icon,
    required this.position,
    this.children = const [],
  });

  factory CategoryDto.fromJson(Map<String, dynamic> j) => CategoryDto(
        uuid:     j['uuid']     as String? ?? '',
        name:     j['name']     as String? ?? '',
        slug:     j['slug']     as String?,
        icon:     j['icon']     as String?,
        position: (j['position'] as num?)?.toInt() ?? 0,
        children: (j['children'] as List?)
                ?.map((c) => CategoryDto.fromJson(c as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Category toDomain() => Category(
        uuid:     uuid,
        name:     name,
        slug:     slug,
        icon:     icon,
        position: position,
        children: children.map((c) => c.toDomain()).toList(),
      );
}

class CategoryFeatureDto {
  final String  code;
  final String  name;
  final String  type;
  final String? unit;
  final Map<String, dynamic>? valueConfig;
  final bool    isRequired;
  final int     position;

  const CategoryFeatureDto({
    required this.code,
    required this.name,
    required this.type,
    this.unit,
    this.valueConfig,
    this.isRequired = false,
    this.position   = 0,
  });

  factory CategoryFeatureDto.fromJson(Map<String, dynamic> j) =>
      CategoryFeatureDto(
        code:        j['code']        as String? ?? '',
        name:        j['name']        as String? ?? '',
        type:        j['type']        as String? ?? '',
        unit:        j['unit']        as String?,
        valueConfig: j['value_config'] as Map<String, dynamic>?,
        isRequired:  j['is_required'] as bool? ?? false,
        position:    (j['position']   as num?)?.toInt() ?? 0,
      );

  CategoryFeature toDomain() => CategoryFeature(
        code:        code,
        name:        name,
        type:        type,
        unit:        unit,
        valueConfig: valueConfig,
        isRequired:  isRequired,
        position:    position,
      );
}
