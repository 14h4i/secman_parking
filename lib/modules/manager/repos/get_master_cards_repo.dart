import 'package:cloud_firestore/cloud_firestore.dart';

class GetMasterCardsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>?> get() async {
    try {
      final snapshot = await _firestore.collection('master_cards').get();

      final data = snapshot.docs;
      return data.map((e) => e.data()['id'].toString()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
