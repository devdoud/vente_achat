import 'dart:io';
import 'package:dio/io.dart';
import '../../export.dart';

const baseUrl="";

final dioOption= BaseOptions(
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
    headers: {
      "accept": "application/ld+json",
      "Content-Type": "application/ld+json",
    },
    baseUrl: baseUrl,
);

@Singleton()
class ApiClient{
  ApiClient();
  factory ApiClient.get() => getIt<ApiClient>();

  Dio baseClient(){
    final dio= Dio(dioOption);

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient(context: SecurityContext());
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
      validateCertificate: (cert, host, port) {
        if (cert == null) {
          return false;
        }
        return true;
      },
    );

    return dio..interceptors.addAll([InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["platform"] = "mobile";
        options.headers["system"] = Platform.operatingSystem;
        options.headers["current-path"] = getIt<AppRouter>().currentPath;
        return handler.next(options);
      },
    ), Logging(), AppInterceptors()]);
  }

  Dio call(){
    return baseClient();
  }
}

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.get().logInfo('REQUEST[${options.method}] => PATH: ${options.uri.toString()} => HEADERS: ${options.headers}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.get().logInfo('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri.toString()}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message= 'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri.toString()} => ERROR: ${err.message}';
    AppLogger.get().logError(message, err.error, err.stackTrace);

    return super.onError(err, handler);
  }
}

class AppInterceptors extends Interceptor {
  AppInterceptors();

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
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        break;
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}