// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      id: json['id'] as String?,
      currentPhoto: json['current_photo'] as String?,
      isGuest: json['is_guest'] as bool?,
      timeIn: Card._datetimeFromTimestamp(json['time_in'] as Timestamp?),
      timeOut: Card._datetimeFromTimestamp(json['time_out'] as Timestamp?),
      vehicleNumber: json['vehicle_number'] as String?,
      records: Card._mapFromJson(json['records'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'current_photo': instance.currentPhoto,
      'is_guest': instance.isGuest,
      'time_in': Card._datetimeToTimestamp(instance.timeIn),
      'time_out': Card._datetimeToTimestamp(instance.timeOut),
      'vehicle_number': instance.vehicleNumber,
      'records': Card._jsonToMap(instance.records),
    };
