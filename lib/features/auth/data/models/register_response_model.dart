import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'register_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterResponseModel {
  final String message;
  final RegisterDataModel data;
  final dynamic meta;

  const RegisterResponseModel({
    required this.message,
    required this.data,
    this.meta,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterDataModel {
  final int tenantId;
  final UserModel user;
  final String message;

  const RegisterDataModel({
    required this.tenantId,
    required this.user,
    required this.message,
  });

  factory RegisterDataModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDataModelToJson(this);
}