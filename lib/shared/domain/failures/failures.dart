import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.network(String message, [int? statusCode]) = NetworkFailure;
  const factory Failure.auth(String message) = AuthFailure;
  const factory Failure.validation(String message) = ValidationFailure;
  const factory Failure.unknown(String message) = UnknownFailure;
  const factory Failure.cache(String message) = CacheFailure;
}