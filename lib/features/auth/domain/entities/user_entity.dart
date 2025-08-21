class UserEntity {
  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.tenantId,
  });

  final String id;
  final String email;
  final String name;
  final String? tenantId;
}
