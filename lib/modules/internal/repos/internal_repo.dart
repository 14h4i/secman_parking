import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';

class InternalRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Card?> scan(String id) async {
    try {
      final snapshot = await _firestore
          .collection('cards')
          .where('id', isEqualTo: id)
          .where('is_guest', isEqualTo: false)
          .limit(1)
          .get();
      if (snapshot.docs.isEmpty) {
        return null;
      }

      Map<String, dynamic> data = snapshot.docs.first.data();

      final now = Timestamp.now();

      List records = data['records'];

      Map<String, Object?> dataUpdate;

      records.add(now);
      final Timestamp previousTime = data['current_time'];
      dataUpdate = {
        'current_time': now,
        'previous_time': previousTime,
        'records': records,
      };
      data['current_time'] = now;
      data['previous_time'] = previousTime;
      data['records'] = records;

      snapshot.docs.first.reference.update(dataUpdate);

      return Card.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
