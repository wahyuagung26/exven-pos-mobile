import 'package:equatable/equatable.dart';

import 'user.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
  });

  const AuthState.initial()
      : user = null,
        isAuthenticated = false,
        isLoading = false,
        error = null;

  const AuthState.loading()
      : user = null,
        isAuthenticated = false,
        isLoading = true,
        error = null;

  const AuthState.authenticated(this.user)
      : isAuthenticated = true,
        isLoading = false,
        error = null;

  const AuthState.unauthenticated({this.error})
      : user = null,
        isAuthenticated = false,
        isLoading = false;

  const AuthState.error(this.error)
      : user = null,
        isAuthenticated = false,
        isLoading = false;

  AuthState copyWith({
    User? user,
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [user, isAuthenticated, isLoading, error];

  @override
  String toString() {
    return 'AuthState(user: $user, isAuthenticated: $isAuthenticated, isLoading: $isLoading, error: $error)';
  }
}