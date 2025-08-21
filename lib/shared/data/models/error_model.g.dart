// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorModelImpl _$$ErrorModelImplFromJson(Map<String, dynamic> json) =>
    _$ErrorModelImpl(
      message: json['message'] as String,
      code: json['code'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      fieldErrors: (json['fieldErrors'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      details: json['details'] as Map<String, dynamic>?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      path: json['path'] as String?,
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$$ErrorModelImplToJson(_$ErrorModelImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'statusCode': instance.statusCode,
      'fieldErrors': instance.fieldErrors,
      'details': instance.details,
      'timestamp': instance.timestamp?.toIso8601String(),
      'path': instance.path,
      'requestId': instance.requestId,
    };

_$SeverityErrorModelImpl _$$SeverityErrorModelImplFromJson(
  Map<String, dynamic> json,
) => _$SeverityErrorModelImpl(
  error: ErrorModel.fromJson(json['error'] as Map<String, dynamic>),
  severity: $enumDecode(_$ErrorSeverityEnumMap, json['severity']),
  category: json['category'] as String?,
  context: json['context'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$SeverityErrorModelImplToJson(
  _$SeverityErrorModelImpl instance,
) => <String, dynamic>{
  'error': instance.error,
  'severity': _$ErrorSeverityEnumMap[instance.severity]!,
  'category': instance.category,
  'context': instance.context,
};

const _$ErrorSeverityEnumMap = {
  ErrorSeverity.low: 'low',
  ErrorSeverity.medium: 'medium',
  ErrorSeverity.high: 'high',
  ErrorSeverity.critical: 'critical',
};
