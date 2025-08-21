import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_entity.freezed.dart';

@freezed
class PaginationEntity with _$PaginationEntity {
  const factory PaginationEntity({
    required int currentPage,
    required int totalPages,
    required int totalItems,
    required int itemsPerPage,
    required bool hasNextPage,
    required bool hasPreviousPage,
  }) = _PaginationEntity;
}