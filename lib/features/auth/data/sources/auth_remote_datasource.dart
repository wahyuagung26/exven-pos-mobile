import 'package:dio/dio.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<void> logout();
  Future<UserModel> getCurrentUser();
  Future<LoginResponseModel> refreshToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _dio.post(
      '/auth/login',
      data: request.toJson(),
    );

    return LoginResponseModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await _dio.post('/auth/logout');
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await _dio.get('/auth/me');
    return UserModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<LoginResponseModel> refreshToken() async {
    final response = await _dio.post('/auth/refresh');
    return LoginResponseModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}