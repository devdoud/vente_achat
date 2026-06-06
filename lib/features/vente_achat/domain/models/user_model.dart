import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    String? phone,
    String? shopUuid,
    @Default([]) List<String> roles,
  }) = _User;

  const User._();

  String get fullName {
    final f = firstName ?? '';
    final l = lastName  ?? '';
    if (f.isEmpty && l.isEmpty) return email;
    return '$f $l'.trim();
  }

  String get initials {
    final f = firstName?.isNotEmpty == true ? firstName![0].toUpperCase() : '';
    final l = lastName?.isNotEmpty  == true ? lastName![0].toUpperCase()  : '';
    return f.isNotEmpty || l.isNotEmpty ? '$f$l' : email[0].toUpperCase();
  }

  bool get isAdmin => roles.any((r) => r.contains('ADMIN'));
}
