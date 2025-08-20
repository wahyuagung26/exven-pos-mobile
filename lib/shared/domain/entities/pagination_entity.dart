/// Entity representing paginated data
class PaginationEntity<T> {
  /// List of items in the current page
  final List<T> items;
  
  /// Current page number (1-indexed)
  final int currentPage;
  
  /// Total number of pages
  final int totalPages;
  
  /// Number of items per page
  final int perPage;
  
  /// Total number of items across all pages
  final int totalItems;
  
  /// Whether there is a next page
  final bool hasNextPage;
  
  /// Whether there is a previous page
  final bool hasPreviousPage;
  
  /// Next page number if available
  final int? nextPage;
  
  /// Previous page number if available
  final int? previousPage;

  /// Creates a pagination entity
  const PaginationEntity({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
    required this.totalItems,
    this.hasNextPage = false,
    this.hasPreviousPage = false,
    this.nextPage,
    this.previousPage,
  });

  /// Factory constructor for easier creation
  factory PaginationEntity.fromData({
    required List<T> items,
    required int currentPage,
    required int totalItems,
    required int perPage,
  }) {
    final totalPages = (totalItems / perPage).ceil();
    final hasNext = currentPage < totalPages;
    final hasPrev = currentPage > 1;
    
    return PaginationEntity(
      items: items,
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: perPage,
      totalItems: totalItems,
      hasNextPage: hasNext,
      hasPreviousPage: hasPrev,
      nextPage: hasNext ? currentPage + 1 : null,
      previousPage: hasPrev ? currentPage - 1 : null,
    );
  }

  /// Creates an empty pagination result
  factory PaginationEntity.empty() {
    return PaginationEntity(
      items: [],
      currentPage: 1,
      totalPages: 0,
      perPage: 20,
      totalItems: 0,
      hasNextPage: false,
      hasPreviousPage: false,
    );
  }

  /// Check if pagination is empty
  bool get isEmpty => items.isEmpty;

  /// Check if pagination has items
  bool get isNotEmpty => items.isNotEmpty;

  /// Get the starting item index for current page
  int get startIndex => ((currentPage - 1) * perPage) + 1;

  /// Get the ending item index for current page
  int get endIndex {
    final end = currentPage * perPage;
    return end > totalItems ? totalItems : end;
  }

  /// Creates a copy of pagination with updated values
  PaginationEntity<T> copyWith({
    List<T>? items,
    int? currentPage,
    int? totalPages,
    int? perPage,
    int? totalItems,
    bool? hasNextPage,
    bool? hasPreviousPage,
    int? nextPage,
    int? previousPage,
  }) {
    return PaginationEntity(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      perPage: perPage ?? this.perPage,
      totalItems: totalItems ?? this.totalItems,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
      nextPage: nextPage ?? this.nextPage,
      previousPage: previousPage ?? this.previousPage,
    );
  }

  /// Map items to a different type while preserving pagination metadata
  PaginationEntity<R> map<R>(R Function(T) mapper) {
    return PaginationEntity(
      items: items.map(mapper).toList(),
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

  @override
  String toString() {
    return 'PaginationEntity(page: $currentPage/$totalPages, items: ${items.length}/$totalItems)';
  }
}

/// Request parameters for pagination
class PaginationParams {
  /// Page number to fetch (1-indexed)
  final int page;
  
  /// Number of items per page
  final int perPage;
  
  /// Sort field
  final String? sortBy;
  
  /// Sort direction (asc or desc)
  final String? sortDirection;
  
  /// Search query
  final String? search;
  
  /// Additional filters
  final Map<String, dynamic>? filters;

  /// Creates pagination parameters
  const PaginationParams({
    this.page = 1,
    this.perPage = 20,
    this.sortBy,
    this.sortDirection = 'asc',
    this.search,
    this.filters,
  });

  /// Convert to query parameters for API requests
  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };

    if (sortBy != null) {
      params['sort_by'] = sortBy;
      params['sort_direction'] = sortDirection;
    }

    if (search != null && search!.isNotEmpty) {
      params['search'] = search;
    }

    if (filters != null && filters!.isNotEmpty) {
      params.addAll(filters!);
    }

    return params;
  }

  /// Creates a copy with updated values
  PaginationParams copyWith({
    int? page,
    int? perPage,
    String? sortBy,
    String? sortDirection,
    String? search,
    Map<String, dynamic>? filters,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      sortBy: sortBy ?? this.sortBy,
      sortDirection: sortDirection ?? this.sortDirection,
      search: search ?? this.search,
      filters: filters ?? this.filters,
    );
  }

  /// Creates parameters for the next page
  PaginationParams nextPage() {
    return copyWith(page: page + 1);
  }

  /// Creates parameters for the previous page
  PaginationParams previousPage() {
    return copyWith(page: page > 1 ? page - 1 : 1);
  }
}