import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../sources/auth_remote_source.dart';
import 'repo_utils.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final AuthRemoteSource _source;
  AuthRepository(this._source);

  @override
  Future<Either<NetworkFailure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final dto = await _source.login(email: email, password: password);
      return right(dto.toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, User>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      final dto = await _source.register(
        email: email, password: password,
        firstName: firstName, lastName: lastName, phone: phone,
      );
      return right(dto.toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, User>> getUser() async {
    try {
      final dto = await _source.getUser();
      return right(dto.toDomain());
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkFailure, Unit>> logout() async {
    try {
      await _source.logout();
      return right(unit);
    } on DioException catch (e) {
      return left(toNetworkFailure(e));
    } catch (_) {
      return left(const NetworkFailure.unexpectedError());
    }
  }
}
