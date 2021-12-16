// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      json['id'] as String?,
      json['current_photo'] as String?,
      json['is_guest'] as bool?,
      json['time_in'] == null
          ? null
          : DateTime.parse(json['time_in'] as String),
      json['time_out'] == null
          ? null
          : DateTime.parse(json['time_out'] as String),
      json['vehicle_number'] as String?,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'current_photo': instance.currentPhoto,
      'is_guest': instance.isGuest,
      'time_in': instance.timeIn?.toIso8601String(),
      'time_out': instance.timeOut?.toIso8601String(),
      'vehicle_number': instance.vehicleNumber,
    };
