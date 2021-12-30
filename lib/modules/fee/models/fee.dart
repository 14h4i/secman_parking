import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fee.g.dart';

enum FeeType { day, night }

@JsonSerializable()
class Fee {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'fee')
  final int? fee;

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

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'type', fromJson: _typeFromString, toJson: _typeToString)
  final FeeType? type;

  @JsonKey(name: 'collected')
  final bool? collected;

  @JsonKey(name: 'doc_id')
  final String? docId;

  Fee({
    this.id,
    this.photo,
    this.fee,
    this.timeIn,
    this.timeOut,
    this.type,
    this.collected,
    this.docId,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);

  Map<String, dynamic> toJson() => _$FeeToJson(this);

  static DateTime? _datetimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _datetimeToTimestamp(DateTime? time) =>
      time != null ? Timestamp.fromDate(time) : null;

  static FeeType? _typeFromString(String? string) => string != null
      ? string == 'night'
          ? FeeType.night
          : FeeType.day
      : null;

  static String? _typeToString(FeeType? type) => type != null
      ? type == FeeType.night
          ? 'night'
          : 'day'
      : null;

  Fee? copyWith({
    String? id,
    String? photo,
    int? fee,
    DateTime? timeIn,
    DateTime? timeOut,
    FeeType? type,
    bool? collected,
    String? docId,
  }) {
    return Fee(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      fee: fee ?? this.fee,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
      type: type ?? this.type,
      collected: collected ?? this.collected,
      docId: docId ?? this.docId,
    );
  }
}
