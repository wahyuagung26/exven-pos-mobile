import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/role.dart';

part 'role_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RoleModel extends Role {
  const RoleModel({
    required super.id,
    required super.name,
    required super.displayName,
    required super.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoleModelToJson(this);

  factory RoleModel.fromEntity(Role role) => RoleModel(
        id: role.id,
        name: role.name,
        displayName: role.displayName,
        permissions: role.permissions,
      );

  Role toEntity() => Role(
        id: id,
        name: name,
        displayName: displayName,
        permissions: permissions,
      );
}