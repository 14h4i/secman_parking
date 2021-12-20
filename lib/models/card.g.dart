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
      gotInto: json['got_into'] as bool?,
      phoneNumber: json['phone_number'] as String?,
      unit: json['unit'] as String?,
      vehicleType: json['vehicle_type'] as String?,
      vehicleOwner: json['vehicle_owner'] as String?,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'current_photo': instance.currentPhoto,
      'is_guest': instance.isGuest,
      'time_in': Card._datetimeToTimestamp(instance.timeIn),
      'time_out': Card._datetimeToTimestamp(instance.timeOut),
      'vehicle_number': instance.vehicleNumber,
      'records': Card._jsonToMap(instance.records),
      'got_into': instance.gotInto,
      'phone_number': instance.phoneNumber,
      'unit': instance.unit,
      'vehicle_type': instance.vehicleType,
      'vehicle_owner': instance.vehicleOwner,
    };
