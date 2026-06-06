import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/export.dart';
import '../../../../core/utils/failures.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial()                                          = CategoryInitial;
  const factory CategoryState.loading()                                          = CategoryLoading;
  const factory CategoryState.loaded(List<Category> categories)                 = CategoryLoaded;
  const factory CategoryState.failure(NetworkFailure failure)                   = CategoryFailure;
  /// État émis quand les features d'une catégorie spécifique sont chargées
  const factory CategoryState.featuresLoaded({
    required String               categoryUuid,
    required List<CategoryFeature> features,
  }) = CategoryFeaturesLoaded;
  const factory CategoryState.featuresLoading(String categoryUuid)              = CategoryFeaturesLoading;
}
