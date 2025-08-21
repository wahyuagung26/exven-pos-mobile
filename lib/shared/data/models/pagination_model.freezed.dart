// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) {
  return _PaginationModel.fromJson(json);
}

/// @nodoc
mixin _$PaginationModel {
  /// Current page number (1-indexed)
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;

  /// Total number of pages
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;

  /// Number of items per page
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Total number of items
  @JsonKey(name: 'total_items')
  int get totalItems => throw _privateConstructorUsedError;

  /// Whether there is a next page
  @JsonKey(name: 'has_next_page')
  bool get hasNextPage => throw _privateConstructorUsedError;

  /// Whether there is a previous page
  @JsonKey(name: 'has_previous_page')
  bool get hasPreviousPage => throw _privateConstructorUsedError;

  /// Next page number if available
  @JsonKey(name: 'next_page')
  int? get nextPage => throw _privateConstructorUsedError;

  /// Previous page number if available
  @JsonKey(name: 'previous_page')
  int? get previousPage => throw _privateConstructorUsedError;

  /// Starting item index for current page
  @JsonKey(name: 'from')
  int? get from => throw _privateConstructorUsedError;

  /// Ending item index for current page
  @JsonKey(name: 'to')
  int? get to => throw _privateConstructorUsedError;

  /// Optional path for pagination links
  String? get path => throw _privateConstructorUsedError;

  /// First page URL
  @JsonKey(name: 'first_page_url')
  String? get firstPageUrl => throw _privateConstructorUsedError;

  /// Last page URL
  @JsonKey(name: 'last_page_url')
  String? get lastPageUrl => throw _privateConstructorUsedError;

  /// Next page URL
  @JsonKey(name: 'next_page_url')
  String? get nextPageUrl => throw _privateConstructorUsedError;

  /// Previous page URL
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl => throw _privateConstructorUsedError;

  /// Serializes this PaginationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationModelCopyWith<PaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationModelCopyWith<$Res> {
  factory $PaginationModelCopyWith(
    PaginationModel value,
    $Res Function(PaginationModel) then,
  ) = _$PaginationModelCopyWithImpl<$Res, PaginationModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'total_pages') int totalPages,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'total_items') int totalItems,
    @JsonKey(name: 'has_next_page') bool hasNextPage,
    @JsonKey(name: 'has_previous_page') bool hasPreviousPage,
    @JsonKey(name: 'next_page') int? nextPage,
    @JsonKey(name: 'previous_page') int? previousPage,
    @JsonKey(name: 'from') int? from,
    @JsonKey(name: 'to') int? to,
    String? path,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
  });
}

/// @nodoc
class _$PaginationModelCopyWithImpl<$Res, $Val extends PaginationModel>
    implements $PaginationModelCopyWith<$Res> {
  _$PaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? totalPages = null,
    Object? perPage = null,
    Object? totalItems = null,
    Object? hasNextPage = null,
    Object? hasPreviousPage = null,
    Object? nextPage = freezed,
    Object? previousPage = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? path = freezed,
    Object? firstPageUrl = freezed,
    Object? lastPageUrl = freezed,
    Object? nextPageUrl = freezed,
    Object? prevPageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalItems: null == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                      as int,
            hasNextPage: null == hasNextPage
                ? _value.hasNextPage
                : hasNextPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasPreviousPage: null == hasPreviousPage
                ? _value.hasPreviousPage
                : hasPreviousPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            nextPage: freezed == nextPage
                ? _value.nextPage
                : nextPage // ignore: cast_nullable_to_non_nullable
                      as int?,
            previousPage: freezed == previousPage
                ? _value.previousPage
                : previousPage // ignore: cast_nullable_to_non_nullable
                      as int?,
            from: freezed == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as int?,
            to: freezed == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as int?,
            path: freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstPageUrl: freezed == firstPageUrl
                ? _value.firstPageUrl
                : firstPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPageUrl: freezed == lastPageUrl
                ? _value.lastPageUrl
                : lastPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextPageUrl: freezed == nextPageUrl
                ? _value.nextPageUrl
                : nextPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            prevPageUrl: freezed == prevPageUrl
                ? _value.prevPageUrl
                : prevPageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginationModelImplCopyWith<$Res>
    implements $PaginationModelCopyWith<$Res> {
  factory _$$PaginationModelImplCopyWith(
    _$PaginationModelImpl value,
    $Res Function(_$PaginationModelImpl) then,
  ) = __$$PaginationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'total_pages') int totalPages,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'total_items') int totalItems,
    @JsonKey(name: 'has_next_page') bool hasNextPage,
    @JsonKey(name: 'has_previous_page') bool hasPreviousPage,
    @JsonKey(name: 'next_page') int? nextPage,
    @JsonKey(name: 'previous_page') int? previousPage,
    @JsonKey(name: 'from') int? from,
    @JsonKey(name: 'to') int? to,
    String? path,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
  });
}

