import 'package:dartz/dartz.dart';
import '../../../../core/utils/failures.dart';
import '../models/export.dart';

abstract class ICategoryRepository {
  Future<Either<NetworkFailure, List<Category>>> getCategories();
  Future<Either<NetworkFailure, List<CategoryFeature>>> getCategoryFeatures(String uuid);
}
