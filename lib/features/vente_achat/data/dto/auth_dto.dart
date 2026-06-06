import '../../domain/models/user_model.dart';

class TokenResponseDto {
  final String accessToken;
  final String? refreshToken;
  final int? expiresIn;

  const TokenResponseDto({
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) =>
      TokenResponseDto(
        accessToken:  json['access_token']  as String,
        refreshToken: json['refresh_token'] as String?,
        expiresIn:    json['expires_in']    as int?,
      );
}

class UserDto {
  final String  id;
  final String  email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? shopUuid;
  final List<String> roles;

  const UserDto({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.shopUuid,
    this.roles = const [],
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    // Le shopUuid peut être sous différentes formes selon l'API
    final shop = json['shop'];
    final shopUuid = json['shopUuid'] as String?
        ?? json['shop_uuid'] as String?
        ?? (shop is Map ? shop['uuid'] as String? : null)
        ?? (shop is String ? shop : null);

    return UserDto(
      id:        json['id']?.toString()        ?? json['uuid']?.toString() ?? '',
      email:     json['email']    as String?   ?? '',
      firstName: json['firstname'] as String?  ?? json['firstName'] as String?,
      lastName:  json['lastname']  as String?  ?? json['lastName']  as String?,
      phone:     json['phone']     as String?,
      shopUuid:  shopUuid,
      roles:     (json['roles'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  User toDomain() => User(
        id:        id,
        email:     email,
        firstName: firstName,
        lastName:  lastName,
        phone:     phone,
        shopUuid:  shopUuid,
        roles:     roles,
      );
}
