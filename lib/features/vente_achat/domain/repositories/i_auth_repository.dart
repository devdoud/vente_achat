import 'package:dartz/dartz.dart';
import '../../../../core/utils/failures.dart';
import '../models/export.dart';

abstract class IAuthRepository {
  Future<Either<NetworkFailure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<NetworkFailure, User>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  });

  Future<Either<NetworkFailure, User>> getUser();

  Future<Either<NetworkFailure, Unit>> logout();
}
