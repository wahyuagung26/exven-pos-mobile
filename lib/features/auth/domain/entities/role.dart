import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String name;
  final String displayName;
  final List<String> permissions;

  const Role({
    required this.id,
    required this.name,
    required this.displayName,
    required this.permissions,
  });

  Role copyWith({
    int? id,
    String? name,
    String? displayName,
    List<String>? permissions,
  }) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  List<Object?> get props => [id, name, displayName, permissions];

  @override
  String toString() {
    return 'Role(id: $id, name: $name, displayName: $displayName, permissions: $permissions)';
  }
}