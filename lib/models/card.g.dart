// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      id: json['id'] as String?,
      currentPhoto: json['current_photo'] as String?,
      isGuest: json['is_guest'] as bool?,
      previousTime:
          Card._datetimeFromTimestamp(json['previous_time'] as Timestamp?),
      currentTime:
          Card._datetimeFromTimestamp(json['current_time'] as Timestamp?),
      vehicleNumber: json['vehicle_number'] as String?,
      subVehicle: json['sub_vehicle'] as String?,
      records: Card._fromTimestamp(json['records'] as List?),
      phoneNumber: json['phone_number'] as String?,
      unit: json['unit'] as String?,
      vehicleType: json['vehicle_type'] as String?,
      vehicleOwner: json['vehicle_owner'] as String?,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'current_photo': instance.currentPhoto,
      'is_guest': instance.isGuest,
      'previous_time': Card._datetimeToTimestamp(instance.previousTime),
      'current_time': Card._datetimeToTimestamp(instance.currentTime),
      'vehicle_number': instance.vehicleNumber,
      'sub_vehicle': instance.subVehicle,
      'records': Card._toTimestamp(instance.records),
      'phone_number': instance.phoneNumber,
      'unit': instance.unit,
      'vehicle_type': instance.vehicleType,
      'vehicle_owner': instance.vehicleOwner,
    };
