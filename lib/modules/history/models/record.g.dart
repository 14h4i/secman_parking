// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      status: json['status'] as String?,
      photo: json['photo'] as String?,
      time: Record._datetimeFromTimestamp(json['time'] as Timestamp?),
      docId: json['doc_id'] as String?,
    );

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'photo': instance.photo,
      'status': instance.status,
      'time': Record._datetimeToTimestamp(instance.time),
      'doc_id': instance.docId,
    };
