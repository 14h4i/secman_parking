// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fee _$FeeFromJson(Map<String, dynamic> json) => Fee(
      id: json['id'] as String?,
      photo: json['photo'] as String?,
      fee: json['fee'] as int?,
      timeIn: Fee._datetimeFromTimestamp(json['time_in'] as Timestamp?),
      timeOut: Fee._datetimeFromTimestamp(json['time_out'] as Timestamp?),
      range: json['range'] as int?,
      collected: json['collected'] as bool?,
      docId: json['doc_id'] as String?,
    );

Map<String, dynamic> _$FeeToJson(Fee instance) => <String, dynamic>{
      'id': instance.id,
      'fee': instance.fee,
      'time_in': Fee._datetimeToTimestamp(instance.timeIn),
      'time_out': Fee._datetimeToTimestamp(instance.timeOut),
      'photo': instance.photo,
      'range': instance.range,
      'collected': instance.collected,
      'doc_id': instance.docId,
    };
