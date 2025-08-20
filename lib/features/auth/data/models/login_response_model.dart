import 'package:json_annotation/json_annotation.dart';

import 'token_pair_model.dart';
import 'user_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponseModel {
  final String message;
  final LoginDataModel data;
  final dynamic meta;

  const LoginResponseModel({
    required this.message,
    required this.data,
    this.meta,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginDataModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final UserModel user;

  const LoginDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);

  TokenPairModel toTokenPair() => TokenPairModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
      );
}