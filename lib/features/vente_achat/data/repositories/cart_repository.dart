import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../domain/models/export.dart';
import '../../domain/repositories/i_cart_repository.dart';
import '../sources/cart_remote_source.dart';
import 'repo_utils.dart';

@LazySingleton(as: ICartRepository)
class CartRepository implements ICartRepository {
  final CartRemoteSource _source;
  CartRepository(this._source);

  @override
  Future<Either<NetworkFailure, Cart>> getCart() async {
    try {
      return right((await _source.getCart()).toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Cart>> addItem({required String productUuid, required int quantity}) async {
    try {
      return right((await _source.addItem(productUuid: productUuid, quantity: quantity)).toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Cart>> updateItem({required String itemUuid, required int quantity}) async {
    try {
      return right((await _source.updateItem(itemUuid: itemUuid, quantity: quantity)).toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Cart>> removeItem(String itemUuid) async {
    try {
      return right((await _source.removeItem(itemUuid)).toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Unit>> clearCart() async {
    try {
      await _source.clearCart();
      return right(unit);
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }
}
