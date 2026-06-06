import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/token_storage.dart';
import '../dto/auth_dto.dart';

// ─── Configuration OAuth2 ────────────────────────────────────────────────────
// Remplacez avec vos credentials Symfony une fois disponibles.
// Tant que _kClientId vaut 'your_client_id', le mode dev est actif (mock auth).
const _kClientId     = 'your_client_id';
const _kClientSecret = 'your_client_secret';

/// true = credentials non configurés → mode développement (bypass auth réelle)
const kDevAuthMode = _kClientId == 'your_client_id';
// ─────────────────────────────────────────────────────────────────────────────

@lazySingleton
class AuthRemoteSource {
  final ApiClient     _client;
  final TokenStorage  _tokenStorage;
  AuthRemoteSource(this._client, this._tokenStorage);

  Future<UserDto> login({
    required String email,
    required String password,
  }) async {
    // 1. Obtenir le token OAuth2
    final tokenResp = await _client.call().post(
      '/oauth/v2/token',
      data: {
        'grant_type':    'password',
        'client_id':     _kClientId,
        'client_secret': _kClientSecret,
        'username':      email,
        'password':      password,
      },
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );
    final token = TokenResponseDto.fromJson(tokenResp.data as Map<String, dynamic>);
    await _tokenStorage.save(token.accessToken);

    // 2. Charger le profil utilisateur avec le token fraîchement sauvegardé
    final userResp = await _client.call().get('/api/user');
    return UserDto.fromJson(userResp.data as Map<String, dynamic>);
  }

  Future<UserDto> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    await _client.call().post('/api/simple-register', data: {
      'email':         email,
      'password':      password,
      'firstname':     firstName,
      'lastname':      lastName,
      if (phone != null) 'phone': phone,
    });
    // Après inscription, on connecte automatiquement
    return login(email: email, password: password);
  }

  Future<UserDto> getUser() async {
    final resp = await _client.call().get('/api/user');
    return UserDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<void> logout() async {
    try {
      await _client.call().get('/api/logout');
    } catch (_) {
      // Ignorer l'erreur serveur — on nettoie le token dans tous les cas
    } finally {
      await _tokenStorage.clear();
    }
  }
}