/// @nodoc
class __$$PaginationModelImplCopyWithImpl<$Res>
    extends _$PaginationModelCopyWithImpl<$Res, _$PaginationModelImpl>
    implements _$$PaginationModelImplCopyWith<$Res> {
  __$$PaginationModelImplCopyWithImpl(
    _$PaginationModelImpl _value,
    $Res Function(_$PaginationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? totalPages = null,
    Object? perPage = null,
    Object? totalItems = null,
    Object? hasNextPage = null,
    Object? hasPreviousPage = null,
    Object? nextPage = freezed,
    Object? previousPage = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? path = freezed,
    Object? firstPageUrl = freezed,
    Object? lastPageUrl = freezed,
    Object? nextPageUrl = freezed,
    Object? prevPageUrl = freezed,
  }) {
    return _then(
      _$PaginationModelImpl(
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalItems: null == totalItems
            ? _value.totalItems
            : totalItems // ignore: cast_nullable_to_non_nullable
                  as int,
        hasNextPage: null == hasNextPage
            ? _value.hasNextPage
            : hasNextPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasPreviousPage: null == hasPreviousPage
            ? _value.hasPreviousPage
            : hasPreviousPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        nextPage: freezed == nextPage
            ? _value.nextPage
            : nextPage // ignore: cast_nullable_to_non_nullable
                  as int?,
        previousPage: freezed == previousPage
            ? _value.previousPage
            : previousPage // ignore: cast_nullable_to_non_nullable
                  as int?,
        from: freezed == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as int?,
        to: freezed == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as int?,
        path: freezed == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstPageUrl: freezed == firstPageUrl
            ? _value.firstPageUrl
            : firstPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPageUrl: freezed == lastPageUrl
            ? _value.lastPageUrl
            : lastPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextPageUrl: freezed == nextPageUrl
            ? _value.nextPageUrl
            : nextPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        prevPageUrl: freezed == prevPageUrl
            ? _value.prevPageUrl
            : prevPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationModelImpl extends _PaginationModel {
  const _$PaginationModelImpl({
    @JsonKey(name: 'current_page') required this.currentPage,
    @JsonKey(name: 'total_pages') required this.totalPages,
    @JsonKey(name: 'per_page') required this.perPage,
    @JsonKey(name: 'total_items') required this.totalItems,
    @JsonKey(name: 'has_next_page') this.hasNextPage = false,
    @JsonKey(name: 'has_previous_page') this.hasPreviousPage = false,
    @JsonKey(name: 'next_page') this.nextPage,
    @JsonKey(name: 'previous_page') this.previousPage,
    @JsonKey(name: 'from') this.from,
    @JsonKey(name: 'to') this.to,
    this.path,
    @JsonKey(name: 'first_page_url') this.firstPageUrl,
    @JsonKey(name: 'last_page_url') this.lastPageUrl,
    @JsonKey(name: 'next_page_url') this.nextPageUrl,
    @JsonKey(name: 'prev_page_url') this.prevPageUrl,
  }) : super._();

  factory _$PaginationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationModelImplFromJson(json);

  /// Current page number (1-indexed)
  @override
  @JsonKey(name: 'current_page')
  final int currentPage;

  /// Total number of pages
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;

  /// Number of items per page
  @override
  @JsonKey(name: 'per_page')
  final int perPage;

  /// Total number of items
  @override
  @JsonKey(name: 'total_items')
  final int totalItems;

  /// Whether there is a next page
  @override
  @JsonKey(name: 'has_next_page')
  final bool hasNextPage;

  /// Whether there is a previous page
  @override
  @JsonKey(name: 'has_previous_page')
  final bool hasPreviousPage;

  /// Next page number if available
  @override
  @JsonKey(name: 'next_page')
  final int? nextPage;

  /// Previous page number if available
  @override
  @JsonKey(name: 'previous_page')
  final int? previousPage;

  /// Starting item index for current page
  @override
  @JsonKey(name: 'from')
  final int? from;

  /// Ending item index for current page
  @override
  @JsonKey(name: 'to')
  final int? to;

  /// Optional path for pagination links
  @override
  final String? path;

  /// First page URL
  @override
  @JsonKey(name: 'first_page_url')
  final String? firstPageUrl;

  /// Last page URL
  @override
  @JsonKey(name: 'last_page_url')
  final String? lastPageUrl;

  /// Next page URL
  @override
  @JsonKey(name: 'next_page_url')
  final String? nextPageUrl;

  /// Previous page URL
  @override
  @JsonKey(name: 'prev_page_url')
  final String? prevPageUrl;

  @override
  String toString() {
    return 'PaginationModel(currentPage: $currentPage, totalPages: $totalPages, perPage: $perPage, totalItems: $totalItems, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage, nextPage: $nextPage, previousPage: $previousPage, from: $from, to: $to, path: $path, firstPageUrl: $firstPageUrl, lastPageUrl: $lastPageUrl, nextPageUrl: $nextPageUrl, prevPageUrl: $prevPageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationModelImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.hasPreviousPage, hasPreviousPage) ||
                other.hasPreviousPage == hasPreviousPage) &&
            (identical(other.nextPage, nextPage) ||
                other.nextPage == nextPage) &&
            (identical(other.previousPage, previousPage) ||
                other.previousPage == previousPage) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.firstPageUrl, firstPageUrl) ||
                other.firstPageUrl == firstPageUrl) &&
            (identical(other.lastPageUrl, lastPageUrl) ||
                other.lastPageUrl == lastPageUrl) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.prevPageUrl, prevPageUrl) ||
                other.prevPageUrl == prevPageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentPage,
    totalPages,
    perPage,
    totalItems,
    hasNextPage,
    hasPreviousPage,
    nextPage,
    previousPage,
    from,
    to,
    path,
    firstPageUrl,
    lastPageUrl,
    nextPageUrl,
    prevPageUrl,
  );

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationModelImplCopyWith<_$PaginationModelImpl> get copyWith =>
      __$$PaginationModelImplCopyWithImpl<_$PaginationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationModelImplToJson(this);
  }
}

