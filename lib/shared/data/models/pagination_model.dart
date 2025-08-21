import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/pagination_entity.dart';

part 'pagination_model.freezed.dart';
part 'pagination_model.g.dart';

@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_items') required int totalItems,
    @JsonKey(name: 'items_per_page') required int itemsPerPage,
    @JsonKey(name: 'has_next_page') required bool hasNextPage,
    @JsonKey(name: 'has_previous_page') required bool hasPreviousPage,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}

extension PaginationModelExtension on PaginationModel {
  PaginationEntity toEntity() {
    return PaginationEntity(
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      itemsPerPage: itemsPerPage,
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
    );
  }
}