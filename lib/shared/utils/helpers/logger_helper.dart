/// Logging utilities with different levels and output options
/// 
/// This file contains utility functions for logging with various levels,
/// file output, and filtering capabilities for debugging and monitoring.

import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';

/// Log levels enumeration
enum LogLevel {
  debug,
  info,
  warning,
  error,
  critical,
}

extension LogLevelExtension on LogLevel {
  String get name {
    switch (this) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARN';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.critical:
        return 'CRITICAL';
    }
  }
  
  int get priority {
    switch (this) {
      case LogLevel.debug:
        return 0;
      case LogLevel.info:
        return 1;
      case LogLevel.warning:
        return 2;
      case LogLevel.error:
        return 3;
      case LogLevel.critical:
        return 4;
    }
  }
  
  String get emoji {
    switch (this) {
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
      case LogLevel.critical:
        return '🚨';
    }
  }
}

/// Logger configuration class
class LoggerConfig {
  final LogLevel minLevel;
  final bool enableConsoleOutput;
  final bool enableFileOutput;
  final bool enableColors;
  final bool includeTimestamp;
  final bool includeLevel;
  final bool includeEmoji;
  final String? logFilePath;
  final int maxFileSize;
  final int maxFiles;
  
  const LoggerConfig({
    this.minLevel = LogLevel.info,
    this.enableConsoleOutput = true,
    this.enableFileOutput = false,
    this.enableColors = true,
    this.includeTimestamp = true,
    this.includeLevel = true,
    this.includeEmoji = false,
    this.logFilePath,
    this.maxFileSize = 10 * 1024 * 1024, // 10MB
    this.maxFiles = 5,
  });
}

/// Logger helper utility class with static methods
class LoggerHelper {
  static LoggerConfig _config = const LoggerConfig();
  static final DateFormat _timestampFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  
  /// Initialize logger with configuration
  static void initialize(LoggerConfig config) {
    _config = config;
  }
  
