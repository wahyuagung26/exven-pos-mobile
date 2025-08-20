import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';
import 'role_model.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends User {
  @override
  @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson)
  final RoleModel role;

  const UserModel({
    required super.id,
    required super.tenantId,
    required super.email,
    required super.fullName,
    super.phone,
    required super.isActive,
    required this.role,
  }) : super(role: role);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static RoleModel _roleFromJson(Map<String, dynamic> json) =>
      RoleModel.fromJson(json);

  static Map<String, dynamic> _roleToJson(RoleModel role) => role.toJson();

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        tenantId: user.tenantId,
        email: user.email,
        fullName: user.fullName,
        phone: user.phone,
        isActive: user.isActive,
        role: user.role is RoleModel 
            ? user.role as RoleModel 
            : RoleModel.fromEntity(user.role),
      );

  User toEntity() => User(
        id: id,
        tenantId: tenantId,
        email: email,
        fullName: fullName,
        phone: phone,
        isActive: isActive,
        role: role,
      );
}