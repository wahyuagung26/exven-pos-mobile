import 'package:equatable/equatable.dart';

import 'role.dart';

class User extends Equatable {
  final int id;
  final int tenantId;
  final String email;
  final String fullName;
  final String? phone;
  final bool isActive;
  final Role role;

  const User({
    required this.id,
    required this.tenantId,
    required this.email,
    required this.fullName,
    this.phone,
    required this.isActive,
    required this.role,
  });

  User copyWith({
    int? id,
    int? tenantId,
    String? email,
    String? fullName,
    String? phone,
    bool? isActive,
    Role? role,
  }) {
    return User(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
        id,
        tenantId,
        email,
        fullName,
        phone,
        isActive,
        role,
      ];

  @override
  String toString() {
    return 'User(id: $id, tenantId: $tenantId, email: $email, fullName: $fullName, phone: $phone, isActive: $isActive, role: $role)';
  }
}