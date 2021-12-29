enum FeeType { day, night }

class FeeUtil {
  static FeeType chargeFee(DateTime timeIn, DateTime timeOut) {
    if (timeOut.hour > 4 && timeOut.difference(timeIn).inHours > 3) {
      return FeeType.night;
    } else {
      return FeeType.day;
    }
  }
}
