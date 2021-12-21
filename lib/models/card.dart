import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class Card {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'current_photo')
  final String? currentPhoto;

  @JsonKey(name: 'is_guest')
  final bool? isGuest;

  @JsonKey(
      name: 'previous_time',
      fromJson: _datetimeFromTimestamp,
      toJson: _datetimeToTimestamp)
  final DateTime? previousTime;

  @JsonKey(
      name: 'current_time',
      fromJson: _datetimeFromTimestamp,
      toJson: _datetimeToTimestamp)
  final DateTime? currentTime;

  @JsonKey(name: 'vehicle_number')
  final String? vehicleNumber;

  @JsonKey(name: 'sub_vehicle')
  final String? subVehicle;

  @JsonKey(name: 'records', fromJson: _fromTimestamp, toJson: _toTimestamp)
  final List<DateTime>? records;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'unit')
  final String? unit;

  @JsonKey(name: 'vehicle_type')
  final String? vehicleType;

  @JsonKey(name: 'vehicle_owner')
  final String? vehicleOwner;

  Card({
    this.id,
    this.currentPhoto,
    this.isGuest,
    this.previousTime,
    this.currentTime,
    this.vehicleNumber,
    this.subVehicle,
    this.records,
    this.phoneNumber,
    this.unit,
    this.vehicleType,
    this.vehicleOwner,
  });

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);

  static DateTime? _datetimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _datetimeToTimestamp(DateTime? time) =>
      time != null ? Timestamp.fromDate(time) : null;

  static List<DateTime>? _fromTimestamp(List<dynamic>? list) =>
      list?.map((e) => (e as Timestamp).toDate()).toList();

  static List<Timestamp>? _toTimestamp(List<DateTime>? list) =>
      list?.map((e) => Timestamp.fromDate(e)).toList();

  Card? copyWith({
    String? id,
    String? currentPhoto,
    bool? isGuest,
    DateTime? previousTime,
    DateTime? currentTime,
    String? vehicleNumber,
    String? subVehicle,
    String? phoneNumber,
    String? unit,
    String? vehicleType,
    String? vehicleOwner,
  }) {
    return Card(
      id: id ?? this.id,
      currentPhoto: currentPhoto ?? this.currentPhoto,
      isGuest: isGuest ?? this.isGuest,
      currentTime: currentTime ?? this.currentTime,
      previousTime: previousTime ?? this.previousTime,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      subVehicle: subVehicle ?? this.subVehicle,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      unit: unit ?? this.unit,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleOwner: vehicleOwner ?? this.vehicleOwner,
    );
  }
}
