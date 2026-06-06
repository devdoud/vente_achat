import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/user_model.dart';
import '../../../../core/utils/failures.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial()                         = AuthInitial;
  const factory AuthState.loading()                         = AuthLoading;
  const factory AuthState.authenticated({required User user}) = AuthAuthenticated;
  const factory AuthState.unauthenticated()                 = AuthUnauthenticated;
  const factory AuthState.failure(NetworkFailure failure)   = AuthFailure;
}
