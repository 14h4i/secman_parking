import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';

class ScanInternalCardRepo {
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

      final data = snapshot.docs.first.data();

      return Card.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
