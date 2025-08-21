// Temporary implementation until build_runner generates the actual Freezed files

abstract class Failure {
  const Failure();
  
  // Factory constructors for different failure types
  static NetworkFailure network(String message, [int? statusCode]) => 
      NetworkFailure(message, statusCode);
  static AuthFailure auth(String message) => AuthFailure(message);
  static ValidationFailure validation(String message) => ValidationFailure(message);
  static DatabaseFailure database(String message, [String? sqlError]) => 
      DatabaseFailure(message, sqlError);
  static UnknownFailure unknown(String message) => UnknownFailure(message);
  static CacheFailure cache(String message) => CacheFailure(message);
}

class NetworkFailure extends Failure {
  final String message;
  final int? statusCode;
  
  const NetworkFailure(this.message, [this.statusCode]);
}

class AuthFailure extends Failure {
  final String message;
  
  const AuthFailure(this.message);
}

class ValidationFailure extends Failure {
  final String message;
  
  const ValidationFailure(this.message);
}

class DatabaseFailure extends Failure {
  final String message;
  final String? sqlError;
  
  const DatabaseFailure(this.message, [this.sqlError]);
  
  @override
  String toString() {
    if (sqlError != null) {
      return 'DatabaseFailure: $message (SQL Error: $sqlError)';
    }
    return 'DatabaseFailure: $message';
  }
}

class UnknownFailure extends Failure {
  final String message;
  
  const UnknownFailure(this.message);
}

class CacheFailure extends Failure {
  final String message;
  
  const CacheFailure(this.message);
}