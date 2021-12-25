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
      fullVehicleNumber: json['vehicle_number'] as String?,
      phoneNumber: json['phone_number'] as String?,
      unit: json['unit'] as String?,
      vehicleType: json['vehicle_type'] as String?,
      vehicleOwner: json['vehicle_owner'] as String?,
      docId: json['doc_id'] as String?,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'id': instance.id,
      'current_photo': instance.currentPhoto,
      'is_guest': instance.isGuest,
      'time_in': Card._datetimeToTimestamp(instance.timeIn),
      'time_out': Card._datetimeToTimestamp(instance.timeOut),
      'vehicle_number': instance.fullVehicleNumber,
      'phone_number': instance.phoneNumber,
      'unit': instance.unit,
      'vehicle_type': instance.vehicleType,
      'vehicle_owner': instance.vehicleOwner,
      'doc_id': instance.docId,
    };
