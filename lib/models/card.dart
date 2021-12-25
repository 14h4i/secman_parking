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
      name: 'time_out',
      fromJson: _datetimeFromTimestamp,
      toJson: _datetimeToTimestamp)
  final DateTime? timeIn;

  @JsonKey(
      name: 'time_in',
      fromJson: _datetimeFromTimestamp,
      toJson: _datetimeToTimestamp)
  final DateTime? timeOut;

  @JsonKey(name: 'vehicle_number')
  final String? fullVehicleNumber;

  // @JsonKey(name: 'records', fromJson: _fromTimestamp, toJson: _toTimestamp)
  // final List<DateTime>? records;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'unit')
  final String? unit;

  @JsonKey(name: 'vehicle_type')
  final String? vehicleType;

  @JsonKey(name: 'vehicle_owner')
  final String? vehicleOwner;

  @JsonKey(name: 'doc_id')
  final String? docId;

  Card({
    this.id,
    this.currentPhoto,
    this.isGuest,
    this.timeIn,
    this.timeOut,
    this.fullVehicleNumber,
    this.phoneNumber,
    this.unit,
    this.vehicleType,
    this.vehicleOwner,
    this.docId,
  });

  String? get subVehicle => fullVehicleNumber?.split('-')[0];

  String? get vehicleNumber => fullVehicleNumber?.split('-')[1];

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);

  static DateTime? _datetimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _datetimeToTimestamp(DateTime? time) =>
      time != null ? Timestamp.fromDate(time) : null;

  // static List<DateTime>? _fromTimestamp(List<dynamic>? list) =>
  //     list?.map((e) => (e as Timestamp).toDate()).toList();

  // static List<Timestamp>? _toTimestamp(List<DateTime>? list) =>
  //     list?.map((e) => Timestamp.fromDate(e)).toList();

  Card? copyWith({
    String? id,
    String? currentPhoto,
    bool? isGuest,
    DateTime? timeIn,
    DateTime? timeOut,
    String? fullVehicleNumber,
    String? phoneNumber,
    String? unit,
    String? vehicleType,
    String? vehicleOwner,
    String? docId,
  }) {
    return Card(
      id: id ?? this.id,
      currentPhoto: currentPhoto ?? this.currentPhoto,
      isGuest: isGuest ?? this.isGuest,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
      fullVehicleNumber: fullVehicleNumber ?? this.fullVehicleNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      unit: unit ?? this.unit,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleOwner: vehicleOwner ?? this.vehicleOwner,
      docId: docId ?? this.docId,
    );
  }
}
