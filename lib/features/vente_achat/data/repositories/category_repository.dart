import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../domain/models/export.dart';
import '../../domain/repositories/i_category_repository.dart';
import '../dto/export.dart';
import '../sources/category_remote_source.dart';
import 'repo_utils.dart';

@LazySingleton(as: ICategoryRepository)
class CategoryRepository implements ICategoryRepository {
  final CategoryRemoteSource _source;
  CategoryRepository(this._source);

  @override
  Future<Either<NetworkFailure, List<Category>>> getCategories() async {
    try {
      final list = await _source.getCategories();
      return right(list.map((e) => e.toDomain()).toList());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, List<CategoryFeature>>> getCategoryFeatures(String uuid) async {
    try {
      final list = await _source.getCategoryFeatures(uuid);
      return right(list.map((e) => e.toDomain()).toList());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }
}
