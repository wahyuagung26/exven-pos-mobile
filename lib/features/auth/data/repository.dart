import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../shared/domain/failures/failures.dart';
import '../../../shared/data/storage/secure_storage.dart';
import '../domain/entities/user_entity.dart';
import '../domain/repository.dart';
import 'models/login_request_model.dart';
import 'models/user_model.dart';
import 'sources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final request = LoginRequestModel(email: email, password: password);
      final response = await _remoteDataSource.login(request);
      
      // Save tokens and user data
      await _secureStorage.saveToken(response.token);
      await _secureStorage.saveTenantId(response.user.tenantId.toString());
      
      return Right(response.user.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioErrorToFailure(e));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Try to logout from server
      await _remoteDataSource.logout();
    } catch (e) {
      // Continue with local logout even if server call fails
    }
    
    // Always clear local data
    await _secureStorage.clearAll();
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final token = await _secureStorage.getToken();
      if (token == null) {
        return const Left(Failure.auth('No authentication token found'));
      }
      
      final userModel = await _remoteDataSource.getCurrentUser();
      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioErrorToFailure(e));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      final response = await _remoteDataSource.refreshToken();
      await _secureStorage.saveToken(response.token);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioErrorToFailure(e));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  Failure _mapDioErrorToFailure(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network('Connection timeout');
      case DioExceptionType.connectionError:
        return const Failure.network('No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = (error.response?.data?['message'] as String?) ?? 'Server error';
        
        if (statusCode == 401) {
          return const Failure.auth('Invalid email or password');
        } else if (statusCode == 422) {
          return Failure.validation(message);
        }
        
        return Failure.network(message, statusCode);
      case DioExceptionType.cancel:
        return const Failure.network('Request was cancelled');
      case DioExceptionType.badCertificate:
        return const Failure.network('Security certificate error');
      case DioExceptionType.unknown:
        return Failure.unknown(error.message ?? 'An unexpected error occurred');
    }
  }
}