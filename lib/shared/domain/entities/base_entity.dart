/// Base entity class for all domain entities
/// Provides common properties and functionality for domain objects
abstract class BaseEntity {
  /// Unique identifier for the entity
  final int? id;
  
  /// Timestamp when the entity was created
  final DateTime? createdAt;
  
  /// Timestamp when the entity was last updated
  final DateTime? updatedAt;

  /// Creates a base entity with common properties
  const BaseEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  /// Check if entity is new (not persisted)
  bool get isNew => id == null;

  /// Check if entity is persisted
  bool get isPersisted => id != null;
  
  /// Convert entity to JSON for serialization
  /// Must be implemented by concrete entities
  Map<String, dynamic> toJson();
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BaseEntity) return false;
    
    // Two entities are equal if they have the same id and are persisted
    if (isPersisted && other.isPersisted) {
      return id == other.id && runtimeType == other.runtimeType;
    }
    
    // For non-persisted entities, use object identity
    return false;
  }
  
  @override
  int get hashCode {
    if (isPersisted) {
      return Object.hash(runtimeType, id);
    }
    return super.hashCode;
  }
}

/// Base entity with tenant isolation support
abstract class TenantAwareEntity extends BaseEntity {
  /// Tenant identifier for multi-tenant isolation
  final int? tenantId;

  /// Creates a tenant-aware entity
  const TenantAwareEntity({
    super.id,
    super.createdAt,
    super.updatedAt,
    this.tenantId,
  });
}

/// Base entity with soft delete support
abstract class SoftDeletableEntity extends BaseEntity {
  /// Indicates if the entity is active/not deleted
  final bool isActive;
  
  /// Timestamp when the entity was deleted (soft delete)
  final DateTime? deletedAt;

  /// Creates a soft-deletable entity
  const SoftDeletableEntity({
    super.id,
    super.createdAt,
    super.updatedAt,
    this.isActive = true,
    this.deletedAt,
  });

  /// Check if entity is deleted
  bool get isDeleted => deletedAt != null || !isActive;
}

/// Base entity with full audit trail support
abstract class AuditableEntity extends TenantAwareEntity {
  /// User ID who created the entity
  final int? createdBy;
  
  /// User ID who last updated the entity
  final int? updatedBy;
  
  /// IP address from where the entity was created
  final String? createdFromIp;
  
  /// IP address from where the entity was last updated
  final String? updatedFromIp;

  /// Creates an auditable entity
  const AuditableEntity({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.tenantId,
    this.createdBy,
    this.updatedBy,
    this.createdFromIp,
    this.updatedFromIp,
  });
}