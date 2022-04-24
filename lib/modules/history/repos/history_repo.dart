import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/history/models/record.dart';

class HistoryRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Card>?> getHistories() async {
    try {
      final snapshot = await _firestore.collection('cards').get();

      final data = snapshot.docs;
      return data.map((e) {
        var tmp = e.data();
        tmp['doc_id'] = e.id;
        return Card.fromJson(tmp);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Record>> getDetailHistory(String docId, DateTime time) async {
    try {
      DateTime start = DateTime(time.day, time.month, time.day);
      DateTime end = DateTime(time.day, time.month, time.day, 23, 59);
      final snapshot = await _firestore
          .collection('cards')
          .doc(docId)
          .collection('records')
          .where(
            'time',
            isGreaterThanOrEqualTo: Timestamp.fromDate(start),
            isLessThanOrEqualTo: Timestamp.fromDate(end),
          )
          .get();

      final data = snapshot.docs;
      if (data.isNotEmpty) {
        return data.map((e) {
          var map = e.data();
          map['doc_id'] = e.id;
          return Record.fromJson(map);
        }).toList();
      } else {
        List<Record> empty = [];
        return empty;
      }
    } catch (e) {
      rethrow;
    }
  }
}
