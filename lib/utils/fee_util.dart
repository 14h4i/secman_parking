class FeeUtil {
  static int chargeRangeTime(DateTime timeIn, DateTime timeOut) {
    return (timeOut.difference(timeIn).inSeconds / 3600).ceil();
  }
}
