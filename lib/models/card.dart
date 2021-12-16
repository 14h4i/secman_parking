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

  @JsonKey(name: 'time_in', fromJson: _fromJson, toJson: _toJson)
  final DateTime? timeIn;

  @JsonKey(name: 'time_out', fromJson: _fromJson, toJson: _toJson)
  final DateTime? timeOut;

  @JsonKey(name: 'vehicle_number')
  final String? vehicleNumber;

  Card(
    this.id,
    this.currentPhoto,
    this.isGuest,
    this.timeIn,
    this.timeOut,
    this.vehicleNumber,
  );

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);

  static DateTime? _fromJson(Timestamp? timestamp) => timestamp?.toDate();

  static Timestamp? _toJson(DateTime? time) =>
      time != null ? Timestamp.fromDate(time) : null;
}
