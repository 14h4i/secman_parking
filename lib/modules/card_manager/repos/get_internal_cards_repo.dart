import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';

class GetInternalCardsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Card>?> get() async {
    try {
      final snapshot = await _firestore
          .collection('cards')
          .where('is_guest', isEqualTo: false)
          .get();

      final data = snapshot.docs;
      return data.map((e) => Card.fromJson(e.data())).toList();
    } catch (e) {
      rethrow;
    }
  }
}
