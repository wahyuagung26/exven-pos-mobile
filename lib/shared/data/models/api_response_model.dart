// Temporary implementation until build_runner generates the actual Freezed files

import 'pagination_model.dart';

class ApiResponseModel<T> {
  final String message;
  final bool success;
  final T? data;
  final PaginationModel? meta;
  final Map<String, List<String>>? errors;

  const ApiResponseModel({
    required this.message,
    required this.success,
    this.data,
    this.meta,
    this.errors,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) {
    return ApiResponseModel(
      message: json['message'] as String,
      success: json['success'] as bool,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      meta: json['meta'] != null 
          ? PaginationModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
      errors: json['errors'] != null
          ? Map<String, List<String>>.from(
              (json['errors'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(
                  key,
                  List<String>.from(value as List),
                ),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      'message': message,
      'success': success,
      if (data != null) 'data': toJsonT(data as T),
      if (meta != null) 'meta': meta!.toJson(),
      if (errors != null) 'errors': errors,
    };
  }
}