import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/token_pair.dart';

part 'token_pair_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenPairModel extends TokenPair {
  const TokenPairModel({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresIn,
  });

  factory TokenPairModel.fromJson(Map<String, dynamic> json) =>
      _$TokenPairModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenPairModelToJson(this);

  factory TokenPairModel.fromEntity(TokenPair tokenPair) => TokenPairModel(
        accessToken: tokenPair.accessToken,
        refreshToken: tokenPair.refreshToken,
        expiresIn: tokenPair.expiresIn,
      );

  TokenPair toEntity() => TokenPair(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
      );
}