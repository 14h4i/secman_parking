import 'package:intl/intl.dart';

const dateFormat = "dd/MM/yyyy HH:mm:ss";

class DateTimeIntl {
  static bool checkTimeNow(String time, int earlier, int later) {
    DateTime dateTime = DateFormat(dateFormat).parse(time);
    var now = DateTime.now();
    var early = dateTime.subtract(Duration(minutes: earlier));

    var late = dateTime.add(Duration(minutes: later));
    bool checkTime = (early.isBefore(now) && late.isAfter(now)) ? true : false;
    return checkTime;
  }

  static DateTime stringToDateTime(String strTime) {
    return DateFormat(dateFormat).parse(strTime);
  }

  static DateTime stringToDateTimeCustom(String strTime, String dateFormat) {
    return DateFormat(dateFormat).parse(strTime);
  }

  static String dateTimeToString(DateTime dateTime) {
    return DateFormat(dateFormat).format(dateTime);
  }

  static String dateTimeToStringCustom(DateTime dateTime, String dateFormat) {
    return DateFormat(dateFormat).format(dateTime);
  }

  static String dateTimeToStringCustomVi(DateTime dateTime, String dateFormat) {
    return DateFormat(dateFormat, 'vi').format(dateTime);
  }

  static String dateTimeNowToString() {
    return DateFormat(dateFormat).format(DateTime.now());
  }

  static String dateTimeNowToStringCustom(String dateFormat) {
    return DateFormat(dateFormat).format(DateTime.now());
  }
}
