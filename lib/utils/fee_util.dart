import 'package:secman_parking/modules/fee/models/fee.dart';

class FeeUtil {
  static FeeType chargeFee(DateTime timeIn, DateTime timeOut) {
    if (timeOut.hour > 4 && timeOut.difference(timeIn).inHours > 3) {
      return FeeType.night;
    } else {
      return FeeType.day;
    }
  }
}
