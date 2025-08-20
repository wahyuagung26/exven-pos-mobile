import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Interceptor for logging HTTP requests and responses
/// Only active in debug mode for development purposes
class LoggingInterceptor extends Interceptor {
  /// Maximum length of request/response body to log
  static const int maxLogLength = 1000;
  
  /// Whether to log request headers
  final bool logRequestHeaders;
  
  /// Whether to log response headers
  final bool logResponseHeaders;
  
  /// Whether to log request body
  final bool logRequestBody;
  
  /// Whether to log response body
  final bool logResponseBody;
  
  /// Whether to log errors
  final bool logErrors;

  /// Creates a logging interceptor
  LoggingInterceptor({
    this.logRequestHeaders = true,
    this.logResponseHeaders = false,
    this.logRequestBody = true,
    this.logResponseBody = true,
    this.logErrors = true,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (!kDebugMode) {
      handler.next(options);
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('╔══════════════════════════ REQUEST ══════════════════════════');
    buffer.writeln('║ ${options.method} ${options.uri}');
    
    if (logRequestHeaders && options.headers.isNotEmpty) {
      buffer.writeln('║ Headers:');
      options.headers.forEach((key, value) {
        // Hide sensitive headers
        if (_isSensitiveHeader(key)) {
          buffer.writeln('║   $key: [REDACTED]');
        } else {
          buffer.writeln('║   $key: $value');
        }
      });
    }
    
    if (logRequestBody && options.data != null) {
      buffer.writeln('║ Body:');
      final bodyStr = _formatBody(options.data);
      buffer.writeln('║   $bodyStr');
    }
    
    buffer.writeln('╚══════════════════════════════════════════════════════════════');
    debugPrint(buffer.toString());
    
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (!kDebugMode) {
      handler.next(response);
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('╔══════════════════════════ RESPONSE ═════════════════════════');
    buffer.writeln('║ ${response.requestOptions.method} ${response.requestOptions.uri}');
    buffer.writeln('║ Status: ${response.statusCode} ${response.statusMessage}');
    
    if (logResponseHeaders && response.headers.map.isNotEmpty) {
      buffer.writeln('║ Headers:');
      response.headers.forEach((key, values) {
        buffer.writeln('║   $key: ${values.join(', ')}');
      });
    }
    
    if (logResponseBody && response.data != null) {
      buffer.writeln('║ Body:');
      final bodyStr = _formatBody(response.data);
      buffer.writeln('║   $bodyStr');
    }
    
    buffer.writeln('╚══════════════════════════════════════════════════════════════');
    debugPrint(buffer.toString());
    
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (!kDebugMode || !logErrors) {
      handler.next(err);
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('╔══════════════════════════ ERROR ════════════════════════════');
    buffer.writeln('║ ${err.requestOptions.method} ${err.requestOptions.uri}');
    buffer.writeln('║ Error Type: ${err.type}');
    buffer.writeln('║ Error Message: ${err.message}');
    
    if (err.response != null) {
      buffer.writeln('║ Status: ${err.response!.statusCode} ${err.response!.statusMessage}');
      
      if (logResponseBody && err.response!.data != null) {
        buffer.writeln('║ Response Body:');
        final bodyStr = _formatBody(err.response!.data);
        buffer.writeln('║   $bodyStr');
      }
    }
    
    if (err.stackTrace != null) {
      buffer.writeln('║ Stack Trace:');
      final stackLines = err.stackTrace.toString().split('\n').take(5);
      for (final line in stackLines) {
        buffer.writeln('║   $line');
      }
    }
    
    buffer.writeln('╚══════════════════════════════════════════════════════════════');
    debugPrint(buffer.toString());
    
    handler.next(err);
  }

  /// Format request/response body for logging
  String _formatBody(dynamic body) {
    if (body == null) return 'null';
    
    String bodyStr;
    
    if (body is FormData) {
      final fields = <String>[];
      for (final field in body.fields) {
        fields.add('${field.key}: ${field.value}');
      }
      for (final file in body.files) {
        fields.add('${file.key}: [File: ${file.value.filename}]');
      }
      bodyStr = 'FormData { ${fields.join(', ')} }';
    } else if (body is Map || body is List) {
      try {
        bodyStr = const JsonEncoder.withIndent('  ').convert(body);
      } catch (e) {
        bodyStr = body.toString();
      }
    } else {
      bodyStr = body.toString();
    }
    
    // Truncate if too long
    if (bodyStr.length > maxLogLength) {
      bodyStr = '${bodyStr.substring(0, maxLogLength)}... [TRUNCATED]';
    }
    
    // Redact sensitive information
    bodyStr = _redactSensitiveInfo(bodyStr);
    
    return bodyStr;
  }

  /// Check if header contains sensitive information
  bool _isSensitiveHeader(String headerName) {
    final sensitiveHeaders = [
      'authorization',
      'cookie',
      'set-cookie',
      'x-api-key',
      'x-auth-token',
      'x-csrf-token',
    ];
    
    return sensitiveHeaders.contains(headerName.toLowerCase());
  }

  /// Redact sensitive information from body
  String _redactSensitiveInfo(String body) {
    // Redact password fields
    body = body.replaceAllMapped(
      RegExp(r'"password"\s*:\s*"[^"]*"'),
      (match) => '"password": "[REDACTED]"',
    );
    
    // Redact token fields
    body = body.replaceAllMapped(
      RegExp(r'"(access_token|refresh_token|token)"\s*:\s*"[^"]*"'),
      (match) => '"${match.group(1)}": "[REDACTED]"',
    );
    
    // Redact credit card numbers
    body = body.replaceAllMapped(
      RegExp(r'\b\d{4}[\s-]?\d{4}[\s-]?\d{4}[\s-]?\d{4}\b'),
      (match) => '[CARD_NUMBER_REDACTED]',
    );
    
    // Redact email addresses (optional)
    // body = body.replaceAllMapped(
    //   RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'),
    //   (match) => '[EMAIL_REDACTED]',
    // );
    
    return body;
  }
}

/// Simplified logging interceptor for production (only errors)
class ProductionLoggingInterceptor extends Interceptor {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    // In production, log errors to crash reporting service
    final errorInfo = {
      'url': err.requestOptions.uri.toString(),
      'method': err.requestOptions.method,
      'error_type': err.type.toString(),
      'error_message': err.message,
      'status_code': err.response?.statusCode,
      'response_data': err.response?.data,
    };
    
    // TODO: Send to crash reporting service (e.g., Sentry, Crashlytics)
    debugPrint('Production Error: $errorInfo');
    
    handler.next(err);
  }
}