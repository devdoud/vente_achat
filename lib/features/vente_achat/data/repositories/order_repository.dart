import 'package:dartz/dartz.dart' hide Order;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' hide Order;
import '../../../../core/utils/failures.dart';
import '../../domain/models/export.dart';
import '../../domain/repositories/i_order_repository.dart';
import '../sources/order_remote_source.dart';
import 'repo_utils.dart';

@LazySingleton(as: IOrderRepository)
class OrderRepository implements IOrderRepository {
  final OrderRemoteSource _source;
  OrderRepository(this._source);

  @override
  Future<Either<NetworkFailure, PageResult<Order>>> getOrders({int page = 1, int limit = 20}) async {
    try {
      final dto = await _source.getOrders(page: page, limit: limit);
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
  Future<Either<NetworkFailure, List<Order>>> checkout({
    String? note,
    Map<String, dynamic>? shippingAddress,
  }) async {
    try {
      final list = await _source.checkout(note: note, shippingAddress: shippingAddress);
      return right(list.map((e) => e.toDomain()).toList());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Order>> buyNow({
    required String productUuid,
    int quantity = 1,
    String? note,
    Map<String, dynamic>? shippingAddress,
  }) async {
    try {
      return right((await _source.buyNow(
        productUuid:     productUuid,
        quantity:        quantity,
        note:            note,
        shippingAddress: shippingAddress,
      )).toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Order>> deliverOrder({required String orderUuid}) async {
    try {
      return right((await _source.deliverOrder(orderUuid: orderUuid)).toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, PageResult<Order>>> getVendorOrders({int page = 1, int limit = 50}) async {
    try {
      final dto = await _source.getVendorOrders(page: page, limit: limit);
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
}
