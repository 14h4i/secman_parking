import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';

class InternalRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DateTime> sendIn(String docId) async {
    try {
      final now = Timestamp.now();

      final doc = _firestore.collection('cards').doc(docId);

      doc.update({
        'time_in': now,
      });

      doc.collection('records').add({
        'time': now,
        'status': 'in',
      });

      return now.toDate();
    } catch (e) {
      rethrow;
    }
  }

  Future<DateTime> sendOut(String docId) async {
    try {
      final now = Timestamp.now();

      final doc = _firestore.collection('cards').doc(docId);

      doc.update({
        'time_out': now,
      });

      doc.collection('records').add({
        'time': now,
        'status': 'out',
      });

      return now.toDate();
    } catch (e) {
      rethrow;
    }
  }

  Future<Card?> getCard(String id) async {
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
      data['doc_id'] = snapshot.docs.first.id;

      return Card.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
