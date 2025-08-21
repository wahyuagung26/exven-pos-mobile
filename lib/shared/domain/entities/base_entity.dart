import '../../utils/date_helpers.dart';

/// Base entity class for offline-first POS system
/// 
/// Provides common fields and behavior for all entities:
/// - UUID v7 identifiers for time-ordered IDs
/// - Unix millisecond timestamps
/// - Soft delete support
/// - Audit trail (created_at, updated_at, deleted_at)
abstract class BaseEntity {
  /// Unique identifier (UUID v7)
  final String id;
  
  /// Creation timestamp in Unix milliseconds
  final int createdAt;
  
  /// Last update timestamp in Unix milliseconds
  final int updatedAt;
  
  /// Soft delete timestamp in Unix milliseconds (null if not deleted)
  final int? deletedAt;

  const BaseEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  /// Check if entity is deleted (soft delete)
  bool get isDeleted => deletedAt != null;

  /// Check if entity is active (not deleted)
  bool get isActive => deletedAt == null;

  /// Get created date as DateTime
  DateTime get createdDate => DateHelpers.fromUnixMillis(createdAt);

  /// Get updated date as DateTime
  DateTime get updatedDate => DateHelpers.fromUnixMillis(updatedAt);

  /// Get deleted date as DateTime (null if not deleted)
  DateTime? get deletedDate => 
      deletedAt != null ? DateHelpers.fromUnixMillis(deletedAt!) : null;

  /// Get time since creation
  String get timeSinceCreated => DateHelpers.getTimeAgo(createdAt);

  /// Get time since last update
  String get timeSinceUpdated => DateHelpers.getTimeAgo(updatedAt);

  /// Check if entity was created today
  bool get wasCreatedToday => DateHelpers.isToday(createdAt);

  /// Check if entity was updated today
  bool get wasUpdatedToday => DateHelpers.isToday(updatedAt);

  /// Create a map representation for database storage
  /// Subclasses should override and call super.toMap()
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return '${runtimeType}(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }
}

/// Mixin for entities that support sync tracking
mixin SyncableEntity on BaseEntity {
  /// Whether entity has been synced to cloud
  bool get syncedToCloud;
  
  /// Cloud entity ID after successful sync
  String? get cloudEntityId;
  
  /// Check if entity needs sync (has local changes)
  bool get needsSync => !syncedToCloud;
  
  /// Check if entity is synced and has cloud ID
  bool get isFullySynced => syncedToCloud && cloudEntityId != null;
}

/// Mixin for entities that support snapshot data
mixin SnapshotEntity on BaseEntity {
  /// Get snapshot data for historical preservation
  Map<String, dynamic> getSnapshot();
  
  /// Restore entity from snapshot data
  void restoreFromSnapshot(Map<String, dynamic> snapshot);
}

/// Mixin for entities with outlet association
mixin OutletEntity on BaseEntity {
  /// Outlet ID this entity belongs to
  String get outletId;
}

/// Mixin for entities with user/cashier association
mixin UserTrackingEntity on BaseEntity {
  /// User/cashier ID who created this entity
  String get cashierId;
  
  /// Snapshot of cashier name for historical data
  String get cashierNameSnapshot;
}

/// Abstract base class for entities that can be soft deleted
abstract class SoftDeletableEntity extends BaseEntity {
  const SoftDeletableEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  /// Mark entity as deleted (soft delete)
  SoftDeletableEntity markAsDeleted() {
    return copyWith(deletedAt: DateHelpers.now());
  }

  /// Restore deleted entity
  SoftDeletableEntity restore() {
    return copyWith(deletedAt: null);
  }

  /// Create a copy with updated fields
  /// Subclasses must implement this method
  SoftDeletableEntity copyWith({
    String? id,
    int? createdAt,
    int? updatedAt,
    int? deletedAt,
  });
}

/// Base class for aggregate roots in domain-driven design
abstract class AggregateRoot extends BaseEntity {
  const AggregateRoot({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  /// Domain events that occurred during entity lifecycle
  List<DomainEvent> get domainEvents => [];

  /// Clear all domain events
  void clearDomainEvents();
}

/// Base class for domain events
abstract class DomainEvent {
  final String eventId;
  final int occurredAt;
  final String aggregateId;

  const DomainEvent({
    required this.eventId,
    required this.occurredAt,
    required this.aggregateId,
  });

  /// Event type identifier
  String get eventType => runtimeType.toString();

  /// Convert event to map for serialization
  Map<String, dynamic> toMap();
}

/// Utility class for entity operations
class EntityUtils {
  /// Generate standardized entity map with audit fields
  static Map<String, dynamic> createEntityMap({
    required String id,
    int? createdAt,
    int? updatedAt,
    int? deletedAt,
    Map<String, dynamic>? additionalFields,
  }) {
    final now = DateHelpers.now();
    
    return {
      'id': id,
      'created_at': createdAt ?? now,
      'updated_at': updatedAt ?? now,
      'deleted_at': deletedAt,
      ...?additionalFields,
    };
  }

  /// Update entity map with new timestamp
  static Map<String, dynamic> updateEntityMap(
    Map<String, dynamic> original, {
    Map<String, dynamic>? updates,
  }) {
    return {
      ...original,
      'updated_at': DateHelpers.now(),
      ...?updates,
    };
  }

  /// Mark entity map as deleted
  static Map<String, dynamic> deleteEntityMap(Map<String, dynamic> original) {
    return {
      ...original,
      'deleted_at': DateHelpers.now(),
      'updated_at': DateHelpers.now(),
    };
  }

  /// Remove deleted entities from list
  static List<T> filterActive<T extends BaseEntity>(List<T> entities) {
    return entities.where((entity) => entity.isActive).toList();
  }

  /// Sort entities by creation date (newest first)
  static List<T> sortByCreated<T extends BaseEntity>(List<T> entities, {bool ascending = false}) {
    final sorted = List<T>.from(entities);
    sorted.sort((a, b) => ascending 
        ? a.createdAt.compareTo(b.createdAt)
        : b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  /// Sort entities by update date (newest first)
  static List<T> sortByUpdated<T extends BaseEntity>(List<T> entities, {bool ascending = false}) {
    final sorted = List<T>.from(entities);
    sorted.sort((a, b) => ascending 
        ? a.updatedAt.compareTo(b.updatedAt)
        : b.updatedAt.compareTo(a.updatedAt));
    return sorted;
  }
}