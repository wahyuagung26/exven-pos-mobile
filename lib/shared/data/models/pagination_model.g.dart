// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationModelImpl _$$PaginationModelImplFromJson(
  Map<String, dynamic> json,
) => _$PaginationModelImpl(
  currentPage: (json['current_page'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
  totalItems: (json['total_items'] as num).toInt(),
  hasNextPage: json['has_next_page'] as bool? ?? false,
  hasPreviousPage: json['has_previous_page'] as bool? ?? false,
  nextPage: (json['next_page'] as num?)?.toInt(),
  previousPage: (json['previous_page'] as num?)?.toInt(),
  from: (json['from'] as num?)?.toInt(),
  to: (json['to'] as num?)?.toInt(),
  path: json['path'] as String?,
  firstPageUrl: json['first_page_url'] as String?,
  lastPageUrl: json['last_page_url'] as String?,
  nextPageUrl: json['next_page_url'] as String?,
  prevPageUrl: json['prev_page_url'] as String?,
);

Map<String, dynamic> _$$PaginationModelImplToJson(
  _$PaginationModelImpl instance,
) => <String, dynamic>{
  'current_page': instance.currentPage,
  'total_pages': instance.totalPages,
  'per_page': instance.perPage,
  'total_items': instance.totalItems,
  'has_next_page': instance.hasNextPage,
  'has_previous_page': instance.hasPreviousPage,
  'next_page': instance.nextPage,
  'previous_page': instance.previousPage,
  'from': instance.from,
  'to': instance.to,
  'path': instance.path,
  'first_page_url': instance.firstPageUrl,
  'last_page_url': instance.lastPageUrl,
  'next_page_url': instance.nextPageUrl,
  'prev_page_url': instance.prevPageUrl,
};

_$CursorPaginationModelImpl _$$CursorPaginationModelImplFromJson(
  Map<String, dynamic> json,
) => _$CursorPaginationModelImpl(
  nextCursor: json['nextCursor'] as String?,
  previousCursor: json['previousCursor'] as String?,
  hasMore: json['hasMore'] as bool,
  count: (json['count'] as num).toInt(),
  total: (json['total'] as num?)?.toInt(),
);

Map<String, dynamic> _$$CursorPaginationModelImplToJson(
  _$CursorPaginationModelImpl instance,
) => <String, dynamic>{
  'nextCursor': instance.nextCursor,
  'previousCursor': instance.previousCursor,
  'hasMore': instance.hasMore,
  'count': instance.count,
  'total': instance.total,
};

_$OffsetPaginationModelImpl _$$OffsetPaginationModelImplFromJson(
  Map<String, dynamic> json,
) => _$OffsetPaginationModelImpl(
  offset: (json['offset'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  hasMore: json['hasMore'] as bool,
);

Map<String, dynamic> _$$OffsetPaginationModelImplToJson(
  _$OffsetPaginationModelImpl instance,
) => <String, dynamic>{
  'offset': instance.offset,
  'limit': instance.limit,
  'total': instance.total,
  'hasMore': instance.hasMore,
};
