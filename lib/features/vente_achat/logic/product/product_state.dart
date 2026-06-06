import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/export.dart';
import '../../../../core/utils/failures.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = ProductInitial;
  const factory ProductState.loading() = ProductLoading;
  const factory ProductState.loaded({
    required List<Product> products,
    required int currentPage,
    required bool hasMore,
  }) = ProductLoaded;
  const factory ProductState.detail(Product product) = ProductDetail;
  const factory ProductState.failure(NetworkFailure failure) = ProductFailure;
}
