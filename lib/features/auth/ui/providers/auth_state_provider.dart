import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

part 'auth_state_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthNotifier(
    this._loginUseCase,
    this._logoutUseCase,
    this._getCurrentUserUseCase,
  ) : super(const AuthState.initial());

  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();
    
    try {
      final result = await _getCurrentUserUseCase();
      result.fold(
        (failure) {
          // Log the failure for debugging
          print('Auth check failed: ${failure}');
          state = const AuthState.unauthenticated();
        },
        (user) => state = AuthState.authenticated(user),
      );
    } catch (e) {
      // Handle any unexpected errors
      print('Unexpected error during auth check: $e');
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    
    final result = await _loginUseCase(LoginParams(email: email, password: password));
    result.fold(
      (failure) => state = AuthState.error(failure.when(
        network: (message, statusCode) => message,
        auth: (message) => message,
        validation: (message) => message,
        unknown: (message) => message,
        cache: (message) => message,
      )),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    
    await _logoutUseCase();
    state = const AuthState.unauthenticated();
  }
}