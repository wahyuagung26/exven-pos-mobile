import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers.dart';
import 'data/repository.dart';
import 'data/sources/auth_remote_datasource.dart';
import 'domain/entities/user_entity.dart';
import 'domain/repository.dart';
import 'domain/usecases/get_current_user_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'ui/providers/auth_state_provider.dart';

// Data source providers
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRemoteDataSourceImpl(dio);
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.read(authRemoteDataSourceProvider);
  final secureStorage = ref.read(secureStorageProvider);
  return AuthRepositoryImpl(remoteDataSource, secureStorage);
});

// Use case providers
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LogoutUseCase(repository);
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

// State providers
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  final logoutUseCase = ref.read(logoutUseCaseProvider);
  final getCurrentUserUseCase = ref.read(getCurrentUserUseCaseProvider);
  
  return AuthNotifier(loginUseCase, logoutUseCase, getCurrentUserUseCase);
});

// Computed providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
});

final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
});