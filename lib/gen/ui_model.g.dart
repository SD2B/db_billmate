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
    };
