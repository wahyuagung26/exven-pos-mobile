import 'dart:convert';

import 'package:dio/dio.dart';

import '../../domain/entities/pagination_entity.dart';
import '../../domain/repositories/base_repository.dart';
import '../models/api_response_model.dart';
import '../models/error_model.dart';
import '../models/pagination_model.dart';

/// Base class for all remote data sources
/// Provides common HTTP operations and error handling
abstract class BaseRemoteDataSource {
  /// Dio client for HTTP requests
  final Dio dio;

  /// Base endpoint for this data source
  final String baseEndpoint;

  /// Creates a base remote data source
  BaseRemoteDataSource({
    required this.dio,
    required this.baseEndpoint,
  });

  /// Perform GET request
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) parser,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        '$baseEndpoint$path',
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response, parser);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Perform GET request for list data
  Future<List<T>> getList<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) parser,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        '$baseEndpoint$path',
        queryParameters: queryParameters,
        options: options,
      );
      
      final data = _extractData(response);
      if (data is! List) {
        throw ServerFailure(
          'Expected list data but got ${data.runtimeType}',
          statusCode: response.statusCode ?? 500,
        );
      }
      
      return data.map((item) => parser(item as Map<String, dynamic>)).toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Perform GET request for paginated data
  Future<PaginationEntity<T>> getPaginated<T>({
    required String path,
    required PaginationParams params,
    required T Function(Map<String, dynamic>) parser,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        '$baseEndpoint$path',
        queryParameters: params.toQueryParams(),
        options: options,
      );
      
      final json = response.data as Map<String, dynamic>;
      
      // Extract pagination meta
      final meta = json['meta'] != null
          ? PaginationModel.fromJson(json['meta'] as Map<String, dynamic>)
          : PaginationModel.fromLaravel(json);
      
      // Extract data
      final data = json['data'] as List;
      final items = data.map((item) => parser(item as Map<String, dynamic>)).toList();
      
      return meta.toEntity(items);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Perform POST request
  Future<T> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) parser,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        '$baseEndpoint$path',
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response, parser);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Perform PUT request
  Future<T> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) parser,
    Options? options,
  }) async {
    try {
      final response = await dio.put(
        '$baseEndpoint$path',
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response, parser);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Perform PATCH request
  Future<T> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) parser,
    Options? options,
  }) async {
    try {
      final response = await dio.patch(
        '$baseEndpoint$path',
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response, parser);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Perform DELETE request
  Future<void> delete({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      await dio.delete(
        '$baseEndpoint$path',
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Upload file
  Future<T> uploadFile<T>({
    required String path,
    required String fieldName,
    required String filePath,
    Map<String, dynamic>? additionalData,
    required T Function(dynamic) parser,
    void Function(int, int)? onSendProgress,
    Options? options,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
        if (additionalData != null) ...additionalData,
      });

      final response = await dio.post(
        '$baseEndpoint$path',
        data: formData,
        onSendProgress: onSendProgress,
        options: options,
      );
      
      return _handleResponse(response, parser);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Upload multiple files
  Future<T> uploadMultipleFiles<T>({
    required String path,
    required String fieldName,
    required List<String> filePaths,
    Map<String, dynamic>? additionalData,
    required T Function(dynamic) parser,
    void Function(int, int)? onSendProgress,
    Options? options,
  }) async {
    try {
      final files = await Future.wait(
        filePaths.map((path) => MultipartFile.fromFile(path)),
      );

      final formData = FormData.fromMap({
        fieldName: files,
        if (additionalData != null) ...additionalData,
      });

      final response = await dio.post(
        '$baseEndpoint$path',
        data: formData,
        onSendProgress: onSendProgress,
        options: options,
      );
      
      return _handleResponse(response, parser);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Download file
  Future<void> downloadFile({
    required String path,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onReceiveProgress,
    Options? options,
  }) async {
    try {
      await dio.download(
        '$baseEndpoint$path',
        savePath,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle response and extract data
  T _handleResponse<T>(Response response, T Function(dynamic) parser) {
    final data = _extractData(response);
    return parser(data);
  }

  /// Extract data from response
  dynamic _extractData(Response response) {
    final responseData = response.data;
    
    // Handle different response structures
    if (responseData is Map<String, dynamic>) {
      // Check for standard API response structure
      if (responseData.containsKey('data')) {
        return responseData['data'];
      }
      // Return full response if no data key
      return responseData;
    }
    
    // Return as-is for other types
    return responseData;
  }

  /// Handle errors and convert to appropriate failure types
  Failure _handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    
    if (error is Failure) {
      return error;
    }
    
    return UnexpectedFailure(
      error.toString(),
      stackTrace: StackTrace.current,
    );
  }

  /// Handle Dio-specific errors
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          'Connection timeout. Please try again.',
          code: 'TIMEOUT',
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.connectionError:
        return NetworkFailure(
          'No internet connection. Please check your connection.',
          code: 'NO_CONNECTION',
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response!);
        
      case DioExceptionType.cancel:
        return NetworkFailure(
          'Request was cancelled',
          code: 'CANCELLED',
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        return UnexpectedFailure(
          error.message ?? 'An unexpected error occurred',
          stackTrace: error.stackTrace,
        );
    }
  }

  /// Handle bad response errors
  Failure _handleBadResponse(Response response) {
    final statusCode = response.statusCode ?? 500;
    final data = response.data;
    
    // Try to parse error response
    ErrorModel? errorModel;
    if (data is Map<String, dynamic>) {
      try {
        errorModel = ErrorModel.fromJson(data);
      } catch (_) {
        // Fallback to creating error from response data
        errorModel = ErrorModel(
          message: data['message'] as String? ?? 'Server error',
          code: data['code'] as String?,
          statusCode: statusCode,
          fieldErrors: _extractFieldErrors(data),
        );
      }
    }
    
    final message = errorModel?.message ?? 'Server error occurred';
    
    // Map status codes to specific failure types
    switch (statusCode) {
      case 400:
        return ValidationFailure(
          message,
          fieldErrors: errorModel?.fieldErrors,
          code: errorModel?.code,
        );
        
      case 401:
        return AuthenticationFailure(
          message,
          code: errorModel?.code,
          details: errorModel?.details,
        );
        
      case 403:
        return AuthorizationFailure(
          message,
          code: errorModel?.code,
        );
        
      case 404:
        return ServerFailure(
          'Resource not found',
          statusCode: statusCode,
          code: 'NOT_FOUND',
        );
        
      case 422:
        return ValidationFailure(
          message,
          fieldErrors: errorModel?.fieldErrors,
          code: errorModel?.code,
        );
        
      case 429:
        return ServerFailure(
          'Too many requests. Please try again later.',
          statusCode: statusCode,
          code: 'RATE_LIMIT',
        );
        
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          'Server error. Please try again later.',
          statusCode: statusCode,
          code: 'SERVER_ERROR',
        );
        
      default:
        return ServerFailure(
          message,
          statusCode: statusCode,
          code: errorModel?.code,
          response: data is Map<String, dynamic> ? data : null,
        );
    }
  }

  /// Extract field errors from response data
  Map<String, List<String>>? _extractFieldErrors(Map<String, dynamic> data) {
    // Check for 'errors' key
    if (data.containsKey('errors')) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        return errors.map((key, value) {
          if (value is List) {
            return MapEntry(key, value.cast<String>());
          }
          return MapEntry(key, [value.toString()]);
        });
      }
    }
    
    // Check for 'field_errors' key
    if (data.containsKey('field_errors')) {
      final errors = data['field_errors'];
      if (errors is Map<String, dynamic>) {
        return errors.map((key, value) {
          if (value is List) {
            return MapEntry(key, value.cast<String>());
          }
          return MapEntry(key, [value.toString()]);
        });
      }
    }
    
    return null;
  }

  /// Create headers with optional overrides
  Map<String, dynamic> createHeaders([Map<String, dynamic>? overrides]) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (overrides != null) ...overrides,
    };
  }

  /// Create options with custom headers
  Options createOptions({
    Map<String, dynamic>? headers,
    ResponseType? responseType,
    int? sendTimeout,
    int? receiveTimeout,
  }) {
    return Options(
      headers: createHeaders(headers),
      responseType: responseType,
      sendTimeout: sendTimeout != null ? Duration(milliseconds: sendTimeout) : null,
      receiveTimeout: receiveTimeout != null ? Duration(milliseconds: receiveTimeout) : null,
    );
  }
}