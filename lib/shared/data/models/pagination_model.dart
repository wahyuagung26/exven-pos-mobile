import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pagination_entity.dart';

part 'pagination_model.freezed.dart';
part 'pagination_model.g.dart';

/// Model for pagination metadata from API responses
@freezed
class PaginationModel with _$PaginationModel {
  /// Creates a pagination model
  const factory PaginationModel({
    /// Current page number (1-indexed)
    @JsonKey(name: 'current_page') required int currentPage,
    
    /// Total number of pages
    @JsonKey(name: 'total_pages') required int totalPages,
    
    /// Number of items per page
    @JsonKey(name: 'per_page') required int perPage,
    
    /// Total number of items
    @JsonKey(name: 'total_items') required int totalItems,
    
    /// Whether there is a next page
    @JsonKey(name: 'has_next_page') @Default(false) bool hasNextPage,
    
    /// Whether there is a previous page
    @JsonKey(name: 'has_previous_page') @Default(false) bool hasPreviousPage,
    
    /// Next page number if available
    @JsonKey(name: 'next_page') int? nextPage,
    
    /// Previous page number if available
    @JsonKey(name: 'previous_page') int? previousPage,
    
    /// Starting item index for current page
    @JsonKey(name: 'from') int? from,
    
    /// Ending item index for current page
    @JsonKey(name: 'to') int? to,
    
    /// Optional path for pagination links
    String? path,
    
    /// First page URL
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    
    /// Last page URL
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    
    /// Next page URL
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    
    /// Previous page URL
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
  }) = _PaginationModel;

  /// Creates a pagination model from JSON
  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  /// Private constructor for custom methods
  const PaginationModel._();

  /// Convert to domain entity
  PaginationEntity<T> toEntity<T>(List<T> items) {
    return PaginationEntity(
      items: items,
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: perPage,
      totalItems: totalItems,
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
      nextPage: nextPage,
      previousPage: previousPage,
    );
  }

  /// Create from Laravel paginator response
  factory PaginationModel.fromLaravel(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] as int,
      totalPages: json['last_page'] as int,
      perPage: json['per_page'] as int,
      totalItems: json['total'] as int,
      hasNextPage: json['current_page'] < json['last_page'],
      hasPreviousPage: json['current_page'] > 1,
      nextPage: json['current_page'] < json['last_page']
          ? (json['current_page'] as int) + 1
          : null,
      previousPage: json['current_page'] > 1
          ? (json['current_page'] as int) - 1
          : null,
      from: json['from'] as int?,
      to: json['to'] as int?,
      path: json['path'] as String?,
      firstPageUrl: json['first_page_url'] as String?,
      lastPageUrl: json['last_page_url'] as String?,
      nextPageUrl: json['next_page_url'] as String?,
      prevPageUrl: json['prev_page_url'] as String?,
    );
  }

  /// Create empty pagination
  factory PaginationModel.empty() {
    return const PaginationModel(
      currentPage: 1,
      totalPages: 0,
      perPage: 20,
      totalItems: 0,
      hasNextPage: false,
      hasPreviousPage: false,
    );
  }

  /// Check if pagination is empty
  bool get isEmpty => totalItems == 0;

  /// Check if pagination has items
  bool get isNotEmpty => totalItems > 0;

  /// Check if on first page
  bool get isFirstPage => currentPage == 1;

  /// Check if on last page
  bool get isLastPage => currentPage == totalPages;

  /// Get progress percentage
  double get progressPercentage {
    if (totalPages == 0) return 0;
    return (currentPage / totalPages) * 100;
  }

  /// Get human-readable range text
  String get rangeText {
    if (isEmpty) return 'No items';
    final start = from ?? ((currentPage - 1) * perPage) + 1;
    final end = to ?? (currentPage * perPage).clamp(0, totalItems);
    return '$start-$end of $totalItems';
  }
}

/// Simplified pagination for cursor-based pagination
@freezed
class CursorPaginationModel with _$CursorPaginationModel {
  /// Creates a cursor pagination model
  const factory CursorPaginationModel({
    /// Next cursor for pagination
    String? nextCursor,
    
    /// Previous cursor for pagination
    String? previousCursor,
    
    /// Whether there are more items
    required bool hasMore,
    
    /// Number of items in current page
    required int count,
    
    /// Total items if available
    int? total,
  }) = _CursorPaginationModel;

  /// Creates a cursor pagination model from JSON
  factory CursorPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationModelFromJson(json);

  /// Private constructor for custom methods
  const CursorPaginationModel._();

  /// Check if has next page
  bool get hasNext => nextCursor != null && hasMore;

  /// Check if has previous page
  bool get hasPrevious => previousCursor != null;

  /// Check if is empty
  bool get isEmpty => count == 0;
}

/// Offset-based pagination model
@freezed
class OffsetPaginationModel with _$OffsetPaginationModel {
  /// Creates an offset pagination model
  const factory OffsetPaginationModel({
    /// Current offset
    required int offset,
    
    /// Limit per request
    required int limit,
    
    /// Total number of items
    required int total,
    
    /// Whether there are more items
    required bool hasMore,
  }) = _OffsetPaginationModel;

  /// Creates an offset pagination model from JSON
  factory OffsetPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$OffsetPaginationModelFromJson(json);

  /// Private constructor for custom methods
  const OffsetPaginationModel._();

  /// Get next offset
  int get nextOffset => offset + limit;

  /// Get previous offset
  int get previousOffset => (offset - limit).clamp(0, total);

  /// Check if has next page
  bool get hasNext => nextOffset < total;

  /// Check if has previous page
  bool get hasPrevious => offset > 0;

  /// Get current page number (1-indexed)
  int get currentPage => (offset / limit).floor() + 1;

  /// Get total pages
  int get totalPages => (total / limit).ceil();

  /// Convert to standard pagination model
  PaginationModel toPaginationModel() {
    return PaginationModel(
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: limit,
      totalItems: total,
      hasNextPage: hasNext,
      hasPreviousPage: hasPrevious,
      nextPage: hasNext ? currentPage + 1 : null,
      previousPage: hasPrevious ? currentPage - 1 : null,
      from: offset + 1,
      to: (offset + limit).clamp(0, total),
    );
  }
}