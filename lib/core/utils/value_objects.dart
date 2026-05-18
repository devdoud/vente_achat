import 'package:achat_vente/export.dart';
import 'package:dartz/dartz.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() => value.fold((f) => throw UnexpectedValueError(f), id);

  bool isValid() => value.isRight();

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold((l) => left(l), (r) => right(unit));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ValueObject<T> && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

class NotNullValue extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory NotNullValue(String? input) {
    return NotNullValue._(validateStringNotNull(input));
  }

  const NotNullValue._(this.value);

  @override
  String toString() {
    return value.isRight() ? value.getOrElse(() => "")! : "";
  }
}

class NotEmptyValue extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory NotEmptyValue(String input) {
    return NotEmptyValue._(validateStringNotEmpty(input));
  }

  const NotEmptyValue._(this.value);

  @override
  String toString() {
    return value.isRight() ? value.getOrElse(() => "") : "";
  }
}

class MaxLengthValue extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory MaxLengthValue(String input, int length) {
    return MaxLengthValue._(validateMaxStringLength(input, length));
  }

  const MaxLengthValue._(this.value);

  @override
  String toString() {
    return value.isRight() ? value.getOrElse(() => "") : "";
  }
}

class ValidValue<S> extends ValueObject<dynamic> {
  @override
  final Either<ValueFailure<dynamic>, dynamic> value;

  factory ValidValue(dynamic input) {
    return ValidValue._(validateValue<S>(input));
  }

  const ValidValue._(this.value);
}

class GpsValue extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory GpsValue(String? input) {
    return GpsValue._(validateGpsString(input));
  }

  const GpsValue._(this.value);
}

class EmailAddress extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String> value;

  factory EmailAddress(String? input) {
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}

class ConfirmPassword extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory ConfirmPassword(String input, String password) {
    return ConfirmPassword._(confirmPassword(input, password));
  }

  const ConfirmPassword._(this.value);
}

class NumericValue extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory NumericValue(String input) {
    return NumericValue._(validateNumber(input));
  }

  const NumericValue._(this.value);
}

class PhoneOtp extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PhoneOtp(String input) {
    return PhoneOtp._(validatePhoneOtp(input));
  }

  const PhoneOtp._(this.value);
}

extension ValueObjectsX on ValueObject {
  String? get errorTxt => value.fold(
    (l) => l.map(
      exceedingLength: (e) => "${e.failedValue} ne peut pas dépasser ${e.max}",
      empty: (e) => "Valeur requise svp",
      multiline: (value) => "Vous ne devez pas aller à la ligne",
      listTooLong: (value) => "Votre liste contient trop d'élément",
      invalidEmail:
          (value) => "${value.failedValue} n'est pas une adresse email valide",
      invalidColor:
          (value) => "${value.failedValue} n'est pas un code couleur valide",
      shortPassword: (value) => "Mot de passe trop courte",
      invalidPhoneNumber:
          (value) =>
              "${value.failedValue} n'est pas un numéro de téléphone valide",
      invalidLengthOtp: (value) => "OTP non valide",
      emptyStr: (e) => "Valeur requise svp",
      invalidNumber: (e) => "Valeur numéric svp",
      notValidData: (e) => "${e.toString()} not json",
      notValidGpsString: (e) => "not valid gps value",
      notConformPassword: (e) => "Mot de passe non conforme",
      nullValue: (e) => "Valeur requise svp",
    ),
    (r) => null,
  );
}
