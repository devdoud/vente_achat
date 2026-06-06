import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required String uuid,
    required String name,
    required int    position,
    String? slug,
    String? icon,
    @Default([]) List<Category> children,
  }) = _Category;
}

@freezed
class CategoryFeature with _$CategoryFeature {
  const factory CategoryFeature({
    required String code,
    required String name,
    required String type,
    String? unit,
    Map<String, dynamic>? valueConfig,
    @Default(false) bool isRequired,
    @Default(0) int position,
  }) = _CategoryFeature;

  const CategoryFeature._();

  /// Options disponibles si type = 'select' ou 'multiselect'
  List<String> get selectOptions {
    final opts = valueConfig?['options'];
    if (opts is List) return opts.map((e) => e.toString()).toList();
    return [];
  }

  bool get isNumeric => type == 'number' || type == 'integer';
  bool get isBoolean => type == 'boolean';
  bool get isSelect  => type == 'select' || type == 'multiselect';
}
