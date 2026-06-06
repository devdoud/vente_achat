import 'dart:io';
import 'package:dio/io.dart';
import '../../export.dart';

const _kBaseUrl = 'https://app.beninrestoo.com';

@Singleton()
class ApiClient {
  final TokenStorage _tokenStorage;
  late final Dio _dio;

  ApiClient(this._tokenStorage) {
    _dio = _buildDio();
  }

  factory ApiClient.get() => getIt<ApiClient>();

  Dio call() => _dio;

  Dio _buildDio() {
    final dio = Dio(BaseOptions(
      baseUrl: _kBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient(context: SecurityContext());
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
      validateCertificate: (cert, host, port) => true,
    );

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _tokenStorage.token;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['platform'] = 'mobile';
          options.headers['system'] = Platform.operatingSystem;
          return handler.next(options);
        },
      ),
      Logging(),
      AppInterceptors(),
    ]);

    return dio;
  }
}

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.get().logInfo('REQUEST[${options.method}] => ${options.uri}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.get().logInfo('RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Future.microtask(() {
      try {
        final body = err.response?.data;
        AppLogger.get().logError(
          'ERROR[${err.response?.statusCode}] '
          'type=${err.type.name} '
          'msg="${err.message}" '
          '=> ${err.requestOptions.uri}'
          '${body != null ? '\nRESPONSE_BODY: $body' : ''}',
          err.error,
          err.stackTrace,
        );
      } catch (_) {}
    });
    return super.onError(err, handler);
  }
}

class AppInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 422:
            throw UnprocessableException(err.requestOptions, err.response?.data);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      default:
        break;
    }
    return handler.next(err);
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Requête invalide';
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Erreur serveur, réessayez plus tard';
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Conflit détecté';
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Accès non autorisé';
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Ressource introuvable';
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Aucune connexion internet';
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'La connexion a expiré';
}

class UnprocessableException extends DioException {
  final dynamic responseData;
  UnprocessableException(RequestOptions r, this.responseData) : super(requestOptions: r);

  /// Extrait le message de validation depuis la réponse API Platform / Symfony.
  String get validationMessage {
    final data = responseData;
    if (data is Map) {
      // API Platform: { "detail": "field: message" }
      if (data['detail'] is String && (data['detail'] as String).isNotEmpty) {
        return data['detail'] as String;
      }
      // API Platform violations: { "violations": [{"message": "..."}] }
      final violations = data['violations'];
      if (violations is List && violations.isNotEmpty) {
        final first = violations.first;
        if (first is Map) {
          final prop = first['propertyPath'] as String? ?? '';
          final msg  = first['message']      as String? ?? '';
          return prop.isNotEmpty ? '$prop : $msg' : msg;
        }
      }
      // Symfony simple: { "message": "..." }
      if (data['message'] is String) return data['message'] as String;
    }
    return 'Données invalides';
  }

  @override
  String toString() => validationMessage;
}
