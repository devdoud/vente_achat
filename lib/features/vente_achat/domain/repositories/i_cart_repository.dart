import 'package:dartz/dartz.dart';
import '../../../../core/utils/failures.dart';
import '../models/export.dart';

abstract class ICartRepository {
  Future<Either<NetworkFailure, Cart>> getCart();
  Future<Either<NetworkFailure, Cart>> addItem({required String productUuid, required int quantity});
  Future<Either<NetworkFailure, Cart>> updateItem({required String itemUuid, required int quantity});
  Future<Either<NetworkFailure, Cart>> removeItem(String itemUuid);
  Future<Either<NetworkFailure, Unit>> clearCart();
}
