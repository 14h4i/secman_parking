import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/utils/date_time_intl.dart';

class InternalRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Card?> scan(String id) async {
    try {
      final snapshot = await _firestore
          .collection('cards')
          .where('id', isEqualTo: id)
          .limit(1)
          .get();
      if (snapshot.docs.isEmpty) {
        return null;
      }

      Map<String, dynamic> data = snapshot.docs.first.data();

      final tempCard = Card.fromJson(data);

      final now = Timestamp.now();

      Map<String, dynamic> records = data['records'];

      Map<String, Object?> dataUpdate;
      //Đã ra, chưa vào -> Vào
      if (!tempCard.gotInto!) {
        records[DateTimeIntl.dateTimeToString(now.toDate())] = 'in';
        dataUpdate = {
          'time_in': now,
          'records': records,
          'got_into': true,
        };
        data['time_in'] = now;
        data['records'] = records;
        data['got_into'] = true;
        //Đã vào -> Ra
      } else {
        records[DateTimeIntl.dateTimeToString(now.toDate())] = 'out';
        dataUpdate = {
          'time_in': null,
          'time_out': now,
          'records': records,
          'got_into': false,
        };
        data['time_in'] = null;
        data['time_out'] = now;
        data['records'] = records;
        data['got_into'] = false;
      }

      snapshot.docs.first.reference.update(dataUpdate);

      return Card.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
