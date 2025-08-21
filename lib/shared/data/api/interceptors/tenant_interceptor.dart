import 'package:dio/dio.dart';
import '../../storage/secure_storage.dart';

class TenantInterceptor extends Interceptor {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final tenantId = await _secureStorage.getTenantId();
    
    if (tenantId != null) {
      options.headers['X-Tenant-ID'] = tenantId;
    }
    
    handler.next(options);
  }
}