// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) {
  return _ErrorModel.fromJson(json);
}

/// @nodoc
mixin _$ErrorModel {
  /// Error message
  String get message => throw _privateConstructorUsedError;

  /// Error code for categorization
  String? get code => throw _privateConstructorUsedError;

  /// HTTP status code if from API
  int? get statusCode => throw _privateConstructorUsedError;

  /// Field-specific validation errors
  Map<String, List<String>>? get fieldErrors =>
      throw _privateConstructorUsedError;

  /// Stack trace for debugging (not serialized)
  @JsonKey(includeFromJson: false, includeToJson: false)
  StackTrace? get stackTrace => throw _privateConstructorUsedError;

  /// Additional error details
  Map<String, dynamic>? get details => throw _privateConstructorUsedError;

  /// Error timestamp
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Request path that caused the error
  String? get path => throw _privateConstructorUsedError;

  /// Request ID for tracing
  String? get requestId => throw _privateConstructorUsedError;

  /// Serializes this ErrorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorModelCopyWith<ErrorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorModelCopyWith<$Res> {
  factory $ErrorModelCopyWith(
    ErrorModel value,
    $Res Function(ErrorModel) then,
  ) = _$ErrorModelCopyWithImpl<$Res, ErrorModel>;
  @useResult
  $Res call({
    String message,
    String? code,
    int? statusCode,
    Map<String, List<String>>? fieldErrors,
    @JsonKey(includeFromJson: false, includeToJson: false)
    StackTrace? stackTrace,
    Map<String, dynamic>? details,
    DateTime? timestamp,
    String? path,
    String? requestId,
  });
}

/// @nodoc
class _$ErrorModelCopyWithImpl<$Res, $Val extends ErrorModel>
    implements $ErrorModelCopyWith<$Res> {
  _$ErrorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? statusCode = freezed,
    Object? fieldErrors = freezed,
    Object? stackTrace = freezed,
    Object? details = freezed,
    Object? timestamp = freezed,
    Object? path = freezed,
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
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as int?,
            fieldErrors: freezed == fieldErrors
                ? _value.fieldErrors
                : fieldErrors // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>?,
            stackTrace: freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                      as StackTrace?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            path: freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$ErrorModelImplCopyWith<$Res>
    implements $ErrorModelCopyWith<$Res> {
  factory _$$ErrorModelImplCopyWith(
    _$ErrorModelImpl value,
    $Res Function(_$ErrorModelImpl) then,
  ) = __$$ErrorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    String? code,
    int? statusCode,
    Map<String, List<String>>? fieldErrors,
    @JsonKey(includeFromJson: false, includeToJson: false)
    StackTrace? stackTrace,
    Map<String, dynamic>? details,
    DateTime? timestamp,
    String? path,
    String? requestId,
  });
}

