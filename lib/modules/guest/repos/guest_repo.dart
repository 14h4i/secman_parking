import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secman_parking/models/card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:secman_parking/utils/fee_util.dart';
import 'package:secman_parking/utils/random_util.dart';

class GuestRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Card?> getCard(String id) async {
    try {
      final snapshot = await _firestore
          .collection('cards')
          .where('id', isEqualTo: id)
          .where('is_guest', isEqualTo: true)
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

  Future<String?> upload(File file) async {
    try {
      final ref =
          _storage.ref().child('guest/${RandomUtil.getRandomString(8)}');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      final url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<DateTime> sendIn(String docId, String url) async {
    try {
      final now = Timestamp.now();

      final doc = _firestore.collection('cards').doc(docId);

      doc.update({
        'time_in': now,
        'current_photo': url,
      });

      doc.collection('records').add({
        'time': now,
        'status': 'in',
        'photo': url,
      });

      return now.toDate();
    } catch (e) {
      rethrow;
    }
  }

  Future<DateTime> sendOut(String docId, String url) async {
    try {
      final now = Timestamp.now();

      final doc = _firestore.collection('cards').doc(docId);

      doc.update({
        'time_out': now,
        'current_photo': null,
      });

      doc.collection('records').add({
        'time': now,
        'status': 'out',
        'photo': url,
      });

      return now.toDate();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendFee(DateTime timeOut, Card card, FeeType type) async {
    try {
      final fees = _firestore.collection('fees');

      final snapshot = await fees.doc('values').get();
      final values = snapshot.data();

      fees.add({
        'fee': type == FeeType.day ? values!['day'] : values!['night'],
        'time_in': Timestamp.fromDate(card.timeIn!),
        'time_out': Timestamp.fromDate(timeOut),
        'photo': card.currentPhoto,
        'id': card.id,
        'type': type == FeeType.day ? 'day' : 'night',
      });
    } catch (e) {
      rethrow;
    }
  }
}
