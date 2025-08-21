import 'package:dio/dio.dart';
import '../../../domain/failures/failures.dart';
import '../../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.getToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid
      await _secureStorage.clearAll();
      
      // You can add navigation to login here if needed
      // Example: GetIt.instance<AppRouter>().go('/login');
    }
    
    handler.next(err);
  }
}