  /// Log debug message
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, error, stackTrace);
  }
  
  /// Log info message
  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, error, stackTrace);
  }
  
  /// Log warning message
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, message, error, stackTrace);
  }
  
  /// Log error message
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }
  
  /// Log critical message
  static void critical(String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.critical, message, error, stackTrace);
  }
  
  /// Log API request
  static void apiRequest(String method, String url, [Map<String, dynamic>? headers, Object? body]) {
    final message = 'API Request: $method $url';
    final details = <String, dynamic>{};
    
    if (headers != null && headers.isNotEmpty) {
      details['headers'] = headers;
    }
    
    if (body != null) {
      details['body'] = body;
    }
    
    if (details.isNotEmpty) {
      debug('$message\nDetails: ${_formatJson(details)}');
    } else {
      debug(message);
    }
  }
  
  /// Log API response
  static void apiResponse(int statusCode, String url, [Object? responseBody, Duration? duration]) {
    final message = 'API Response: $statusCode $url';
    final details = <String, dynamic>{
      'status_code': statusCode,
    };
    
    if (duration != null) {
      details['duration'] = '${duration.inMilliseconds}ms';
    }
    
    if (responseBody != null) {
      details['body'] = responseBody;
    }
    
    final level = statusCode >= 400 ? LogLevel.error : LogLevel.debug;
    _log(level, '$message\nDetails: ${_formatJson(details)}');
  }
  
  /// Log database query
  static void database(String query, [List<dynamic>? parameters, Duration? duration]) {
    final message = 'Database Query: $query';
    final details = <String, dynamic>{};
    
    if (parameters != null && parameters.isNotEmpty) {
      details['parameters'] = parameters;
    }
    
    if (duration != null) {
      details['duration'] = '${duration.inMilliseconds}ms';
    }
    
    if (details.isNotEmpty) {
      debug('$message\nDetails: ${_formatJson(details)}');
    } else {
      debug(message);
    }
  }
  
  /// Log user action
  static void userAction(String action, [Map<String, dynamic>? context]) {
    final message = 'User Action: $action';
    
    if (context != null && context.isNotEmpty) {
      info('$message\nContext: ${_formatJson(context)}');
    } else {
      info(message);
    }
  }
  
  /// Log performance measurement
  static void performance(String operation, Duration duration, [Map<String, dynamic>? metrics]) {
    final message = 'Performance: $operation took ${duration.inMilliseconds}ms';
    
    if (metrics != null && metrics.isNotEmpty) {
      info('$message\nMetrics: ${_formatJson(metrics)}');
    } else {
      info(message);
    }
  }
  
  /// Log security event
  static void security(String event, [Map<String, dynamic>? details]) {
    final message = 'Security Event: $event';
    
    if (details != null && details.isNotEmpty) {
      warning('$message\nDetails: ${_formatJson(details)}');
    } else {
      warning(message);
    }
  }
  
  /// Log business event
  static void business(String event, [Map<String, dynamic>? data]) {
    final message = 'Business Event: $event';
    
    if (data != null && data.isNotEmpty) {
      info('$message\nData: ${_formatJson(data)}');
    } else {
      info(message);
    }
  }
  
  /// Log sync operation
  static void sync(String operation, bool success, [Map<String, dynamic>? details]) {
    final status = success ? 'SUCCESS' : 'FAILED';
    final message = 'Sync $operation: $status';
    final level = success ? LogLevel.info : LogLevel.error;
    
    if (details != null && details.isNotEmpty) {
      _log(level, '$message\nDetails: ${_formatJson(details)}');
    } else {
      _log(level, message);
    }
  }
  
  /// Create a performance timer
  static PerformanceTimer startTimer(String operation) {
    return PerformanceTimer._(operation);
  }
  
  /// Flush logs to file (if file logging is enabled)
  static Future<void> flush() async {
    if (_config.enableFileOutput && _config.logFilePath != null) {
      // In a real implementation, you would flush any pending logs to file
      // This is a placeholder for the flush operation
    }
  }
  
  /// Clear log files
  static Future<void> clearLogs() async {
    if (_config.logFilePath != null) {
      try {
        final file = File(_config.logFilePath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        // Silently ignore errors when clearing logs
      }
    }
  }
  
  /// Get log file size in bytes
  static Future<int> getLogFileSize() async {
    if (_config.logFilePath != null) {
      try {
        final file = File(_config.logFilePath!);
        if (await file.exists()) {
          return await file.length();
        }
      } catch (e) {
        // Return 0 if unable to get file size
      }
    }
    return 0;
  }
  
  /// Internal logging method
  static void _log(LogLevel level, String message, [Object? error, StackTrace? stackTrace]) {
    // Check if log level meets minimum threshold
    if (level.priority < _config.minLevel.priority) {
      return;
    }
    
    final timestamp = DateTime.now();
    final formattedMessage = _formatLogMessage(level, timestamp, message, error, stackTrace);
    
    // Output to console
    if (_config.enableConsoleOutput) {
      _outputToConsole(level, formattedMessage);
    }
    
    // Output to file
    if (_config.enableFileOutput && _config.logFilePath != null) {
      _outputToFile(formattedMessage);
    }
  }
  
  /// Format log message
  static String _formatLogMessage(
    LogLevel level,
    DateTime timestamp,
    String message,
    Object? error,
    StackTrace? stackTrace,
  ) {
    final buffer = StringBuffer();
    
    // Add timestamp
    if (_config.includeTimestamp) {
      buffer.write('[${_timestampFormat.format(timestamp)}] ');
    }
    
    // Add emoji
    if (_config.includeEmoji) {
      buffer.write('${level.emoji} ');
    }
    
    // Add level
    if (_config.includeLevel) {
      buffer.write('[${level.name.padRight(8)}] ');
    }
    
    // Add message
    buffer.write(message);
    
    // Add error if present
    if (error != null) {
      buffer.write('\nError: $error');
    }
    
    // Add stack trace if present
    if (stackTrace != null) {
      buffer.write('\nStack Trace:\n$stackTrace');
    }
    
    return buffer.toString();
  }
  
  /// Output to console with colors
  static void _outputToConsole(LogLevel level, String message) {
    if (_config.enableColors) {
      final coloredMessage = _addConsoleColors(level, message);
      print(coloredMessage);
    } else {
      print(message);
    }
  }
  
  /// Add console colors based on log level
  static String _addConsoleColors(LogLevel level, String message) {
    const String reset = '\x1B[0m';
    const String bright = '\x1B[1m';
    
    String color;
    switch (level) {
      case LogLevel.debug:
        color = '\x1B[36m'; // Cyan
        break;
      case LogLevel.info:
        color = '\x1B[32m'; // Green
        break;
      case LogLevel.warning:
        color = '\x1B[33m'; // Yellow
        break;
      case LogLevel.error:
        color = '\x1B[31m'; // Red
        break;
      case LogLevel.critical:
        color = '\x1B[35m$bright'; // Bright Magenta
        break;
    }
    
    return '$color$message$reset';
  }
  
  /// Output to file
  static void _outputToFile(String message) {
    if (_config.logFilePath == null) return;
    
    try {
      final file = File(_config.logFilePath!);
      file.writeAsStringSync('$message\n', mode: FileMode.append);
      
      // Check file size and rotate if necessary
      _rotateLogFileIfNeeded(file);
    } catch (e) {
      // Silently ignore file write errors to prevent logging loops
    }
  }
  
  /// Rotate log file if it exceeds maximum size
  static void _rotateLogFileIfNeeded(File file) {
    try {
      if (file.lengthSync() > _config.maxFileSize) {
        _rotateLogFiles();
      }
    } catch (e) {
      // Silently ignore rotation errors
    }
  }
  
  /// Rotate log files
  static void _rotateLogFiles() {
    if (_config.logFilePath == null) return;
    
    try {
      final basePath = _config.logFilePath!;
      
      // Delete oldest log file if exists
      final oldestLogPath = '$basePath.${_config.maxFiles}';
      final oldestFile = File(oldestLogPath);
      if (oldestFile.existsSync()) {
        oldestFile.deleteSync();
      }
      
      // Rotate existing log files
      for (int i = _config.maxFiles - 1; i > 0; i--) {
        final currentPath = i == 1 ? basePath : '$basePath.$i';
        final nextPath = '$basePath.${i + 1}';
        
        final currentFile = File(currentPath);
        if (currentFile.existsSync()) {
          currentFile.renameSync(nextPath);
        }
      }
      
      // Create new log file
      File(basePath).writeAsStringSync('');
    } catch (e) {
      // Silently ignore rotation errors
    }
  }
  
  /// Format JSON for logging
  static String _formatJson(Object data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (e) {
      return data.toString();
    }
  }
}

