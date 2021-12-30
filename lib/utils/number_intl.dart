import 'package:intl/intl.dart';

class NumberIntl {
  static final _currencyFormatter = NumberFormat('#,##0', 'vi_VN');

  static String formatMoney(int number) {
    return _currencyFormatter.format(number);
  }
}