abstract class _PaginationModel extends PaginationModel {
  const factory _PaginationModel({
    @JsonKey(name: 'current_page') required final int currentPage,
    @JsonKey(name: 'total_pages') required final int totalPages,
    @JsonKey(name: 'per_page') required final int perPage,
    @JsonKey(name: 'total_items') required final int totalItems,
    @JsonKey(name: 'has_next_page') final bool hasNextPage,
    @JsonKey(name: 'has_previous_page') final bool hasPreviousPage,
    @JsonKey(name: 'next_page') final int? nextPage,
    @JsonKey(name: 'previous_page') final int? previousPage,
    @JsonKey(name: 'from') final int? from,
    @JsonKey(name: 'to') final int? to,
    final String? path,
    @JsonKey(name: 'first_page_url') final String? firstPageUrl,
    @JsonKey(name: 'last_page_url') final String? lastPageUrl,
    @JsonKey(name: 'next_page_url') final String? nextPageUrl,
    @JsonKey(name: 'prev_page_url') final String? prevPageUrl,
  }) = _$PaginationModelImpl;
  const _PaginationModel._() : super._();

  factory _PaginationModel.fromJson(Map<String, dynamic> json) =
      _$PaginationModelImpl.fromJson;

  /// Current page number (1-indexed)
  @override
  @JsonKey(name: 'current_page')
  int get currentPage;

