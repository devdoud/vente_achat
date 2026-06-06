import 'package:dartz/dartz.dart';
import '../../../../core/utils/failures.dart';
import '../models/export.dart';

abstract class IFavoriteRepository {
  Future<Either<NetworkFailure, List<Product>>> getFavorites();
  Future<Either<NetworkFailure, Unit>> addFavorite(String productUuid);
  Future<Either<NetworkFailure, Unit>> removeFavorite(String productUuid);
}