/// @nodoc
class __$$ErrorModelImplCopyWithImpl<$Res>
    extends _$ErrorModelCopyWithImpl<$Res, _$ErrorModelImpl>
    implements _$$ErrorModelImplCopyWith<$Res> {
  __$$ErrorModelImplCopyWithImpl(
    _$ErrorModelImpl _value,
    $Res Function(_$ErrorModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? statusCode = freezed,
    Object? fieldErrors = freezed,
    Object? stackTrace = freezed,
    Object? details = freezed,
    Object? timestamp = freezed,
    Object? path = freezed,
    Object? requestId = freezed,
  }) {
    return _then(
      _$ErrorModelImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        fieldErrors: freezed == fieldErrors
            ? _value._fieldErrors
            : fieldErrors // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>?,
        stackTrace: freezed == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
        details: freezed == details
            ? _value._details
            : details // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        path: freezed == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$ErrorModelImpl extends _ErrorModel {
  const _$ErrorModelImpl({
    required this.message,
    this.code,
    this.statusCode,
    final Map<String, List<String>>? fieldErrors,
    @JsonKey(includeFromJson: false, includeToJson: false) this.stackTrace,
    final Map<String, dynamic>? details,
    this.timestamp,
    this.path,
    this.requestId,
  }) : _fieldErrors = fieldErrors,
       _details = details,
       super._();

  factory _$ErrorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorModelImplFromJson(json);

  /// Error message
  @override
  final String message;

  /// Error code for categorization
  @override
  final String? code;

  /// HTTP status code if from API
  @override
  final int? statusCode;

  /// Field-specific validation errors
  final Map<String, List<String>>? _fieldErrors;

  /// Field-specific validation errors
  @override
  Map<String, List<String>>? get fieldErrors {
    final value = _fieldErrors;
    if (value == null) return null;
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Stack trace for debugging (not serialized)
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StackTrace? stackTrace;

  /// Additional error details
  final Map<String, dynamic>? _details;

  /// Additional error details
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Error timestamp
  @override
  final DateTime? timestamp;

  /// Request path that caused the error
  @override
  final String? path;

  /// Request ID for tracing
  @override
  final String? requestId;

  @override
  String toString() {
    return 'ErrorModel(message: $message, code: $code, statusCode: $statusCode, fieldErrors: $fieldErrors, stackTrace: $stackTrace, details: $details, timestamp: $timestamp, path: $path, requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorModelImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality().equals(
              other._fieldErrors,
              _fieldErrors,
            ) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    code,
    statusCode,
    const DeepCollectionEquality().hash(_fieldErrors),
    stackTrace,
    const DeepCollectionEquality().hash(_details),
    timestamp,
    path,
    requestId,
  );

  /// Create a copy of ErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorModelImplCopyWith<_$ErrorModelImpl> get copyWith =>
      __$$ErrorModelImplCopyWithImpl<_$ErrorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorModelImplToJson(this);
  }
}

abstract class _ErrorModel extends ErrorModel {
  const factory _ErrorModel({
    required final String message,
    final String? code,
    final int? statusCode,
    final Map<String, List<String>>? fieldErrors,
    @JsonKey(includeFromJson: false, includeToJson: false)
    final StackTrace? stackTrace,
    final Map<String, dynamic>? details,
    final DateTime? timestamp,
    final String? path,
    final String? requestId,
  }) = _$ErrorModelImpl;
  const _ErrorModel._() : super._();

  factory _ErrorModel.fromJson(Map<String, dynamic> json) =
      _$ErrorModelImpl.fromJson;

  /// Error message
  @override
  String get message;

  /// Error code for categorization
  @override
  String? get code;

  /// HTTP status code if from API
  @override
  int? get statusCode;

  /// Field-specific validation errors
  @override
  Map<String, List<String>>? get fieldErrors;

  /// Stack trace for debugging (not serialized)
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  StackTrace? get stackTrace;

  /// Additional error details
  @override
  Map<String, dynamic>? get details;

  /// Error timestamp
  @override
  DateTime? get timestamp;

  /// Request path that caused the error
  @override
  String? get path;

  /// Request ID for tracing
  @override
  String? get requestId;

  /// Create a copy of ErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorModelImplCopyWith<_$ErrorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeverityErrorModel _$SeverityErrorModelFromJson(Map<String, dynamic> json) {
  return _SeverityErrorModel.fromJson(json);
}

/// @nodoc
mixin _$SeverityErrorModel {
  ErrorModel get error => throw _privateConstructorUsedError;
  ErrorSeverity get severity => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  Map<String, dynamic>? get context => throw _privateConstructorUsedError;

  /// Serializes this SeverityErrorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeverityErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeverityErrorModelCopyWith<SeverityErrorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeverityErrorModelCopyWith<$Res> {
  factory $SeverityErrorModelCopyWith(
    SeverityErrorModel value,
    $Res Function(SeverityErrorModel) then,
  ) = _$SeverityErrorModelCopyWithImpl<$Res, SeverityErrorModel>;
  @useResult
  $Res call({
    ErrorModel error,
    ErrorSeverity severity,
    String? category,
    Map<String, dynamic>? context,
  });

  $ErrorModelCopyWith<$Res> get error;
}

/// @nodoc
class _$SeverityErrorModelCopyWithImpl<$Res, $Val extends SeverityErrorModel>
    implements $SeverityErrorModelCopyWith<$Res> {
  _$SeverityErrorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeverityErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? severity = null,
    Object? category = freezed,
    Object? context = freezed,
  }) {
    return _then(
      _value.copyWith(
            error: null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as ErrorModel,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as ErrorSeverity,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            context: freezed == context
                ? _value.context
                : context // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of SeverityErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ErrorModelCopyWith<$Res> get error {
    return $ErrorModelCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SeverityErrorModelImplCopyWith<$Res>
    implements $SeverityErrorModelCopyWith<$Res> {
  factory _$$SeverityErrorModelImplCopyWith(
    _$SeverityErrorModelImpl value,
    $Res Function(_$SeverityErrorModelImpl) then,
  ) = __$$SeverityErrorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ErrorModel error,
    ErrorSeverity severity,
    String? category,
    Map<String, dynamic>? context,
  });

  @override
  $ErrorModelCopyWith<$Res> get error;
}

/// @nodoc
class __$$SeverityErrorModelImplCopyWithImpl<$Res>
    extends _$SeverityErrorModelCopyWithImpl<$Res, _$SeverityErrorModelImpl>
    implements _$$SeverityErrorModelImplCopyWith<$Res> {
  __$$SeverityErrorModelImplCopyWithImpl(
    _$SeverityErrorModelImpl _value,
    $Res Function(_$SeverityErrorModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeverityErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? severity = null,
    Object? category = freezed,
    Object? context = freezed,
  }) {
    return _then(
      _$SeverityErrorModelImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as ErrorModel,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as ErrorSeverity,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        context: freezed == context
            ? _value._context
            : context // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeverityErrorModelImpl extends _SeverityErrorModel {
  const _$SeverityErrorModelImpl({
    required this.error,
    required this.severity,
    this.category,
    final Map<String, dynamic>? context,
  }) : _context = context,
       super._();

  factory _$SeverityErrorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeverityErrorModelImplFromJson(json);

  @override
  final ErrorModel error;
  @override
  final ErrorSeverity severity;
  @override
  final String? category;
  final Map<String, dynamic>? _context;
  @override
  Map<String, dynamic>? get context {
    final value = _context;
    if (value == null) return null;
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SeverityErrorModel(error: $error, severity: $severity, category: $category, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeverityErrorModelImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._context, _context));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    error,
    severity,
    category,
    const DeepCollectionEquality().hash(_context),
  );

  /// Create a copy of SeverityErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeverityErrorModelImplCopyWith<_$SeverityErrorModelImpl> get copyWith =>
      __$$SeverityErrorModelImplCopyWithImpl<_$SeverityErrorModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeverityErrorModelImplToJson(this);
  }
}

abstract class _SeverityErrorModel extends SeverityErrorModel {
  const factory _SeverityErrorModel({
    required final ErrorModel error,
    required final ErrorSeverity severity,
    final String? category,
    final Map<String, dynamic>? context,
  }) = _$SeverityErrorModelImpl;
  const _SeverityErrorModel._() : super._();

  factory _SeverityErrorModel.fromJson(Map<String, dynamic> json) =
      _$SeverityErrorModelImpl.fromJson;

  @override
  ErrorModel get error;
  @override
  ErrorSeverity get severity;
  @override
  String? get category;
  @override
  Map<String, dynamic>? get context;

  /// Create a copy of SeverityErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeverityErrorModelImplCopyWith<_$SeverityErrorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
