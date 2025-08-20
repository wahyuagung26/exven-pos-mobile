// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pair_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPairModel _$TokenPairModelFromJson(Map<String, dynamic> json) =>
    TokenPairModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: (json['expires_in'] as num).toInt(),
    );

Map<String, dynamic> _$TokenPairModelToJson(TokenPairModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
    };
