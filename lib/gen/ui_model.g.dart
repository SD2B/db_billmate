// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UiModelImpl _$$UiModelImplFromJson(Map<String, dynamic> json) =>
    _$UiModelImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      description: json['description'] as String?,
      value: json['value'] as String?,
      count: json['count'] as String?,
      svg: json['svg'] as String?,
      valueList: (json['valueList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      labelList: (json['labelList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      onTap: const FunctionConverter().fromJson(json['onTap'] as String?),
    );

Map<String, dynamic> _$$UiModelImplToJson(_$UiModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'description': instance.description,
      'value': instance.value,
      'count': instance.count,
      'svg': instance.svg,
      'valueList': instance.valueList,
      'labelList': instance.labelList,
      'onTap': const FunctionConverter().toJson(instance.onTap),
    };

_$ResponseModelImpl _$$ResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$ResponseModelImpl(
      id: (json['id'] as num?)?.toInt(),
      isSuccess: json['isSuccess'] as bool? ?? false,
      statusCode: json['statusCode'] as String?,
      data: json['data'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ResponseModelImplToJson(_$ResponseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isSuccess': instance.isSuccess,
      'statusCode': instance.statusCode,
      'data': instance.data,
      'message': instance.message,
    };