  /// Total number of pages
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;

  /// Number of items per page
  @override
  @JsonKey(name: 'per_page')
  int get perPage;

  /// Total number of items
  @override
  @JsonKey(name: 'total_items')
  int get totalItems;

  /// Whether there is a next page
  @override
  @JsonKey(name: 'has_next_page')
  bool get hasNextPage;

  /// Whether there is a previous page
  @override
  @JsonKey(name: 'has_previous_page')
  bool get hasPreviousPage;

  /// Next page number if available
  @override
  @JsonKey(name: 'next_page')
  int? get nextPage;

  /// Previous page number if available
  @override
  @JsonKey(name: 'previous_page')
  int? get previousPage;

  /// Starting item index for current page
  @override
  @JsonKey(name: 'from')
  int? get from;

  /// Ending item index for current page
  @override
  @JsonKey(name: 'to')
  int? get to;

  /// Optional path for pagination links
  @override
  String? get path;

  /// First page URL
  @override
  @JsonKey(name: 'first_page_url')
  String? get firstPageUrl;

  /// Last page URL
  @override
  @JsonKey(name: 'last_page_url')
  String? get lastPageUrl;

  /// Next page URL
  @override
  @JsonKey(name: 'next_page_url')
  String? get nextPageUrl;

  /// Previous page URL
  @override
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationModelImplCopyWith<_$PaginationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CursorPaginationModel _$CursorPaginationModelFromJson(
  Map<String, dynamic> json,
) {
  return _CursorPaginationModel.fromJson(json);
}

/// @nodoc
mixin _$CursorPaginationModel {
  /// Next cursor for pagination
  String? get nextCursor => throw _privateConstructorUsedError;

  /// Previous cursor for pagination
  String? get previousCursor => throw _privateConstructorUsedError;

  /// Whether there are more items
  bool get hasMore => throw _privateConstructorUsedError;

  /// Number of items in current page
  int get count => throw _privateConstructorUsedError;

  /// Total items if available
  int? get total => throw _privateConstructorUsedError;

  /// Serializes this CursorPaginationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CursorPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CursorPaginationModelCopyWith<CursorPaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CursorPaginationModelCopyWith<$Res> {
  factory $CursorPaginationModelCopyWith(
    CursorPaginationModel value,
    $Res Function(CursorPaginationModel) then,
  ) = _$CursorPaginationModelCopyWithImpl<$Res, CursorPaginationModel>;
  @useResult
  $Res call({
    String? nextCursor,
    String? previousCursor,
    bool hasMore,
    int count,
    int? total,
  });
}

/// @nodoc
class _$CursorPaginationModelCopyWithImpl<
  $Res,
  $Val extends CursorPaginationModel
>
    implements $CursorPaginationModelCopyWith<$Res> {
  _$CursorPaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CursorPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextCursor = freezed,
    Object? previousCursor = freezed,
    Object? hasMore = null,
    Object? count = null,
    Object? total = freezed,
  }) {
    return _then(
      _value.copyWith(
            nextCursor: freezed == nextCursor
                ? _value.nextCursor
                : nextCursor // ignore: cast_nullable_to_non_nullable
                      as String?,
            previousCursor: freezed == previousCursor
                ? _value.previousCursor
                : previousCursor // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            total: freezed == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CursorPaginationModelImplCopyWith<$Res>
    implements $CursorPaginationModelCopyWith<$Res> {
  factory _$$CursorPaginationModelImplCopyWith(
    _$CursorPaginationModelImpl value,
    $Res Function(_$CursorPaginationModelImpl) then,
  ) = __$$CursorPaginationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? nextCursor,
    String? previousCursor,
    bool hasMore,
    int count,
    int? total,
  });
}

/// @nodoc
class __$$CursorPaginationModelImplCopyWithImpl<$Res>
    extends
        _$CursorPaginationModelCopyWithImpl<$Res, _$CursorPaginationModelImpl>
    implements _$$CursorPaginationModelImplCopyWith<$Res> {
  __$$CursorPaginationModelImplCopyWithImpl(
    _$CursorPaginationModelImpl _value,
    $Res Function(_$CursorPaginationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CursorPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextCursor = freezed,
    Object? previousCursor = freezed,
    Object? hasMore = null,
    Object? count = null,
    Object? total = freezed,
  }) {
    return _then(
      _$CursorPaginationModelImpl(
        nextCursor: freezed == nextCursor
            ? _value.nextCursor
            : nextCursor // ignore: cast_nullable_to_non_nullable
                  as String?,
        previousCursor: freezed == previousCursor
            ? _value.previousCursor
            : previousCursor // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        total: freezed == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CursorPaginationModelImpl extends _CursorPaginationModel {
  const _$CursorPaginationModelImpl({
    this.nextCursor,
    this.previousCursor,
    required this.hasMore,
    required this.count,
    this.total,
  }) : super._();

  factory _$CursorPaginationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CursorPaginationModelImplFromJson(json);

  /// Next cursor for pagination
  @override
  final String? nextCursor;

  /// Previous cursor for pagination
  @override
  final String? previousCursor;

  /// Whether there are more items
  @override
  final bool hasMore;

  /// Number of items in current page
  @override
  final int count;

  /// Total items if available
  @override
  final int? total;

  @override
  String toString() {
    return 'CursorPaginationModel(nextCursor: $nextCursor, previousCursor: $previousCursor, hasMore: $hasMore, count: $count, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CursorPaginationModelImpl &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.previousCursor, previousCursor) ||
                other.previousCursor == previousCursor) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    nextCursor,
    previousCursor,
    hasMore,
    count,
    total,
  );

  /// Create a copy of CursorPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CursorPaginationModelImplCopyWith<_$CursorPaginationModelImpl>
  get copyWith =>
      __$$CursorPaginationModelImplCopyWithImpl<_$CursorPaginationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CursorPaginationModelImplToJson(this);
  }
}

abstract class _CursorPaginationModel extends CursorPaginationModel {
  const factory _CursorPaginationModel({
    final String? nextCursor,
    final String? previousCursor,
    required final bool hasMore,
    required final int count,
    final int? total,
  }) = _$CursorPaginationModelImpl;
  const _CursorPaginationModel._() : super._();

  factory _CursorPaginationModel.fromJson(Map<String, dynamic> json) =
      _$CursorPaginationModelImpl.fromJson;

  /// Next cursor for pagination
  @override
  String? get nextCursor;

  /// Previous cursor for pagination
  @override
  String? get previousCursor;

  /// Whether there are more items
  @override
  bool get hasMore;

  /// Number of items in current page
  @override
  int get count;

  /// Total items if available
  @override
  int? get total;

  /// Create a copy of CursorPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CursorPaginationModelImplCopyWith<_$CursorPaginationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OffsetPaginationModel _$OffsetPaginationModelFromJson(
  Map<String, dynamic> json,
) {
  return _OffsetPaginationModel.fromJson(json);
}

/// @nodoc
mixin _$OffsetPaginationModel {
  /// Current offset
  int get offset => throw _privateConstructorUsedError;

  /// Limit per request
  int get limit => throw _privateConstructorUsedError;

  /// Total number of items
  int get total => throw _privateConstructorUsedError;

  /// Whether there are more items
  bool get hasMore => throw _privateConstructorUsedError;

  /// Serializes this OffsetPaginationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OffsetPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OffsetPaginationModelCopyWith<OffsetPaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OffsetPaginationModelCopyWith<$Res> {
  factory $OffsetPaginationModelCopyWith(
    OffsetPaginationModel value,
    $Res Function(OffsetPaginationModel) then,
  ) = _$OffsetPaginationModelCopyWithImpl<$Res, OffsetPaginationModel>;
  @useResult
  $Res call({int offset, int limit, int total, bool hasMore});
}

/// @nodoc
class _$OffsetPaginationModelCopyWithImpl<
  $Res,
  $Val extends OffsetPaginationModel
>
    implements $OffsetPaginationModelCopyWith<$Res> {
  _$OffsetPaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OffsetPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? limit = null,
    Object? total = null,
    Object? hasMore = null,
  }) {
    return _then(
      _value.copyWith(
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OffsetPaginationModelImplCopyWith<$Res>
    implements $OffsetPaginationModelCopyWith<$Res> {
  factory _$$OffsetPaginationModelImplCopyWith(
    _$OffsetPaginationModelImpl value,
    $Res Function(_$OffsetPaginationModelImpl) then,
  ) = __$$OffsetPaginationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int offset, int limit, int total, bool hasMore});
}

/// @nodoc
class __$$OffsetPaginationModelImplCopyWithImpl<$Res>
    extends
        _$OffsetPaginationModelCopyWithImpl<$Res, _$OffsetPaginationModelImpl>
    implements _$$OffsetPaginationModelImplCopyWith<$Res> {
  __$$OffsetPaginationModelImplCopyWithImpl(
    _$OffsetPaginationModelImpl _value,
    $Res Function(_$OffsetPaginationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OffsetPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? limit = null,
    Object? total = null,
    Object? hasMore = null,
  }) {
    return _then(
      _$OffsetPaginationModelImpl(
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OffsetPaginationModelImpl extends _OffsetPaginationModel {
  const _$OffsetPaginationModelImpl({
    required this.offset,
    required this.limit,
    required this.total,
    required this.hasMore,
  }) : super._();

  factory _$OffsetPaginationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OffsetPaginationModelImplFromJson(json);

  /// Current offset
  @override
  final int offset;

  /// Limit per request
  @override
  final int limit;

  /// Total number of items
  @override
  final int total;

  /// Whether there are more items
  @override
  final bool hasMore;

  @override
  String toString() {
    return 'OffsetPaginationModel(offset: $offset, limit: $limit, total: $total, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OffsetPaginationModelImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, offset, limit, total, hasMore);

  /// Create a copy of OffsetPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OffsetPaginationModelImplCopyWith<_$OffsetPaginationModelImpl>
  get copyWith =>
      __$$OffsetPaginationModelImplCopyWithImpl<_$OffsetPaginationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OffsetPaginationModelImplToJson(this);
  }
}

abstract class _OffsetPaginationModel extends OffsetPaginationModel {
  const factory _OffsetPaginationModel({
    required final int offset,
    required final int limit,
    required final int total,
    required final bool hasMore,
  }) = _$OffsetPaginationModelImpl;
  const _OffsetPaginationModel._() : super._();

  factory _OffsetPaginationModel.fromJson(Map<String, dynamic> json) =
      _$OffsetPaginationModelImpl.fromJson;

  /// Current offset
  @override
  int get offset;

  /// Limit per request
  @override
  int get limit;

  /// Total number of items
  @override
  int get total;

  /// Whether there are more items
  @override
  bool get hasMore;

  /// Create a copy of OffsetPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OffsetPaginationModelImplCopyWith<_$OffsetPaginationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
