import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/utils/failures.dart';

NetworkFailure toNetworkFailure(DioException e) {
  if (e is NoInternetConnectionException) return const NetworkFailure.notInternetConnexionError();
  if (e is UnauthorizedException)         return const NetworkFailure.unauthorized();
  if (e is NotFoundException)             return const NetworkFailure.notFound();
  if (e is InternalServerErrorException) return const NetworkFailure.serverError();
  if (e is ConflictException)             return const NetworkFailure.failure('Produit indisponible ou déjà dans le panier');
  if (e is UnprocessableException)        return NetworkFailure.failure(e.validationMessage);
  return NetworkFailure.failure(e.message ?? 'Erreur réseau');
}
