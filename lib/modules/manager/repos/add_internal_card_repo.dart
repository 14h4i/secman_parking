import 'package:cloud_firestore/cloud_firestore.dart';

class AddInternalCardRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> add(String id, String vehicleOwner, String phoneNumber,
      String unit, String vehicleType, String vehicleNumber) async {
    try {
      _firestore.collection('cards').add({
        'id': id,
        'vehicle_owner': vehicleOwner,
        'phone_number': phoneNumber,
        'vehicle_type': vehicleType,
        'vehicle_number': vehicleNumber,
        'current_photo': null,
        'current_time': null,
        'previous_time': null,
        'is_guest': false,
        'records': [],
        'unit': unit,
      });
    } catch (e) {
      rethrow;
    }
  }
}
