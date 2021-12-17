import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:secman_parking/utils/date_time_intl.dart';

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
      name: 'time_in',
      fromJson: _datetimeFromTimestamp,
      toJson: _datetimeToTimestamp)
  final DateTime? timeIn;

  @JsonKey(
      name: 'time_out',
      fromJson: _datetimeFromTimestamp,
      toJson: _datetimeToTimestamp)
  final DateTime? timeOut;

  @JsonKey(name: 'vehicle_number')
  final String? vehicleNumber;

  @JsonKey(name: 'records', fromJson: _mapFromJson, toJson: _jsonToMap)
  final Map<DateTime, String>? records;

  Card({
    this.id,
    this.currentPhoto,
    this.isGuest,
    this.timeIn,
    this.timeOut,
    this.vehicleNumber,
    this.records,
  });

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);

  static DateTime? _datetimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _datetimeToTimestamp(DateTime? time) =>
      time != null ? Timestamp.fromDate(time) : null;

  static Map<DateTime, String>? _mapFromJson(Map<String, dynamic>? map) =>
      map?.map(
          (key, value) => MapEntry(DateTimeIntl.stringToDateTime(key), value));

  static Map<String, dynamic>? _jsonToMap(Map<DateTime, String>? map) =>
      map?.map(
          (key, value) => MapEntry(DateTimeIntl.dateTimeToString(key), value));

  Card? copyWith({
    String? id,
    String? currentPhoto,
    bool? isGuest,
    DateTime? timeIn,
    DateTime? timeOut,
    String? vehicleNumber,
  }) {
    return Card(
      id: id ?? this.id,
      currentPhoto: currentPhoto ?? this.currentPhoto,
      isGuest: isGuest ?? this.isGuest,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
    );
  }
}
