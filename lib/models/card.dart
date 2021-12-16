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

  @JsonKey(name: 'time_in')
  final DateTime? timeIn;

  @JsonKey(name: 'time_out')
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
}
