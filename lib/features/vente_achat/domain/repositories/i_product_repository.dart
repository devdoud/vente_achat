import 'package:dartz/dartz.dart';
import '../../../../core/utils/failures.dart';
import '../models/export.dart';

abstract class IProductRepository {
  Future<Either<NetworkFailure, PageResult<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    String? query,
    String? categoryUuid,
    String? shopUuid,
    int? minPrice,
    int? maxPrice,
    bool? available,
  });

  Future<Either<NetworkFailure, Product>> getProduct(String uuid);

  Future<Either<NetworkFailure, PageResult<Product>>> getVendorProducts();
  Future<Either<NetworkFailure, PageResult<Product>>> getShopProducts(String shopUuid);
  
  Future<Either<NetworkFailure, void>> deleteProduct(String uuid);
}
