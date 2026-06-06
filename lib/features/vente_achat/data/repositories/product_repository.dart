import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../domain/models/export.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../sources/product_remote_source.dart';
import 'repo_utils.dart';

@LazySingleton(as: IProductRepository)
class ProductRepository implements IProductRepository {
  final ProductRemoteSource _source;
  ProductRepository(this._source);

  @override
  Future<Either<NetworkFailure, PageResult<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    String? query,
    String? categoryUuid,
    String? shopUuid,
    int? minPrice,
    int? maxPrice,
    bool? available,
  }) async {
    try {
      final dto = await _source.getProducts(
        page: page, limit: limit, query: query,
        categoryUuid: categoryUuid, shopUuid: shopUuid,
        minPrice: minPrice, maxPrice: maxPrice, available: available,
      );
      return right(PageResult(
        items: dto.items.map((e) => e.toDomain()).toList(),
        totalCount: dto.totalCount,
        numItemsPerPage: dto.numItemsPerPage,
        currentPageNumber: dto.currentPageNumber,
        nextPageNumber: dto.nextPageNumber,
      ));
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Product>> getProduct(String uuid) async {
    try {
      return right((await _source.getProduct(uuid)).toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, PageResult<Product>>> getVendorProducts() async {
    try {
      final dto = await _source.getVendorProducts();
      return right(PageResult(
        items: dto.items.map((e) => e.toDomain()).toList(),
        totalCount: dto.totalCount,
        numItemsPerPage: dto.numItemsPerPage,
        currentPageNumber: dto.currentPageNumber,
        nextPageNumber: dto.nextPageNumber,
      ));
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, PageResult<Product>>> getShopProducts(String shopUuid) async {
    try {
      final dto = await _source.getShopProducts(shopUuid);
      return right(PageResult(
        items: dto.items.map((e) => e.toDomain()).toList(),
        totalCount: dto.totalCount,
        numItemsPerPage: dto.numItemsPerPage,
        currentPageNumber: dto.currentPageNumber,
        nextPageNumber: dto.nextPageNumber,
      ));
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, void>> deleteProduct(String uuid) async {
    try {
      await _source.deleteProduct(uuid);
      return right(null);
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }
}
