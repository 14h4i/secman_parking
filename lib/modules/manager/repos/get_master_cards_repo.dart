import 'package:cloud_firestore/cloud_firestore.dart';

class GetMasterCardsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> check(String id) async {
    try {
      final snapshot = await _firestore
          .collection('master_cards')
          .where('id', isEqualTo: id)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
