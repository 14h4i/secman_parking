import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';

class DataCardRepo {
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
      data['doc'] = snapshot.docs.first.id;

      Card card = Card.fromJson(data);

      Map<String, Object?> newData;
      if (card.timeIn == null) {
        newData = {
          'time_in': Timestamp.now(),
          'time_out': null,
        };
      } else {
        newData = {
          'time_in': null,
          'time_out': Timestamp.now(),
        };
      }

      snapshot.docs.first.reference.update(newData);
    } catch (e) {
      rethrow;
    }
  }
}
