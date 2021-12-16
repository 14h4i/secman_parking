import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static Future<void> showShortToast(String msg) async {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
