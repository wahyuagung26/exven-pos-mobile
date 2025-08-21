import 'package:freezed_annotation/freezed_annotation.dart';
import 'pagination_model.dart';

part 'api_response_model.freezed.dart';
part 'api_response_model.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponseModel<T> with _$ApiResponseModel<T> {
  const factory ApiResponseModel({
    required String message,
    required bool success,
    T? data,
    PaginationModel? meta,
    Map<String, List<String>>? errors,
  }) = _ApiResponseModel<T>;

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseModelFromJson(json, fromJsonT);
}