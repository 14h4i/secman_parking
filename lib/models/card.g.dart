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
      'previous_time': Card._datetimeToTimestamp(instance.previousTime),
      'current_time': Card._datetimeToTimestamp(instance.currentTime),
      'vehicle_number': instance.fullVehicleNumber,
      'phone_number': instance.phoneNumber,
      'unit': instance.unit,
      'vehicle_type': instance.vehicleType,
      'vehicle_owner': instance.vehicleOwner,
      'doc_id': instance.docId,
    };
