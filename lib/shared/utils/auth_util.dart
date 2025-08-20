import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/domain/entities/user.dart';

class AuthUtil {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  static Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> setLoggedUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode({
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'avatar': user.avatar,
      'createdAt': user.createdAt.toIso8601String(),
      'lastLoginAt': user.lastLoginAt?.toIso8601String(),
    });
    await prefs.setString(_userKey, userJson);
  }

  static Future<User?> getLoggedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    
    if (userJson == null) return null;

    try {
      final userData = jsonDecode(userJson);
      return User(
        id: userData['id'],
        email: userData['email'],
        name: userData['name'],
        avatar: userData['avatar'],
        createdAt: DateTime.parse(userData['createdAt']),
        lastLoginAt: userData['lastLoginAt'] != null 
          ? DateTime.parse(userData['lastLoginAt']) 
          : null,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<bool> isLoggedIn() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<void> updateLoggedUser(User user) async {
    await setLoggedUser(user);
  }
}