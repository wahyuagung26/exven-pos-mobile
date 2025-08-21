// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApiResponseModel<T> {
  /// Response message from server
  String get message => throw _privateConstructorUsedError;

  /// Response data payload
  T? get data => throw _privateConstructorUsedError;

  /// Pagination metadata for list responses
  PaginationModel? get meta => throw _privateConstructorUsedError;

  /// Field-specific errors for validation failures
  Map<String, List<String>>? get errors => throw _privateConstructorUsedError;

  /// Response timestamp
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Request ID for tracing
  String? get requestId => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseModelCopyWith<T, ApiResponseModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseModelCopyWith<T, $Res> {
  factory $ApiResponseModelCopyWith(
    ApiResponseModel<T> value,
    $Res Function(ApiResponseModel<T>) then,
  ) = _$ApiResponseModelCopyWithImpl<T, $Res, ApiResponseModel<T>>;
  @useResult
  $Res call({
    String message,
    T? data,
    PaginationModel? meta,
    Map<String, List<String>>? errors,
    DateTime? timestamp,
    String? requestId,
  });

  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class _$ApiResponseModelCopyWithImpl<T, $Res, $Val extends ApiResponseModel<T>>
    implements $ApiResponseModelCopyWith<T, $Res> {
  _$ApiResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
    Object? meta = freezed,
    Object? errors = freezed,
    Object? timestamp = freezed,
    Object? requestId = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T?,
            meta: freezed == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as PaginationModel?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>?,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            requestId: freezed == requestId
                ? _value.requestId
                : requestId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $PaginationModelCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseModelImplCopyWith<T, $Res>
    implements $ApiResponseModelCopyWith<T, $Res> {
  factory _$$ApiResponseModelImplCopyWith(
    _$ApiResponseModelImpl<T> value,
    $Res Function(_$ApiResponseModelImpl<T>) then,
  ) = __$$ApiResponseModelImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    String message,
    T? data,
    PaginationModel? meta,
    Map<String, List<String>>? errors,
    DateTime? timestamp,
    String? requestId,
  });

  @override
  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$ApiResponseModelImplCopyWithImpl<T, $Res>
    extends _$ApiResponseModelCopyWithImpl<T, $Res, _$ApiResponseModelImpl<T>>
    implements _$$ApiResponseModelImplCopyWith<T, $Res> {
  __$$ApiResponseModelImplCopyWithImpl(
    _$ApiResponseModelImpl<T> _value,
    $Res Function(_$ApiResponseModelImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
    Object? meta = freezed,
    Object? errors = freezed,
    Object? timestamp = freezed,
    Object? requestId = freezed,
  }) {
    return _then(
      _$ApiResponseModelImpl<T>(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T?,
        meta: freezed == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as PaginationModel?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>?,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        requestId: freezed == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ApiResponseModelImpl<T> extends _ApiResponseModel<T> {
  const _$ApiResponseModelImpl({
    required this.message,
    required this.data,
    this.meta,
    final Map<String, List<String>>? errors,
    this.timestamp,
    this.requestId,
  }) : _errors = errors,
       super._();

  /// Response message from server
  @override
  final String message;

  /// Response data payload
  @override
  final T? data;

  /// Pagination metadata for list responses
  @override
  final PaginationModel? meta;

  /// Field-specific errors for validation failures
  final Map<String, List<String>>? _errors;

  /// Field-specific errors for validation failures
  @override
  Map<String, List<String>>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Response timestamp
  @override
  final DateTime? timestamp;

  /// Request ID for tracing
  @override
  final String? requestId;

  @override
  String toString() {
    return 'ApiResponseModel<$T>(message: $message, data: $data, meta: $meta, errors: $errors, timestamp: $timestamp, requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseModelImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(data),
    meta,
    const DeepCollectionEquality().hash(_errors),
    timestamp,
    requestId,
  );

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseModelImplCopyWith<T, _$ApiResponseModelImpl<T>> get copyWith =>
      __$$ApiResponseModelImplCopyWithImpl<T, _$ApiResponseModelImpl<T>>(
        this,
        _$identity,
      );
}

abstract class _ApiResponseModel<T> extends ApiResponseModel<T> {
  const factory _ApiResponseModel({
    required final String message,
    required final T? data,
    final PaginationModel? meta,
    final Map<String, List<String>>? errors,
    final DateTime? timestamp,
    final String? requestId,
  }) = _$ApiResponseModelImpl<T>;
  const _ApiResponseModel._() : super._();

  /// Response message from server
  @override
  String get message;

  /// Response data payload
  @override
  T? get data;

  /// Pagination metadata for list responses
  @override
  PaginationModel? get meta;

  /// Field-specific errors for validation failures
  @override
  Map<String, List<String>>? get errors;

  /// Response timestamp
  @override
  DateTime? get timestamp;

  /// Request ID for tracing
  @override
  String? get requestId;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseModelImplCopyWith<T, _$ApiResponseModelImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SuccessResponse<T> {
  String get message => throw _privateConstructorUsedError;
  T get data => throw _privateConstructorUsedError;
  PaginationModel? get meta => throw _privateConstructorUsedError;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SuccessResponseCopyWith<T, SuccessResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuccessResponseCopyWith<T, $Res> {
  factory $SuccessResponseCopyWith(
    SuccessResponse<T> value,
    $Res Function(SuccessResponse<T>) then,
  ) = _$SuccessResponseCopyWithImpl<T, $Res, SuccessResponse<T>>;
  @useResult
  $Res call({String message, T data, PaginationModel? meta});

  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class _$SuccessResponseCopyWithImpl<T, $Res, $Val extends SuccessResponse<T>>
    implements $SuccessResponseCopyWith<T, $Res> {
  _$SuccessResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
    Object? meta = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T,
            meta: freezed == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as PaginationModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $PaginationModelCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SuccessResponseImplCopyWith<T, $Res>
    implements $SuccessResponseCopyWith<T, $Res> {
  factory _$$SuccessResponseImplCopyWith(
    _$SuccessResponseImpl<T> value,
    $Res Function(_$SuccessResponseImpl<T>) then,
  ) = __$$SuccessResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String message, T data, PaginationModel? meta});

  @override
  $PaginationModelCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$SuccessResponseImplCopyWithImpl<T, $Res>
    extends _$SuccessResponseCopyWithImpl<T, $Res, _$SuccessResponseImpl<T>>
    implements _$$SuccessResponseImplCopyWith<T, $Res> {
  __$$SuccessResponseImplCopyWithImpl(
    _$SuccessResponseImpl<T> _value,
    $Res Function(_$SuccessResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
    Object? meta = freezed,
  }) {
    return _then(
      _$SuccessResponseImpl<T>(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T,
        meta: freezed == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as PaginationModel?,
      ),
    );
  }
}

/// @nodoc

class _$SuccessResponseImpl<T> implements _SuccessResponse<T> {
  const _$SuccessResponseImpl({
    required this.message,
    required this.data,
    this.meta,
  });

  @override
  final String message;
  @override
  final T data;
  @override
  final PaginationModel? meta;

  @override
  String toString() {
    return 'SuccessResponse<$T>(message: $message, data: $data, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessResponseImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(data),
    meta,
  );

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessResponseImplCopyWith<T, _$SuccessResponseImpl<T>> get copyWith =>
      __$$SuccessResponseImplCopyWithImpl<T, _$SuccessResponseImpl<T>>(
        this,
        _$identity,
      );
}

abstract class _SuccessResponse<T> implements SuccessResponse<T> {
  const factory _SuccessResponse({
    required final String message,
    required final T data,
    final PaginationModel? meta,
  }) = _$SuccessResponseImpl<T>;

  @override
  String get message;
  @override
  T get data;
  @override
  PaginationModel? get meta;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessResponseImplCopyWith<T, _$SuccessResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return _ErrorResponse.fromJson(json);
}

/// @nodoc
mixin _$ErrorResponse {
  String get message => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  Map<String, List<String>>? get errors => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;

  /// Serializes this ErrorResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorResponseCopyWith<ErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorResponseCopyWith<$Res> {
  factory $ErrorResponseCopyWith(
    ErrorResponse value,
    $Res Function(ErrorResponse) then,
  ) = _$ErrorResponseCopyWithImpl<$Res, ErrorResponse>;
  @useResult
  $Res call({
    String message,
    String? code,
    Map<String, List<String>>? errors,
    int? statusCode,
    String? path,
    DateTime? timestamp,
    String? requestId,
  });
}

/// @nodoc
class _$ErrorResponseCopyWithImpl<$Res, $Val extends ErrorResponse>
    implements $ErrorResponseCopyWith<$Res> {
  _$ErrorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? errors = freezed,
    Object? statusCode = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
    Object? requestId = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>?,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            path: freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            requestId: freezed == requestId
                ? _value.requestId
                : requestId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ErrorResponseImplCopyWith<$Res>
    implements $ErrorResponseCopyWith<$Res> {
  factory _$$ErrorResponseImplCopyWith(
    _$ErrorResponseImpl value,
    $Res Function(_$ErrorResponseImpl) then,
  ) = __$$ErrorResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    String? code,
    Map<String, List<String>>? errors,
    int? statusCode,
    String? path,
    DateTime? timestamp,
    String? requestId,
  });
}

/// @nodoc
class __$$ErrorResponseImplCopyWithImpl<$Res>
    extends _$ErrorResponseCopyWithImpl<$Res, _$ErrorResponseImpl>
    implements _$$ErrorResponseImplCopyWith<$Res> {
  __$$ErrorResponseImplCopyWithImpl(
    _$ErrorResponseImpl _value,
    $Res Function(_$ErrorResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? errors = freezed,
    Object? statusCode = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
    Object? requestId = freezed,
  }) {
    return _then(
      _$ErrorResponseImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        path: freezed == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        requestId: freezed == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorResponseImpl extends _ErrorResponse {
  const _$ErrorResponseImpl({
    required this.message,
    this.code,
    final Map<String, List<String>>? errors,
    this.statusCode,
    this.path,
    this.timestamp,
    this.requestId,
  }) : _errors = errors,
       super._();

  factory _$ErrorResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorResponseImplFromJson(json);

  @override
  final String message;
  @override
  final String? code;
  final Map<String, List<String>>? _errors;
  @override
  Map<String, List<String>>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? statusCode;
  @override
  final String? path;
  @override
  final DateTime? timestamp;
  @override
  final String? requestId;

  @override
  String toString() {
    return 'ErrorResponse(message: $message, code: $code, errors: $errors, statusCode: $statusCode, path: $path, timestamp: $timestamp, requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    code,
    const DeepCollectionEquality().hash(_errors),
    statusCode,
    path,
    timestamp,
    requestId,
  );

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      __$$ErrorResponseImplCopyWithImpl<_$ErrorResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorResponseImplToJson(this);
  }
}

abstract class _ErrorResponse extends ErrorResponse {
  const factory _ErrorResponse({
    required final String message,
    final String? code,
    final Map<String, List<String>>? errors,
    final int? statusCode,
    final String? path,
    final DateTime? timestamp,
    final String? requestId,
  }) = _$ErrorResponseImpl;
  const _ErrorResponse._() : super._();

  factory _ErrorResponse.fromJson(Map<String, dynamic> json) =
      _$ErrorResponseImpl.fromJson;

  @override
  String get message;
  @override
  String? get code;
  @override
  Map<String, List<String>>? get errors;
  @override
  int? get statusCode;
  @override
  String? get path;
  @override
  DateTime? get timestamp;
  @override
  String? get requestId;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaginatedResponse<T> {
  String get message => throw _privateConstructorUsedError;
  List<T> get data => throw _privateConstructorUsedError;
  PaginationModel get meta => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedResponseCopyWith<T, PaginatedResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedResponseCopyWith<T, $Res> {
  factory $PaginatedResponseCopyWith(
    PaginatedResponse<T> value,
    $Res Function(PaginatedResponse<T>) then,
  ) = _$PaginatedResponseCopyWithImpl<T, $Res, PaginatedResponse<T>>;
  @useResult
  $Res call({
    String message,
    List<T> data,
    PaginationModel meta,
    DateTime? timestamp,
    String? requestId,
  });

  $PaginationModelCopyWith<$Res> get meta;
}

/// @nodoc
class _$PaginatedResponseCopyWithImpl<
  T,
  $Res,
  $Val extends PaginatedResponse<T>
>
    implements $PaginatedResponseCopyWith<T, $Res> {
  _$PaginatedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = null,
    Object? meta = null,
    Object? timestamp = freezed,
    Object? requestId = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            meta: null == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as PaginationModel,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            requestId: freezed == requestId
                ? _value.requestId
                : requestId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res> get meta {
    return $PaginationModelCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaginatedResponseImplCopyWith<T, $Res>
    implements $PaginatedResponseCopyWith<T, $Res> {
  factory _$$PaginatedResponseImplCopyWith(
    _$PaginatedResponseImpl<T> value,
    $Res Function(_$PaginatedResponseImpl<T>) then,
  ) = __$$PaginatedResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    String message,
    List<T> data,
    PaginationModel meta,
    DateTime? timestamp,
    String? requestId,
  });

  @override
  $PaginationModelCopyWith<$Res> get meta;
}

/// @nodoc
class __$$PaginatedResponseImplCopyWithImpl<T, $Res>
    extends _$PaginatedResponseCopyWithImpl<T, $Res, _$PaginatedResponseImpl<T>>
    implements _$$PaginatedResponseImplCopyWith<T, $Res> {
  __$$PaginatedResponseImplCopyWithImpl(
    _$PaginatedResponseImpl<T> _value,
    $Res Function(_$PaginatedResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = null,
    Object? meta = null,
    Object? timestamp = freezed,
    Object? requestId = freezed,
  }) {
    return _then(
      _$PaginatedResponseImpl<T>(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        meta: null == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as PaginationModel,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        requestId: freezed == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PaginatedResponseImpl<T> extends _PaginatedResponse<T> {
  const _$PaginatedResponseImpl({
    required this.message,
    required final List<T> data,
    required this.meta,
    this.timestamp,
    this.requestId,
  }) : _data = data,
       super._();

  @override
  final String message;
  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationModel meta;
  @override
  final DateTime? timestamp;
  @override
  final String? requestId;

  @override
  String toString() {
    return 'PaginatedResponse<$T>(message: $message, data: $data, meta: $meta, timestamp: $timestamp, requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedResponseImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_data),
    meta,
    timestamp,
    requestId,
  );

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedResponseImplCopyWith<T, _$PaginatedResponseImpl<T>>
  get copyWith =>
      __$$PaginatedResponseImplCopyWithImpl<T, _$PaginatedResponseImpl<T>>(
        this,
        _$identity,
      );
}

abstract class _PaginatedResponse<T> extends PaginatedResponse<T> {
  const factory _PaginatedResponse({
    required final String message,
    required final List<T> data,
    required final PaginationModel meta,
    final DateTime? timestamp,
    final String? requestId,
  }) = _$PaginatedResponseImpl<T>;
  const _PaginatedResponse._() : super._();

  @override
  String get message;
  @override
  List<T> get data;
  @override
  PaginationModel get meta;
  @override
  DateTime? get timestamp;
  @override
  String? get requestId;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedResponseImplCopyWith<T, _$PaginatedResponseImpl<T>>
  get copyWith => throw _privateConstructorUsedError;
}

BatchResponse _$BatchResponseFromJson(Map<String, dynamic> json) {
  return _BatchResponse.fromJson(json);
}

/// @nodoc
mixin _$BatchResponse {
  String get message => throw _privateConstructorUsedError;
  int get successCount => throw _privateConstructorUsedError;
  int get failureCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  List<BatchItemResult>? get results => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this BatchResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BatchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchResponseCopyWith<BatchResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchResponseCopyWith<$Res> {
  factory $BatchResponseCopyWith(
    BatchResponse value,
    $Res Function(BatchResponse) then,
  ) = _$BatchResponseCopyWithImpl<$Res, BatchResponse>;
  @useResult
  $Res call({
    String message,
    int successCount,
    int failureCount,
    int totalCount,
    List<BatchItemResult>? results,
    DateTime? timestamp,
  });
}

/// @nodoc
class _$BatchResponseCopyWithImpl<$Res, $Val extends BatchResponse>
    implements $BatchResponseCopyWith<$Res> {
  _$BatchResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? successCount = null,
    Object? failureCount = null,
    Object? totalCount = null,
    Object? results = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            successCount: null == successCount
                ? _value.successCount
                : successCount // ignore: cast_nullable_to_non_nullable
                      as int,
            failureCount: null == failureCount
                ? _value.failureCount
                : failureCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            results: freezed == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<BatchItemResult>?,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BatchResponseImplCopyWith<$Res>
    implements $BatchResponseCopyWith<$Res> {
  factory _$$BatchResponseImplCopyWith(
    _$BatchResponseImpl value,
    $Res Function(_$BatchResponseImpl) then,
  ) = __$$BatchResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    int successCount,
    int failureCount,
    int totalCount,
    List<BatchItemResult>? results,
    DateTime? timestamp,
  });
}

/// @nodoc
class __$$BatchResponseImplCopyWithImpl<$Res>
    extends _$BatchResponseCopyWithImpl<$Res, _$BatchResponseImpl>
    implements _$$BatchResponseImplCopyWith<$Res> {
  __$$BatchResponseImplCopyWithImpl(
    _$BatchResponseImpl _value,
    $Res Function(_$BatchResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BatchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? successCount = null,
    Object? failureCount = null,
    Object? totalCount = null,
    Object? results = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$BatchResponseImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        successCount: null == successCount
            ? _value.successCount
            : successCount // ignore: cast_nullable_to_non_nullable
                  as int,
        failureCount: null == failureCount
            ? _value.failureCount
            : failureCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        results: freezed == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<BatchItemResult>?,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchResponseImpl extends _BatchResponse {
  const _$BatchResponseImpl({
    required this.message,
    required this.successCount,
    required this.failureCount,
    required this.totalCount,
    final List<BatchItemResult>? results,
    this.timestamp,
  }) : _results = results,
       super._();

  factory _$BatchResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BatchResponseImplFromJson(json);

  @override
  final String message;
  @override
  final int successCount;
  @override
  final int failureCount;
  @override
  final int totalCount;
  final List<BatchItemResult>? _results;
  @override
  List<BatchItemResult>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'BatchResponse(message: $message, successCount: $successCount, failureCount: $failureCount, totalCount: $totalCount, results: $results, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.successCount, successCount) ||
                other.successCount == successCount) &&
            (identical(other.failureCount, failureCount) ||
                other.failureCount == failureCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    successCount,
    failureCount,
    totalCount,
    const DeepCollectionEquality().hash(_results),
    timestamp,
  );

  /// Create a copy of BatchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchResponseImplCopyWith<_$BatchResponseImpl> get copyWith =>
      __$$BatchResponseImplCopyWithImpl<_$BatchResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchResponseImplToJson(this);
  }
}

abstract class _BatchResponse extends BatchResponse {
  const factory _BatchResponse({
    required final String message,
    required final int successCount,
    required final int failureCount,
    required final int totalCount,
    final List<BatchItemResult>? results,
    final DateTime? timestamp,
  }) = _$BatchResponseImpl;
  const _BatchResponse._() : super._();

  factory _BatchResponse.fromJson(Map<String, dynamic> json) =
      _$BatchResponseImpl.fromJson;

  @override
  String get message;
  @override
  int get successCount;
  @override
  int get failureCount;
  @override
  int get totalCount;
  @override
  List<BatchItemResult>? get results;
  @override
  DateTime? get timestamp;

  /// Create a copy of BatchResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchResponseImplCopyWith<_$BatchResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BatchItemResult _$BatchItemResultFromJson(Map<String, dynamic> json) {
  return _BatchItemResult.fromJson(json);
}

/// @nodoc
mixin _$BatchItemResult {
  int get index => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  /// Serializes this BatchItemResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BatchItemResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchItemResultCopyWith<BatchItemResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchItemResultCopyWith<$Res> {
  factory $BatchItemResultCopyWith(
    BatchItemResult value,
    $Res Function(BatchItemResult) then,
  ) = _$BatchItemResultCopyWithImpl<$Res, BatchItemResult>;
  @useResult
  $Res call({
    int index,
    bool success,
    String? id,
    String? error,
    Map<String, dynamic>? data,
  });
}

/// @nodoc
class _$BatchItemResultCopyWithImpl<$Res, $Val extends BatchItemResult>
    implements $BatchItemResultCopyWith<$Res> {
  _$BatchItemResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchItemResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? success = null,
    Object? id = freezed,
    Object? error = freezed,
    Object? data = freezed,
  }) {
    return _then(
      _value.copyWith(
            index: null == index
                ? _value.index
                : index // ignore: cast_nullable_to_non_nullable
                      as int,
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BatchItemResultImplCopyWith<$Res>
    implements $BatchItemResultCopyWith<$Res> {
  factory _$$BatchItemResultImplCopyWith(
    _$BatchItemResultImpl value,
    $Res Function(_$BatchItemResultImpl) then,
  ) = __$$BatchItemResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int index,
    bool success,
    String? id,
    String? error,
    Map<String, dynamic>? data,
  });
}

/// @nodoc
class __$$BatchItemResultImplCopyWithImpl<$Res>
    extends _$BatchItemResultCopyWithImpl<$Res, _$BatchItemResultImpl>
    implements _$$BatchItemResultImplCopyWith<$Res> {
  __$$BatchItemResultImplCopyWithImpl(
    _$BatchItemResultImpl _value,
    $Res Function(_$BatchItemResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BatchItemResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? success = null,
    Object? id = freezed,
    Object? error = freezed,
    Object? data = freezed,
  }) {
    return _then(
      _$BatchItemResultImpl(
        index: null == index
            ? _value.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int,
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: freezed == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchItemResultImpl implements _BatchItemResult {
  const _$BatchItemResultImpl({
    required this.index,
    required this.success,
    this.id,
    this.error,
    final Map<String, dynamic>? data,
  }) : _data = data;

  factory _$BatchItemResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BatchItemResultImplFromJson(json);

  @override
  final int index;
  @override
  final bool success;
  @override
  final String? id;
  @override
  final String? error;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BatchItemResult(index: $index, success: $success, id: $id, error: $error, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchItemResultImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    index,
    success,
    id,
    error,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of BatchItemResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchItemResultImplCopyWith<_$BatchItemResultImpl> get copyWith =>
      __$$BatchItemResultImplCopyWithImpl<_$BatchItemResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchItemResultImplToJson(this);
  }
}

abstract class _BatchItemResult implements BatchItemResult {
  const factory _BatchItemResult({
    required final int index,
    required final bool success,
    final String? id,
    final String? error,
    final Map<String, dynamic>? data,
  }) = _$BatchItemResultImpl;

  factory _BatchItemResult.fromJson(Map<String, dynamic> json) =
      _$BatchItemResultImpl.fromJson;

  @override
  int get index;
  @override
  bool get success;
  @override
  String? get id;
  @override
  String? get error;
  @override
  Map<String, dynamic>? get data;

  /// Create a copy of BatchItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchItemResultImplCopyWith<_$BatchItemResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) {
  return _FileUploadResponse.fromJson(json);
}

/// @nodoc
mixin _$FileUploadResponse {
  String get message => throw _privateConstructorUsedError;
  String get fileId => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get fileUrl => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime? get uploadedAt => throw _privateConstructorUsedError;

  /// Serializes this FileUploadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FileUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FileUploadResponseCopyWith<FileUploadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileUploadResponseCopyWith<$Res> {
  factory $FileUploadResponseCopyWith(
    FileUploadResponse value,
    $Res Function(FileUploadResponse) then,
  ) = _$FileUploadResponseCopyWithImpl<$Res, FileUploadResponse>;
  @useResult
  $Res call({
    String message,
    String fileId,
    String fileName,
    String fileUrl,
    int fileSize,
    String mimeType,
    Map<String, dynamic>? metadata,
    DateTime? uploadedAt,
  });
}

/// @nodoc
class _$FileUploadResponseCopyWithImpl<$Res, $Val extends FileUploadResponse>
    implements $FileUploadResponseCopyWith<$Res> {
  _$FileUploadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FileUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? fileId = null,
    Object? fileName = null,
    Object? fileUrl = null,
    Object? fileSize = null,
    Object? mimeType = null,
    Object? metadata = freezed,
    Object? uploadedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            fileId: null == fileId
                ? _value.fileId
                : fileId // ignore: cast_nullable_to_non_nullable
                      as String,
            fileName: null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String,
            fileUrl: null == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            fileSize: null == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as int,
            mimeType: null == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            uploadedAt: freezed == uploadedAt
                ? _value.uploadedAt
                : uploadedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FileUploadResponseImplCopyWith<$Res>
    implements $FileUploadResponseCopyWith<$Res> {
  factory _$$FileUploadResponseImplCopyWith(
    _$FileUploadResponseImpl value,
    $Res Function(_$FileUploadResponseImpl) then,
  ) = __$$FileUploadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    String fileId,
    String fileName,
    String fileUrl,
    int fileSize,
    String mimeType,
    Map<String, dynamic>? metadata,
    DateTime? uploadedAt,
  });
}

/// @nodoc
class __$$FileUploadResponseImplCopyWithImpl<$Res>
    extends _$FileUploadResponseCopyWithImpl<$Res, _$FileUploadResponseImpl>
    implements _$$FileUploadResponseImplCopyWith<$Res> {
  __$$FileUploadResponseImplCopyWithImpl(
    _$FileUploadResponseImpl _value,
    $Res Function(_$FileUploadResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FileUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? fileId = null,
    Object? fileName = null,
    Object? fileUrl = null,
    Object? fileSize = null,
    Object? mimeType = null,
    Object? metadata = freezed,
    Object? uploadedAt = freezed,
  }) {
    return _then(
      _$FileUploadResponseImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        fileId: null == fileId
            ? _value.fileId
            : fileId // ignore: cast_nullable_to_non_nullable
                  as String,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
        fileUrl: null == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        fileSize: null == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int,
        mimeType: null == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        uploadedAt: freezed == uploadedAt
            ? _value.uploadedAt
            : uploadedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FileUploadResponseImpl implements _FileUploadResponse {
  const _$FileUploadResponseImpl({
    required this.message,
    required this.fileId,
    required this.fileName,
    required this.fileUrl,
    required this.fileSize,
    required this.mimeType,
    final Map<String, dynamic>? metadata,
    this.uploadedAt,
  }) : _metadata = metadata;

  factory _$FileUploadResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FileUploadResponseImplFromJson(json);

  @override
  final String message;
  @override
  final String fileId;
  @override
  final String fileName;
  @override
  final String fileUrl;
  @override
  final int fileSize;
  @override
  final String mimeType;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? uploadedAt;

  @override
  String toString() {
    return 'FileUploadResponse(message: $message, fileId: $fileId, fileName: $fileName, fileUrl: $fileUrl, fileSize: $fileSize, mimeType: $mimeType, metadata: $metadata, uploadedAt: $uploadedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileUploadResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    fileId,
    fileName,
    fileUrl,
    fileSize,
    mimeType,
    const DeepCollectionEquality().hash(_metadata),
    uploadedAt,
  );

  /// Create a copy of FileUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileUploadResponseImplCopyWith<_$FileUploadResponseImpl> get copyWith =>
      __$$FileUploadResponseImplCopyWithImpl<_$FileUploadResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FileUploadResponseImplToJson(this);
  }
}

abstract class _FileUploadResponse implements FileUploadResponse {
  const factory _FileUploadResponse({
    required final String message,
    required final String fileId,
    required final String fileName,
    required final String fileUrl,
    required final int fileSize,
    required final String mimeType,
    final Map<String, dynamic>? metadata,
    final DateTime? uploadedAt,
  }) = _$FileUploadResponseImpl;

  factory _FileUploadResponse.fromJson(Map<String, dynamic> json) =
      _$FileUploadResponseImpl.fromJson;

  @override
  String get message;
  @override
  String get fileId;
  @override
  String get fileName;
  @override
  String get fileUrl;
  @override
  int get fileSize;
  @override
  String get mimeType;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime? get uploadedAt;

  /// Create a copy of FileUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileUploadResponseImplCopyWith<_$FileUploadResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return _TokenResponse.fromJson(json);
}

/// @nodoc
mixin _$TokenResponse {
  String get accessToken => throw _privateConstructorUsedError;
  String get tokenType => throw _privateConstructorUsedError;
  int get expiresIn => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  String? get scope => throw _privateConstructorUsedError;
  Map<String, dynamic>? get user => throw _privateConstructorUsedError;

  /// Serializes this TokenResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenResponseCopyWith<TokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenResponseCopyWith<$Res> {
  factory $TokenResponseCopyWith(
    TokenResponse value,
    $Res Function(TokenResponse) then,
  ) = _$TokenResponseCopyWithImpl<$Res, TokenResponse>;
  @useResult
  $Res call({
    String accessToken,
    String tokenType,
    int expiresIn,
    String? refreshToken,
    String? scope,
    Map<String, dynamic>? user,
  });
}

/// @nodoc
class _$TokenResponseCopyWithImpl<$Res, $Val extends TokenResponse>
    implements $TokenResponseCopyWith<$Res> {
  _$TokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? tokenType = null,
    Object? expiresIn = null,
    Object? refreshToken = freezed,
    Object? scope = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            tokenType: null == tokenType
                ? _value.tokenType
                : tokenType // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresIn: null == expiresIn
                ? _value.expiresIn
                : expiresIn // ignore: cast_nullable_to_non_nullable
                      as int,
            refreshToken: freezed == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            scope: freezed == scope
                ? _value.scope
                : scope // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenResponseImplCopyWith<$Res>
    implements $TokenResponseCopyWith<$Res> {
  factory _$$TokenResponseImplCopyWith(
    _$TokenResponseImpl value,
    $Res Function(_$TokenResponseImpl) then,
  ) = __$$TokenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accessToken,
    String tokenType,
    int expiresIn,
    String? refreshToken,
    String? scope,
    Map<String, dynamic>? user,
  });
}

/// @nodoc
class __$$TokenResponseImplCopyWithImpl<$Res>
    extends _$TokenResponseCopyWithImpl<$Res, _$TokenResponseImpl>
    implements _$$TokenResponseImplCopyWith<$Res> {
  __$$TokenResponseImplCopyWithImpl(
    _$TokenResponseImpl _value,
    $Res Function(_$TokenResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? tokenType = null,
    Object? expiresIn = null,
    Object? refreshToken = freezed,
    Object? scope = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _$TokenResponseImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenType: null == tokenType
            ? _value.tokenType
            : tokenType // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresIn: null == expiresIn
            ? _value.expiresIn
            : expiresIn // ignore: cast_nullable_to_non_nullable
                  as int,
        refreshToken: freezed == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        scope: freezed == scope
            ? _value.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: freezed == user
            ? _value._user
            : user // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenResponseImpl extends _TokenResponse {
  const _$TokenResponseImpl({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    this.refreshToken,
    this.scope,
    final Map<String, dynamic>? user,
  }) : _user = user,
       super._();

  factory _$TokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenResponseImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String tokenType;
  @override
  final int expiresIn;
  @override
  final String? refreshToken;
  @override
  final String? scope;
  final Map<String, dynamic>? _user;
  @override
  Map<String, dynamic>? get user {
    final value = _user;
    if (value == null) return null;
    if (_user is EqualUnmodifiableMapView) return _user;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TokenResponse(accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, refreshToken: $refreshToken, scope: $scope, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenResponseImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            const DeepCollectionEquality().equals(other._user, _user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accessToken,
    tokenType,
    expiresIn,
    refreshToken,
    scope,
    const DeepCollectionEquality().hash(_user),
  );

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      __$$TokenResponseImplCopyWithImpl<_$TokenResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenResponseImplToJson(this);
  }
}

abstract class _TokenResponse extends TokenResponse {
  const factory _TokenResponse({
    required final String accessToken,
    required final String tokenType,
    required final int expiresIn,
    final String? refreshToken,
    final String? scope,
    final Map<String, dynamic>? user,
  }) = _$TokenResponseImpl;
  const _TokenResponse._() : super._();

  factory _TokenResponse.fromJson(Map<String, dynamic> json) =
      _$TokenResponseImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get tokenType;
  @override
  int get expiresIn;
  @override
  String? get refreshToken;
  @override
  String? get scope;
  @override
  Map<String, dynamic>? get user;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
