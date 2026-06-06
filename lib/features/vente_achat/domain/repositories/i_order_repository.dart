import 'package:dartz/dartz.dart' hide Order;
import '../../../../core/utils/failures.dart';
import '../models/export.dart';

abstract class IOrderRepository {
  Future<Either<NetworkFailure, PageResult<Order>>> getOrders({int page = 1, int limit = 20});
  Future<Either<NetworkFailure, List<Order>>> checkout({
    String? note,
    Map<String, dynamic>? shippingAddress,
  });
  Future<Either<NetworkFailure, Order>> buyNow({
    required String productUuid,
    int quantity = 1,
    String? note,
    Map<String, dynamic>? shippingAddress,
  });

  Future<Either<NetworkFailure, Order>> deliverOrder({required String orderUuid});
  
  Future<Either<NetworkFailure, PageResult<Order>>> getVendorOrders({int page = 1, int limit = 50});
}
