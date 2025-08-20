/// Network-specific exceptions and failures
/// 
/// This file contains exception classes specifically for network operations,
/// HTTP errors, connectivity issues, and API-related problems.

import 'package:dio/dio.dart';
import 'app_exceptions.dart';

/// Base network exception
class NetworkException extends AppException {
  const NetworkException(
    super.message, {
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'NetworkException: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure(
    super.message, {
    super.code,
    super.timestamp,
  });
}

/// Connection related exceptions
class ConnectionException extends NetworkException {
  const ConnectionException(
    super.message, {
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'ConnectionException: $message';
}

class ConnectionFailure extends NetworkFailure {
  const ConnectionFailure(
    super.message, {
    super.code,
    super.timestamp,
  });
}

/// HTTP specific exceptions
class HttpException extends NetworkException {
  final int statusCode;
  final String? reasonPhrase;
  final Map<String, dynamic>? responseData;
  
  const HttpException(
    super.message, {
    required this.statusCode,
    this.reasonPhrase,
    this.responseData,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'HttpException ($statusCode): $message';
}

class HttpFailure extends NetworkFailure {
  final int statusCode;
  final String? reasonPhrase;
  final Map<String, dynamic>? responseData;
  
  const HttpFailure(
    super.message, {
    required this.statusCode,
    this.reasonPhrase,
    this.responseData,
    super.code,
    super.timestamp,
  });
}

/// Request timeout exceptions
class RequestTimeoutException extends NetworkException {
  final Duration timeout;
  
  const RequestTimeoutException(
    super.message, {
    required this.timeout,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'RequestTimeoutException: $message (${timeout.inSeconds}s)';
}

class RequestTimeoutFailure extends NetworkFailure {
  final Duration timeout;
  
  const RequestTimeoutFailure(
    super.message, {
    required this.timeout,
    super.code,
    super.timestamp,
  });
}

/// Server error exceptions (5xx)
class ServerException extends HttpException {
  const ServerException(
    super.message, {
    required super.statusCode,
    super.reasonPhrase,
    super.responseData,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'ServerException ($statusCode): $message';
}

class ServerFailure extends HttpFailure {
  const ServerFailure(
    super.message, {
    required super.statusCode,
    super.reasonPhrase,
    super.responseData,
    super.code,
    super.timestamp,
  });
}

/// Client error exceptions (4xx)
class ClientException extends HttpException {
  const ClientException(
    super.message, {
    required super.statusCode,
    super.reasonPhrase,
    super.responseData,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'ClientException ($statusCode): $message';
}

class ClientFailure extends HttpFailure {
  const ClientFailure(
    super.message, {
    required super.statusCode,
    super.reasonPhrase,
    super.responseData,
    super.code,
    super.timestamp,
  });
}

/// Serialization exceptions
class SerializationException extends NetworkException {
  final dynamic originalData;
  final Type expectedType;
  
  const SerializationException(
    super.message, {
    this.originalData,
    required this.expectedType,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'SerializationException: $message (Expected: $expectedType)';
}

class SerializationFailure extends NetworkFailure {
  final dynamic originalData;
  final Type expectedType;
  
  const SerializationFailure(
    super.message, {
    this.originalData,
    required this.expectedType,
    super.code,
    super.timestamp,
  });
}

/// API response parsing exceptions
class ApiResponseException extends NetworkException {
  final String? endpoint;
  final int? statusCode;
  final Map<String, dynamic>? responseData;
  
  const ApiResponseException(
    super.message, {
    this.endpoint,
    this.statusCode,
    this.responseData,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'ApiResponseException: $message ${endpoint != null ? '(Endpoint: $endpoint)' : ''}';
}

class ApiResponseFailure extends NetworkFailure {
  final String? endpoint;
  final int? statusCode;
  final Map<String, dynamic>? responseData;
  
  const ApiResponseFailure(
    super.message, {
    this.endpoint,
    this.statusCode,
    this.responseData,
    super.code,
    super.timestamp,
  });
}

/// Network utility class for handling Dio exceptions
class NetworkExceptionHandler {
  /// Convert Dio exception to custom network exception
  static NetworkException handleDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return RequestTimeoutException(
          'Koneksi timeout. Periksa koneksi internet Anda',
          timeout: Duration(milliseconds: dioException.requestOptions.connectTimeout ?? 5000),
          code: 'CONNECTION_TIMEOUT',
        );
        
      case DioExceptionType.sendTimeout:
        return RequestTimeoutException(
          'Timeout saat mengirim data. Periksa koneksi internet Anda',
          timeout: Duration(milliseconds: dioException.requestOptions.sendTimeout ?? 5000),
          code: 'SEND_TIMEOUT',
        );
        
      case DioExceptionType.receiveTimeout:
        return RequestTimeoutException(
          'Timeout saat menerima data. Periksa koneksi internet Anda',
          timeout: Duration(milliseconds: dioException.requestOptions.receiveTimeout ?? 5000),
          code: 'RECEIVE_TIMEOUT',
        );
        
      case DioExceptionType.badCertificate:
        return ConnectionException(
          'Sertifikat keamanan tidak valid',
          code: 'BAD_CERTIFICATE',
        );
        
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException);
        
      case DioExceptionType.cancel:
        return NetworkException(
          'Permintaan dibatalkan',
          code: 'REQUEST_CANCELLED',
        );
        
      case DioExceptionType.connectionError:
        return ConnectionException(
          'Tidak dapat terhubung ke server. Periksa koneksi internet Anda',
          code: 'CONNECTION_ERROR',
        );
        
      case DioExceptionType.unknown:
      default:
        return NetworkException(
          'Terjadi kesalahan jaringan yang tidak diketahui',
          code: 'UNKNOWN_NETWORK_ERROR',
          details: dioException.message,
        );
    }
  }
  
  /// Handle bad response from server
  static NetworkException _handleBadResponse(DioException dioException) {
    final statusCode = dioException.response?.statusCode ?? 0;
    final responseData = dioException.response?.data as Map<String, dynamic>?;
    final reasonPhrase = dioException.response?.statusMessage;
    
    // Extract error message from response
    String message = _extractErrorMessage(responseData, statusCode);
    String? code = _extractErrorCode(responseData, statusCode);
    
    if (statusCode >= 500) {
      return ServerException(
        message,
        statusCode: statusCode,
        reasonPhrase: reasonPhrase,
        responseData: responseData,
        code: code,
      );
    } else if (statusCode >= 400) {
      return ClientException(
        message,
        statusCode: statusCode,
        reasonPhrase: reasonPhrase,
        responseData: responseData,
        code: code,
      );
    } else {
      return HttpException(
        message,
        statusCode: statusCode,
        reasonPhrase: reasonPhrase,
        responseData: responseData,
        code: code,
      );
    }
  }
  
  /// Extract error message from response data
  static String _extractErrorMessage(Map<String, dynamic>? responseData, int statusCode) {
    if (responseData != null) {
      // Try different message fields
      if (responseData.containsKey('message')) {
        return responseData['message'].toString();
      }
      if (responseData.containsKey('error')) {
        final error = responseData['error'];
        if (error is String) {
          return error;
        }
        if (error is Map && error.containsKey('message')) {
          return error['message'].toString();
        }
      }
      if (responseData.containsKey('detail')) {
        return responseData['detail'].toString();
      }
      if (responseData.containsKey('errors') && responseData['errors'] is List) {
        final errors = responseData['errors'] as List;
        if (errors.isNotEmpty) {
          return errors.first.toString();
        }
      }
    }
    
    // Fallback to status code based messages
    return _getDefaultMessageForStatusCode(statusCode);
  }
  
  /// Extract error code from response data
  static String? _extractErrorCode(Map<String, dynamic>? responseData, int statusCode) {
    if (responseData != null) {
      if (responseData.containsKey('code')) {
        return responseData['code'].toString();
      }
      if (responseData.containsKey('error_code')) {
        return responseData['error_code'].toString();
      }
      if (responseData.containsKey('type')) {
        return responseData['type'].toString();
      }
    }
    
    // Fallback to status code based codes
    return _getDefaultCodeForStatusCode(statusCode);
  }
  
  /// Get default message for HTTP status code
  static String _getDefaultMessageForStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Permintaan tidak valid';
      case 401:
        return 'Sesi telah berakhir. Silakan login kembali';
      case 403:
        return 'Anda tidak memiliki izin untuk mengakses resource ini';
      case 404:
        return 'Data yang diminta tidak ditemukan';
      case 405:
        return 'Metode tidak diizinkan';
      case 408:
        return 'Permintaan timeout';
      case 409:
        return 'Terjadi konflik data';
      case 422:
        return 'Data yang dikirim tidak valid';
      case 429:
        return 'Terlalu banyak permintaan. Silakan coba lagi nanti';
      case 500:
        return 'Terjadi kesalahan di server';
      case 502:
        return 'Server tidak dapat dijangkau';
      case 503:
        return 'Layanan sedang tidak tersedia';
      case 504:
        return 'Server timeout';
      default:
        return 'Terjadi kesalahan jaringan ($statusCode)';
    }
  }
  
  /// Get default error code for HTTP status code
  static String? _getDefaultCodeForStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'BAD_REQUEST';
      case 401:
        return 'UNAUTHORIZED';
      case 403:
        return 'FORBIDDEN';
      case 404:
        return 'NOT_FOUND';
      case 405:
        return 'METHOD_NOT_ALLOWED';
      case 408:
        return 'REQUEST_TIMEOUT';
      case 409:
        return 'CONFLICT';
      case 422:
        return 'UNPROCESSABLE_ENTITY';
      case 429:
        return 'TOO_MANY_REQUESTS';
      case 500:
        return 'INTERNAL_SERVER_ERROR';
      case 502:
        return 'BAD_GATEWAY';
      case 503:
        return 'SERVICE_UNAVAILABLE';
      case 504:
        return 'GATEWAY_TIMEOUT';
      default:
        return 'HTTP_ERROR_$statusCode';
    }
  }
  
  /// Convert network exception to failure
  static NetworkFailure toFailure(NetworkException exception) {
    if (exception is HttpException) {
      if (exception is ServerException) {
        return ServerFailure(
          exception.message,
          statusCode: exception.statusCode,
          reasonPhrase: exception.reasonPhrase,
          responseData: exception.responseData,
          code: exception.code,
        );
      } else if (exception is ClientException) {
        return ClientFailure(
          exception.message,
          statusCode: exception.statusCode,
          reasonPhrase: exception.reasonPhrase,
          responseData: exception.responseData,
          code: exception.code,
        );
      } else {
        return HttpFailure(
          exception.message,
          statusCode: exception.statusCode,
          reasonPhrase: exception.reasonPhrase,
          responseData: exception.responseData,
          code: exception.code,
        );
      }
    } else if (exception is RequestTimeoutException) {
      return RequestTimeoutFailure(
        exception.message,
        timeout: exception.timeout,
        code: exception.code,
      );
    } else if (exception is ConnectionException) {
      return ConnectionFailure(
        exception.message,
        code: exception.code,
      );
    } else if (exception is SerializationException) {
      return SerializationFailure(
        exception.message,
        originalData: exception.originalData,
        expectedType: exception.expectedType,
        code: exception.code,
      );
    } else if (exception is ApiResponseException) {
      return ApiResponseFailure(
        exception.message,
        endpoint: exception.endpoint,
        statusCode: exception.statusCode,
        responseData: exception.responseData,
        code: exception.code,
      );
    } else {
      return NetworkFailure(
        exception.message,
        code: exception.code,
      );
    }
  }
}

/// Predefined network exceptions with Indonesian messages
class CommonNetworkExceptions {
  static const noInternetConnection = ConnectionException(
    'Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi',
    code: 'NO_INTERNET_CONNECTION',
  );
  
  static const serverUnavailable = ServerException(
    'Server sedang tidak tersedia. Silakan coba lagi nanti',
    statusCode: 503,
    code: 'SERVER_UNAVAILABLE',
  );
  
  static const requestTimeout = RequestTimeoutException(
    'Permintaan timeout. Periksa koneksi internet Anda',
    timeout: Duration(seconds: 30),
    code: 'REQUEST_TIMEOUT',
  );
  
  static const invalidResponse = ApiResponseException(
    'Respons dari server tidak valid',
    code: 'INVALID_RESPONSE',
  );
  
  static const serializationError = SerializationException(
    'Terjadi kesalahan saat memproses data dari server',
    expectedType: Object,
    code: 'SERIALIZATION_ERROR',
  );
  
  // Common HTTP errors
  static const unauthorized = ClientException(
    'Sesi telah berakhir. Silakan login kembali',
    statusCode: 401,
    code: 'UNAUTHORIZED',
  );
  
  static const forbidden = ClientException(
    'Anda tidak memiliki izin untuk mengakses resource ini',
    statusCode: 403,
    code: 'FORBIDDEN',
  );
  
  static const notFound = ClientException(
    'Data yang diminta tidak ditemukan',
    statusCode: 404,
    code: 'NOT_FOUND',
  );
  
  static const internalServerError = ServerException(
    'Terjadi kesalahan di server. Silakan coba lagi nanti',
    statusCode: 500,
    code: 'INTERNAL_SERVER_ERROR',
  );
  
  static const badGateway = ServerException(
    'Server tidak dapat dijangkau',
    statusCode: 502,
    code: 'BAD_GATEWAY',
  );
  
  static const serviceUnavailable = ServerException(
    'Layanan sedang tidak tersedia',
    statusCode: 503,
    code: 'SERVICE_UNAVAILABLE',
  );
  
  static const gatewayTimeout = ServerException(
    'Server timeout',
    statusCode: 504,
    code: 'GATEWAY_TIMEOUT',
  );
}

/// Predefined network failures
class CommonNetworkFailures {
  static const connectionFailure = ConnectionFailure(
    'Gagal terhubung ke server',
    code: 'CONNECTION_FAILED',
  );
  
  static const timeoutFailure = RequestTimeoutFailure(
    'Permintaan timeout',
    timeout: Duration(seconds: 30),
    code: 'TIMEOUT',
  );
  
  static const serverFailure = ServerFailure(
    'Kesalahan server',
    statusCode: 500,
    code: 'SERVER_ERROR',
  );
  
  static const clientFailure = ClientFailure(
    'Kesalahan klien',
    statusCode: 400,
    code: 'CLIENT_ERROR',
  );
  
  static const serializationFailure = SerializationFailure(
    'Gagal memproses data',
    expectedType: Object,
    code: 'SERIALIZATION_FAILED',
  );
}