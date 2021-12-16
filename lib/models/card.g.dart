// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      json['id'] as String?,
      json['current_photo'] as String?,
      json['is_guest'] as bool?,
      Card._fromJson(json['time_in'] as Timestamp?),
      Card._fromJson(json['time_out'] as Timestamp?),
      json['vehicle_number'] as String?,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'current_photo': instance.currentPhoto,
      'is_guest': instance.isGuest,
      'time_in': Card._toJson(instance.timeIn),
      'time_out': Card._toJson(instance.timeOut),
      'vehicle_number': instance.vehicleNumber,
    };
