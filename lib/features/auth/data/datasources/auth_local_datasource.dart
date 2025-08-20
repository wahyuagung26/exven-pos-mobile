import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAccessToken(String token);
  Future<void> cacheRefreshToken(String token);
  Future<void> cacheUser(UserModel user);
  
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<UserModel?> getCachedUser();
  
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  static const String accessTokenKey = 'ACCESS_TOKEN';
  static const String refreshTokenKey = 'REFRESH_TOKEN';
  static const String cachedUserKey = 'CACHED_USER';

  @override
  Future<void> cacheAccessToken(String token) async {
    try {
      await sharedPreferences.setString(accessTokenKey, token);
    } catch (e) {
      throw CacheException(message: 'Failed to cache access token: $e');
    }
  }

  @override
  Future<void> cacheRefreshToken(String token) async {
    try {
      await sharedPreferences.setString(refreshTokenKey, token);
    } catch (e) {
      throw CacheException(message: 'Failed to cache refresh token: $e');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      await sharedPreferences.setString(cachedUserKey, userJson);
    } catch (e) {
      throw CacheException(message: 'Failed to cache user: $e');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return sharedPreferences.getString(accessTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to get access token: $e');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return sharedPreferences.getString(refreshTokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to get refresh token: $e');
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userJsonString = sharedPreferences.getString(cachedUserKey);
      if (userJsonString != null) {
        final userJson = json.decode(userJsonString) as Map<String, dynamic>;
        return UserModel.fromJson(userJson);
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to get cached user: $e');
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await Future.wait([
        sharedPreferences.remove(accessTokenKey),
        sharedPreferences.remove(refreshTokenKey),
        sharedPreferences.remove(cachedUserKey),
      ]);
    } catch (e) {
      throw CacheException(message: 'Failed to clear auth data: $e');
    }
  }
}