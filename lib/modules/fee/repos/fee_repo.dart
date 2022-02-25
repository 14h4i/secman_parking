import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/fee/models/fee.dart';

class FeeRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> sendFee(DateTime timeOut, Card card, FeeType type) async {
    try {
      final fees = _firestore.collection('fees');

      final snapshot = await fees.doc('values').get();
      final values = snapshot.data();

      int fee = type == FeeType.day ? values!['day'] : values!['night'];

      fees.add({
        'fee': fee,
        'time_in': Timestamp.fromDate(card.timeIn!),
        'time_out': Timestamp.fromDate(timeOut),
        'photo': card.currentPhoto,
        'id': card.id,
        'type': type == FeeType.day ? 'day' : 'night',
        'collected': false,
      });
      return fee;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Fee>> getListFee() async {
    try {
      final snapshot = await _firestore.collection('fees').get();
      List<Fee> listFee = [];
      for (var fee in snapshot.docs) {
        if (fee.id != 'values') {
          Map<String, dynamic> temp = fee.data();
          temp['doc_id'] = fee.id;
          listFee.add(Fee.fromJson(temp));
        }
      }
      return listFee;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> collectFees(List<Fee> listFee) async {
    try {
      for (int i = 0; i < listFee.length; i++) {
        if (listFee[i].collected == false) {
          _firestore.collection('fees').doc(listFee[i].docId).update({
            'collected': true,
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
