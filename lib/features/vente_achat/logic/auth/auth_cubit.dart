import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/token_storage.dart';
import '../../data/sources/auth_remote_source.dart' show kDevAuthMode;
import '../../domain/models/user_model.dart';
import '../../domain/repositories/i_auth_repository.dart';
import 'auth_state.dart';

/// Utilisateur de développement — remplacé par le vrai user après login réel.
const _kDevUser = User(
  id:        'dev-user',
  email:     'dev@beninrestoo.com',
  firstName: 'Dev',
  lastName:  'Mode',
  shopUuid:  '3fa85f64-5717-4562-b3fc-2c963f66afa6',
);

@Singleton()
class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _repo;
  final TokenStorage    _tokenStorage;

  AuthCubit(this._repo, this._tokenStorage)
      : super(const AuthState.initial());

  /// Vérifie le token au démarrage.
  /// En mode dev : sauvegarde le token API et appelle /api/user pour obtenir
  /// le vrai profil (y compris shopUuid). Fallback sur _kDevUser si l'API échoue.
  Future<void> checkAuth() async {
    if (kDevAuthMode) {
      await _tokenStorage.save('apidifftoken2026');
      // Appelle /api/user pour récupérer le vrai profil (shopUuid réel du serveur)
      // Si l'appel échoue, on utilise _kDevUser comme fallback sans bloquer l'app
      emit(const AuthState.loading());
      try {
        final result = await _repo.getUser();
        result.fold(
          (_) => emit(const AuthState.authenticated(user: _kDevUser)),
          (user) => emit(AuthState.authenticated(user: user)),
        );
      } catch (_) {
        emit(const AuthState.authenticated(user: _kDevUser));
      }
      return;
    }

    if (!_tokenStorage.hasToken) {
      emit(const AuthState.unauthenticated());
      return;
    }

    emit(const AuthState.loading());
    final result = await _repo.getUser();
    result.fold(
      (f) {
        _tokenStorage.clear();
        emit(const AuthState.unauthenticated());
      },
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> login({required String email, required String password}) async {
    if (kDevAuthMode) {
      // Mode dev : simuler un login réussi sans appel API
      await _tokenStorage.save('apidifftoken2026');
      emit(const AuthState.authenticated(user: _kDevUser));
      return;
    }
    emit(const AuthState.loading());
    final result = await _repo.login(email: email, password: password);
    result.fold(
      (f) => emit(AuthState.failure(f)),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    if (kDevAuthMode) {
      final devUser = User(
        id: 'dev-user',
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      await _tokenStorage.save('apidifftoken2026');
      emit(AuthState.authenticated(user: devUser));
      return;
    }
    emit(const AuthState.loading());
    final result = await _repo.register(
      email: email, password: password,
      firstName: firstName, lastName: lastName, phone: phone,
    );
    result.fold(
      (f) => emit(AuthState.failure(f)),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> logout() async {
    if (!kDevAuthMode) await _repo.logout();
    await _tokenStorage.clear();
    emit(const AuthState.unauthenticated());
  }
}
