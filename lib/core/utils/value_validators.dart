import 'package:achat_vente/export.dart';
import 'package:dartz/dartz.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String? input) {
  if (input == null || input.isEmpty) {
    return left(const ValueFailure.invalidEmail(failedValue: ""));
  }

  // Maybe not the most robust way of email validation but it's good enough
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> confirmPassword(
  String input,
  String password,
) {
  if (input == password) {
    return right(input);
  } else {
    return left(ValueFailure.notConformPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.exceedingLength(failedValue: input, max: maxLength),
    );
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateStringNotNull(String? input) {
  if (input != null) {
    return right(input);
  } else {
    return left(const ValueFailure.nullValue());
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(ValueFailure.multiline(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateColor(String colorStr) {
  try {
    HexColor(colorStr);
    return right(colorStr);
  } catch (e) {
    return left(ValueFailure.invalidColor(failedValue: colorStr));
  }
}

Either<ValueFailure<String>, String> validatePhoneNumber(String input) {
  if (RegExp(r'[0-9]{8}').hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidPhoneNumber(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateNumber(String input) {
  if (isNumericUsingRegularExpression(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidNumber(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePhoneOtp(String input) {
  if (input.length == 6) {
    return right(input);
  }

  return left(ValueFailure.invalidLengthOtp(failedValue: input));
}

Either<ValueFailure<String>, String> validateNotEmptyStr(String input) {
  if (input.isNotEmpty) {
    return right(input);
  }

  return left(ValueFailure.emptyStr(failedValue: input));
}

bool isNumericUsingRegularExpression(String string) {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  return numericRegex.hasMatch(string);
}

Either<ValueFailure<dynamic>, T> validateValue<T>(dynamic input) {
  if (input is T) {
    return left(ValueFailure.notValidData(failedValue: input));
  }

  return right(input as T);
}

Either<ValueFailure<String?>, String?> validateGpsString<T>(String? input) {
  if (input == null) {
    return left(ValueFailure.notValidGpsString(failedValue: input));
  }

  return right(input);
}
