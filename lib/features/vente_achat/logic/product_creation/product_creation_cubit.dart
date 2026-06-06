import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../data/repositories/repo_utils.dart';
import '../../data/sources/product_creation_remote_source.dart';
import '../../domain/models/product_creation_data.dart';

// ─── États (plain Dart — pas de Freezed) ─────────────────────────────────────

sealed class ProductCreationState {}

class ProductCreationInitial extends ProductCreationState {}

class ProductCreationLoading extends ProductCreationState {}

class ProductCreationSuccess extends ProductCreationState {
  final String  productId;
  final String  productName;
  final String  categoryUuid;
  final String  productStatus;
  final String? productBannerUrl;
  ProductCreationSuccess({
    required this.productId,
    required this.productName,
    required this.categoryUuid,
    this.productStatus     = 'active',
    this.productBannerUrl,
  });

  bool get isDraft => productStatus == 'draft' ||
      productStatus == 'pending' ||
      productStatus == 'pending_review';
}

class ProductCreationFailure extends ProductCreationState {
  final String message;
  ProductCreationFailure(this.message);
}

class ProductUpdateSuccess extends ProductCreationState {
  final String productUuid;
  ProductUpdateSuccess(this.productUuid);
}

class ProductDeleteSuccess extends ProductCreationState {
  final String productUuid;
  ProductDeleteSuccess(this.productUuid);
}

// ─── Cubit ────────────────────────────────────────────────────────────────────

@injectable
class ProductCreationCubit extends Cubit<ProductCreationState> {
  final ProductCreationRemoteSource _source;
  ProductCreationCubit(this._source) : super(ProductCreationInitial());

  Future<void> create(ProductCreationData data) async {
    emit(ProductCreationLoading());
    try {
      final result = await _source.createProduct(data);
      emit(ProductCreationSuccess(
        productId:        result['uuid']?.toString() ?? result['id']?.toString() ?? '',
        productName:      result['name']?.toString() ?? data.name,
        categoryUuid:     result['category_uuid']?.toString() ?? data.categoryUuid,
        productStatus:    result['status']?.toString() ?? 'draft',
        productBannerUrl: result['banner_url']?.toString(),
      ));
    } on DioException catch (e) {
      emit(ProductCreationFailure(toNetworkFailure(e).toMsg));
    } catch (e) {
      emit(ProductCreationFailure('Une erreur est survenue. Réessayez.'));
    }
  }

  Future<void> update({
    required String productUuid,
    required Map<String, dynamic> fields,
  }) async {
    emit(ProductCreationLoading());
    try {
      await _source.updateProduct(productUuid: productUuid, fields: fields);
      emit(ProductUpdateSuccess(productUuid));
    } on DioException catch (e) {
      emit(ProductCreationFailure(toNetworkFailure(e).toMsg));
    } catch (_) {
      emit(ProductCreationFailure('Une erreur est survenue. Réessayez.'));
    }
  }

  Future<void> delete({required String productUuid}) async {
    emit(ProductCreationLoading());
    try {
      await _source.deleteProduct(productUuid: productUuid);
      emit(ProductDeleteSuccess(productUuid));
    } on DioException catch (e) {
      emit(ProductCreationFailure(toNetworkFailure(e).toMsg));
    } catch (_) {
      emit(ProductCreationFailure('Une erreur est survenue. Réessayez.'));
    }
  }

  void reset() => emit(ProductCreationInitial());
}
