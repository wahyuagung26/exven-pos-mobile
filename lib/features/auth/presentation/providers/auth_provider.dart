import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/dependency_injection.dart';
import '../../domain/entities/auth_state.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/reset_password.dart';

// Use Case Providers
final loginProvider = Provider<Login>((ref) => getIt<Login>());
final registerProvider = Provider<Register>((ref) => getIt<Register>());
final logoutProvider = Provider<Logout>((ref) => getIt<Logout>());
final getCurrentUserProvider = Provider<GetCurrentUser>((ref) => getIt<GetCurrentUser>());
final changePasswordProvider = Provider<ChangePassword>((ref) => getIt<ChangePassword>());
final resetPasswordProvider = Provider<ResetPassword>((ref) => getIt<ResetPassword>());

class AuthNotifier extends StateNotifier<AuthState> {
  final Login _login;
  final Register _register;
  final Logout _logout;
  final GetCurrentUser _getCurrentUser;
  final ChangePassword _changePassword;
  final ResetPassword _resetPassword;

  AuthNotifier(
    this._login,
    this._register,
    this._logout,
    this._getCurrentUser,
    this._changePassword,
    this._resetPassword,
  ) : super(const AuthState.initial()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    state = const AuthState.loading();
    
    final result = await _getCurrentUser();
    
    result.fold(
      (failure) => state = AuthState.unauthenticated(error: failure.message),
      (user) {
        if (user != null) {
          state = AuthState.authenticated(user);
        } else {
          state = const AuthState.unauthenticated();
        }
      },
    );
  }

  Future<bool> login(String email, String password) async {
    state = const AuthState.loading();

    final result = await _login(LoginParams(
      email: email,
      password: password,
    ));

    return result.fold(
      (failure) {
        state = AuthState.error(failure.message);
        return false;
      },
      (tokenPair) {
        // Get user after successful login
        _checkAuthStatus();
        return true;
      },
    );
  }

  Future<bool> register({
    required String tenantName,
    String? businessType,
    required String email,
    String? phone,
    required String password,
    required String fullName,
  }) async {
    state = const AuthState.loading();

    final result = await _register(RegisterParams(
      tenantName: tenantName,
      businessType: businessType,
      email: email,
      phone: phone,
      password: password,
      fullName: fullName,
    ));

    return result.fold(
      (failure) {
        state = AuthState.error(failure.message);
        return false;
      },
      (user) {
        state = AuthState.authenticated(user);
        return true;
      },
    );
  }

  Future<bool> logout() async {
    state = const AuthState.loading();

    final result = await _logout();

    return result.fold(
      (failure) {
        // Even if logout fails, clear local state
        state = const AuthState.unauthenticated();
        return false;
      },
      (_) {
        state = const AuthState.unauthenticated();
        return true;
      },
    );
  }

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final currentState = state;
    state = state.copyWith(isLoading: true, error: null);

    final result = await _changePassword(ChangePasswordParams(
      oldPassword: oldPassword,
      newPassword: newPassword,
    ));

    return result.fold(
      (failure) {
        state = currentState.copyWith(
          isLoading: false,
          error: failure.message,
        );
        return false;
      },
      (_) {
        state = currentState.copyWith(isLoading: false, error: null);
        return true;
      },
    );
  }

  Future<bool> resetPassword(String email) async {
    final currentState = state;
    state = state.copyWith(isLoading: true, error: null);

    final result = await _resetPassword(ResetPasswordParams(email: email));

    return result.fold(
      (failure) {
        state = currentState.copyWith(
          isLoading: false,
          error: failure.message,
        );
        return false;
      },
      (_) {
        state = currentState.copyWith(isLoading: false, error: null);
        return true;
      },
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Auth State Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(loginProvider),
    ref.read(registerProvider),
    ref.read(logoutProvider),
    ref.read(getCurrentUserProvider),
    ref.read(changePasswordProvider),
    ref.read(resetPasswordProvider),
  );
});

// Convenience providers
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).error;
});