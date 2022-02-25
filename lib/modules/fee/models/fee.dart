import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fee.g.dart';

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

  @JsonKey(name: 'range')
  final int? range;

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
    this.range,
    this.collected,
    this.docId,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);

  Map<String, dynamic> toJson() => _$FeeToJson(this);

  static DateTime? _datetimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _datetimeToTimestamp(DateTime? time) =>
      time != null ? Timestamp.fromDate(time) : null;

  Fee? copyWith({
    String? id,
    String? photo,
    int? fee,
    DateTime? timeIn,
    DateTime? timeOut,
    int? range,
    bool? collected,
    String? docId,
  }) {
    return Fee(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      fee: fee ?? this.fee,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
      range: range ?? this.range,
      collected: collected ?? this.collected,
      docId: docId ?? this.docId,
    );
  }
}
