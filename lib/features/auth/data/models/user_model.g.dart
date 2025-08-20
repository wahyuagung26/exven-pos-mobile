// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  tenantId: (json['tenant_id'] as num).toInt(),
  email: json['email'] as String,
  fullName: json['full_name'] as String,
  phone: json['phone'] as String?,
  isActive: json['is_active'] as bool,
  role: UserModel._roleFromJson(json['role'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'tenant_id': instance.tenantId,
  'email': instance.email,
  'full_name': instance.fullName,
  'phone': instance.phone,
  'is_active': instance.isActive,
  'role': UserModel._roleToJson(instance.role),
};
