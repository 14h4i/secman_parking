import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(
      name: 'time',
      fromJson: _datetimeFromTimestamp,
      toJson: _datetimeToTimestamp)
  final DateTime? time;

  @JsonKey(name: 'doc_id')
  final String? docId;

  Record({
    this.status,
    this.photo,
    this.time,
    this.docId,
  });

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);

  static DateTime? _datetimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _datetimeToTimestamp(DateTime? time) =>
      time != null ? Timestamp.fromDate(time) : null;
}