/// Performance timer class
class PerformanceTimer {
  final String _operation;
  final DateTime _startTime;
  
  PerformanceTimer._(this._operation) : _startTime = DateTime.now();
  
  /// Stop the timer and log the performance
  void stop([Map<String, dynamic>? metrics]) {
    final duration = DateTime.now().difference(_startTime);
    LoggerHelper.performance(_operation, duration, metrics);
  }
  
  /// Get elapsed time without stopping the timer
  Duration get elapsed => DateTime.now().difference(_startTime);
}

/// Log entry model for structured logging
class LogEntry {
  final DateTime timestamp;
  final LogLevel level;
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? metadata;
  
  const LogEntry({
    required this.timestamp,
    required this.level,
    required this.message,
    this.error,
    this.stackTrace,
    this.metadata,
  });
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'level': level.name,
      'message': message,
      if (error != null) 'error': error.toString(),
      if (stackTrace != null) 'stackTrace': stackTrace.toString(),
      if (metadata != null) 'metadata': metadata,
    };
  }
  
  @override
  String toString() {
    return 'LogEntry(${level.name}: $message)';
  }
}

/// Logger middleware for HTTP requests
class LoggerMiddleware {
  /// Log HTTP request
  static void logRequest(String method, String url, Map<String, String>? headers, Object? body) {
    LoggerHelper.apiRequest(method, url, headers, body);
  }
  
  /// Log HTTP response
  static void logResponse(int statusCode, String url, Object? body, Duration duration) {
    LoggerHelper.apiResponse(statusCode, url, body, duration);
  }
  
  /// Log HTTP error
  static void logError(String method, String url, Object error, StackTrace? stackTrace) {
    LoggerHelper.error('HTTP Error: $method $url', error, stackTrace);
  }
}

/// Logger utilities for debugging
class LoggerUtils {
  /// Log object properties
  static void logObject(String name, Object object) {
    try {
      final json = _objectToMap(object);
      LoggerHelper.debug('Object $name: ${LoggerHelper._formatJson(json)}');
    } catch (e) {
      LoggerHelper.debug('Object $name: ${object.toString()}');
    }
  }
  
  /// Log function entry
  static void logFunctionEntry(String functionName, [Map<String, dynamic>? parameters]) {
    final message = 'Entering function: $functionName';
    
    if (parameters != null && parameters.isNotEmpty) {
      LoggerHelper.debug('$message\nParameters: ${LoggerHelper._formatJson(parameters)}');
    } else {
      LoggerHelper.debug(message);
    }
  }
  
  /// Log function exit
  static void logFunctionExit(String functionName, [dynamic result]) {
    final message = 'Exiting function: $functionName';
    
    if (result != null) {
      LoggerHelper.debug('$message\nResult: $result');
    } else {
      LoggerHelper.debug(message);
    }
  }
  
  /// Convert object to map for logging
  static Map<String, dynamic> _objectToMap(Object object) {
    // This is a simplified version. In a real implementation,
    // you might use reflection or other techniques to convert objects to maps
    return {'toString': object.toString(), 'runtimeType': object.runtimeType.toString()};
  }
}