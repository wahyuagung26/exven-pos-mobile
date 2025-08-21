import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String email,
    required String name,
    required String role,
    required List<String> permissions,
    @JsonKey(name: 'tenant_id') required int tenantId,
    String? phone,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelExtension on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      role: _mapStringToUserRole(role),
      permissions: permissions,
      tenantId: tenantId,
      phone: phone,
      avatarUrl: avatarUrl,
      lastLoginAt: lastLoginAt,
    );
  }

  UserRole _mapStringToUserRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'manager':
        return UserRole.manager;
      case 'cashier':
        return UserRole.cashier;
      default:
        return UserRole.cashier;
    }
  }
}