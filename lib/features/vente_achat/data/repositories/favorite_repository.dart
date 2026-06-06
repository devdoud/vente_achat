import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../domain/models/export.dart';
import '../../domain/repositories/i_favorite_repository.dart';
import '../dto/export.dart';
import '../sources/favorite_remote_source.dart';
import 'repo_utils.dart';

@LazySingleton(as: IFavoriteRepository)
class FavoriteRepository implements IFavoriteRepository {
  final FavoriteRemoteSource _source;
  FavoriteRepository(this._source);

  @override
  Future<Either<NetworkFailure, List<Product>>> getFavorites() async {
    try {
      final list = await _source.getFavorites();
      return right(list.map((e) => e.toDomain()).toList());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Unit>> addFavorite(String productUuid) async {
    try {
      await _source.addFavorite(productUuid);
      return right(unit);
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Unit>> removeFavorite(String productUuid) async {
    try {
      await _source.removeFavorite(productUuid);
      return right(unit);
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }
}
