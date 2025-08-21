import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/domain/entities/base_entity.dart';

part 'user_entity.freezed.dart';

enum UserRole { admin, manager, cashier }

@freezed
class UserEntity extends BaseEntity with _$UserEntity {
  const factory UserEntity({
    required int id,
    required String email,
    required String name,
    required UserRole role,
    required List<String> permissions,
    required int tenantId,
    String? phone,
    String? avatarUrl,
    DateTime? lastLoginAt,
  }) = _UserEntity;
}
