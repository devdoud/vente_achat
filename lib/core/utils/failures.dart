import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;
  const factory ValueFailure.nullValue() = NullValue<T>;
  const factory ValueFailure.empty({required T failedValue}) = Empty<T>;
  const factory ValueFailure.multiline({required T failedValue}) = Multiline<T>;
  const factory ValueFailure.listTooLong({
    required T failedValue,
    required int max,
  }) = ListTooLong<T>;
  const factory ValueFailure.invalidEmail({required T failedValue}) =
      InvalidEmail<T>;
  const factory ValueFailure.invalidColor({required T failedValue}) =
      InvalidColor<T>;
  const factory ValueFailure.shortPassword({required T failedValue}) =
      ShortPassword<T>;
  const factory ValueFailure.notConformPassword({required T failedValue}) =
      NotConformPassword<T>;

  const factory ValueFailure.invalidNumber({required T failedValue}) =
      InvalidNumber<T>;
  const factory ValueFailure.invalidPhoneNumber({required T failedValue}) =
      InvalidPhoneNumber<T>;
  const factory ValueFailure.invalidLengthOtp({required T failedValue}) =
      InvalidLengthOtp<T>;
  const factory ValueFailure.emptyStr({required T failedValue}) = EmptyStr<T>;

  const factory ValueFailure.notValidData({required T failedValue}) =
      NotValidData<T>;
  const factory ValueFailure.notValidGpsString({required T failedValue}) =
      NotValidDataGpsString<T>;
}

@freezed
class NetworkFailure with _$NetworkFailure {
  const factory NetworkFailure.unexpectedError() = NetworkUnexpectedError;
  const factory NetworkFailure.serverError() = NetworkServerError;
  const factory NetworkFailure.unauthorized() = NetworkUnauthorizedError;
  const factory NetworkFailure.notInternetConnexionError() =
      NetworkNotInternetConnexionError;
  const factory NetworkFailure.failure(String message) = NetworkSimpleError;
  const factory NetworkFailure.notFound() = NetworkNotFoundError;
}

extension NetworkFailureX on NetworkFailure {
  String get toMsg => map(
    failure: (value) => value.message,
    notInternetConnexionError: (value) => "Aucun accès à internet trouvé",
    unexpectedError: (_) => "Oupps, un problème est survenu",
    serverError: (_) => "Oupps, un problème est survenu",
    unauthorized: (_) => "Unauthirized",
    notFound: (_) => "Ressource not found",
  );
}
